%% Import data for peak analysis

load('/Users/hannahgermaine/Documents/Git/MATLAB_Data_Processing/probabilistic_peak_determination/generated_cell_data.mat'); %Modify this line to the directory of the generated_cell_data file

%Note the format of the data: each line represents a single cell's
%electrode readings. The array in 'responses' is defined as follows:
% Row 1: Presented values (in this case, they are spatial frequency values)
% Row 2: Mean responses to the presented values
% Row 3: Standard deviation of response to the presented values

%% Test for number of peaks

%Test the generated cell data for number of peaks based on a desired
%probability cutoff. The mathematics of the test can be found in the README
%file.

acuteness = 10000; %How many samples we will be taking. The larger, the better.
cutoff_prob = 0.99; %At what probability cutoff will we test the generated data?
[w_gen, l_gen] = size(generated_cell_data);
[~,num_sf] = size(generated_cell_data(1).responses);
for i = 1:l_gen
    cell_peaks = zeros(1,num_sf);
    [~, len_resp] = size(generated_cell_data(i).responses);
    if len_resp == num_sf %ensure that the data exists
        x_vals = generated_cell_data(i).responses(1,:);
        sf_mu = generated_cell_data(i).responses(2,:);
        sf_sd = generated_cell_data(i).responses(3,:);
        response_vals = zeros(acuteness,num_sf + 2);
        %Take the last SF response and place in first col to create
        %cyclical data
        response_vals(:,1) = sort(normrnd(sf_mu(num_sf),sf_sd(num_sf),[acuteness,1]));
        %Take the first SF response and place in last col to create
        %cyclical data
        response_vals(:,num_sf+2) = sort(normrnd(sf_mu(1),sf_sd(1),[acuteness,1]));
        for j = 1:num_sf
            response_vals(:,j+1) = sort(normrnd(sf_mu(j),sf_sd(j),[acuteness,1]));
        end
        left_subs = zeros(acuteness,num_sf);
        for k = 1:num_sf
            left_subs(:,k) = response_vals(:,k+1) - response_vals(:,k);
        end
        right_subs = zeros(acuteness,num_sf);
        for l = 2:num_sf+1
            right_subs(:,l-1) = response_vals(:,l) - response_vals(:,l + 1);
        end
        left_pos = left_subs > 0;
        right_pos = right_subs > 0;
        left_prob = sum(left_pos,1)/acuteness;
        right_prob = sum(right_pos,1)/acuteness;
        generated_cell_data(i).peak_probabilities = left_prob.*right_prob;
        likely = generated_cell_data(i).peak_probabilities > cutoff_prob;
        generated_cell_data(i).peak_count_likelihood = sum(likely);
        generated_cell_data(i).peak_pref = nonzeros(x_vals .* likely).'; %Determine and save at which SF the peaks exist=
    else
        generated_cell_data(i).peak_probabilities = NaN;
    end
end

%% Visualize the results of the above test

%Show a histogram of the results
histogram([generated_cell_data.peak_count_likelihood])
title('Histogram of Results')
ylabel('Number of Cells')
xlabel('Number of Peaks')

%show how many cells have 2 peaks - can be modified to any other value
peaks = 2;
disp(strcat('Probability cutoff = ', string(cutoff_prob)));
two_pred = generated_cell_data([generated_cell_data.peak_count_likelihood] == peaks);
[~, num_two_pred] = size(two_pred);
disp(strcat('Probability of',{' '},string(peaks),'-peaked = ', string(num_two_pred/acuteness)));