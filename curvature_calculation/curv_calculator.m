function curv=curv_calculator(curv_path)
    %This function calculates the curvature for any nx2 matrix (curv_path)
    %of points defining some curve such that (:,1) are the x-coordinates of
    %the points, and (:,2) are the y-coordinates of the points.
    num_pt = length(curv_path);
    curv = zeros(num_pt,1); %initialize the matrix to which we will save the curvatures
    adj_points = (curv_path(1:end-1,:) + curv_path(2:end,:))./2; %find adjacent points
    tan_slopes = diff(curv_path(:,2))./diff(curv_path(:,1)); %store the slopes of tangent lines
    orth_slopes = -1*ones(size(tan_slopes))./tan_slopes;
    for j = 2:num_pt-2
        cur_point = curv_path(j,:);
        adj_pt1 = adj_points(j-1,:); %adjacent point 1
        adj_pt2 = adj_points(j,:); %adjacent point 2
        f = @(x) orth_slopes(j-1)*(x - adj_pt1(1,1)) + adj_pt1(1,2); %orthogonal line to adjacent point 1
        g = @(x) orth_slopes(j)*(x - adj_pt2(1,1)) + adj_pt2(1,2); %orthogonal line to adjacent point 2
        x_start = 0.5*min([cur_point(1,1),adj_pt1(1,1),adj_pt2(1,1)]);
        try
            x_zero = fzero(@(x) f(x)-g(x),x_start); %the zero of f(x) - g(x) is our intersection point
            y_zero = f(x_zero); %now we have the y-value for our circle's midpoint
            d1 = sqrt((y_zero - cur_point(1,2))^2 + (x_zero - cur_point(1,1))^2);
            d2 = sqrt((y_zero - adj_pt1(1,2))^2 + (x_zero - adj_pt1(1,1))^2);
            d3 = sqrt((y_zero - adj_pt2(1,2))^2 + (x_zero - adj_pt2(1,1))^2);
            R = (d1 + d2 + d3)/3; %average distance to our curve will be our radius
            y_diff = y_zero - cur_point(1,2);
            if y_diff < 0 %if the center of the osculating circle is below the point, we have a downward facing curve
                curv(j,1) = -1/R;
            else
                curv(j,1) = 1/R;
            end
        catch
            curv(j,1) = NaN;
        end
    end
end