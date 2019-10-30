%% Part 1: Import video into matrix
v = VideoReader('cell_activation.avi'); %importer of video will be in grayscale
video = [];
n = 1;
while hasFrame(v)
    video(:,:,n) = readFrame(v); %convert video to a matrix
    n = n+1;
end

%% Part 2: Reduce the size of the matrices for each time frame by averaging
%each 2x2 pixel area
[height, width, length] = size(video);
reducedvideo = zeros(height/2,width/2,length);
for m = 1:length
    convimage = conv2(video(:,:,m),[1,1;1,1],'valid');
    oddsimage = convimage(1:2:end,1:2:end);
    reducedimage = oddsimage/4;
    reducedvideo(:,:,m) = reducedimage;
end
[newheight, newwidth, newlength] = size(reducedvideo);
%To visualize the new reduced video we'll output a new .avi file
v = VideoWriter('cell_activation_reduced.avi', 'Grayscale AVI'); %create video object
open(v); %open file
for k = 1:length
    writeVideo(v,uint8(reducedvideo(:,:,k)));
end
close(v);

%% Part 3: Visualize the changes in activation per 'cell' over time
for h = 1:newheight
    for i = 1:newwidth
        subplot(newheight,newwidth,(h-1)*newwidth + i);
        vector = squeeze(reducedvideo(h,i,:))';
        x = linspace(1,newlength);
        plot(x,vector);
        set(gca,'visible','off')
        set(gca,'XTick',[], 'YTick', [])
    end
end

%% Part 4: Determine properties of response for each 'cell'
%In the context of an experiment, the peak response times can be
%correlated with what stimulus is being presented. Other properties can be
%used to further inform questions.

cell_data = struct; %create a new structure containing all relevant cell information
for h = 1:newheight
    for i = 1:newwidth
        index = (h-1)*newwidth + i;
        vector = squeeze(reducedvideo(h,i,:))';
        [~, len] = size(vector);
        max_val = max(vector);
        [~, Locb] = ismember(max_val, vector); %determine the time of peak response
        cell_data(index).response = [1:len; vector]; %row 1 = times, row 2 = response
        cell_data(index).max_time = Locb; %store time of maximum response
        cell_data(index).max_response = vector(Locb); %store maximum strength of response
        cell_data(index).mean_response = mean(vector); %store the mean response strength
    end
end