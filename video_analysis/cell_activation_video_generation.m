grayscale_range = 256;
image_height = 40;
image_width = 60;
video_length = 100; %# frames
%random matrix on the grayscale
initial_state = grayscale_range*rand(image_height,image_width);
%next we'll take the values and slowly increase the low values and decrease
%the high values to imitate activation and deactivation and add to a matrix
video_matrix = zeros(image_height,image_width,1);
video_matrix(:,:,1) = initial_state;
normalpd = makedist('Normal','mu',grayscale_range/2,'sigma',grayscale_range/5);
for n = 2:video_length
    prev_state = video_matrix(:,:,n-1);
    new_state = arrayfun(@(x) activ(x, normalpd, grayscale_range), prev_state);
    video_matrix(:,:,n) = new_state;
end
%now that we have a video matrix, we can render the video
v = VideoWriter('cell_activation.avi', 'Grayscale AVI'); %create video object
open(v); %open file
for m = 1:video_length
    writeVideo(v,uint8(video_matrix(:,:,m)));
end
close(v);

function y = activ(x, normalpd, grayscale_range)
    p = cdf(normalpd,x);
    if (p < 0.8)
        y = x + 5*p;
    else
        y = grayscale_range*rand();
    end
end