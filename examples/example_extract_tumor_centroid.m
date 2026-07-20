clc
clear
close all

%% ==========================================================
% Example : Tumour centroid extraction from cine-MRI sequence
% ===========================================================

%% Load MRI

image_file = 'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/images/A_005_frames.mha';

img = mha_read_volume(image_file);
img = permute(img,[2 3 1]);

%% Load tumour masks

mask_file = 'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/targets/A_005_labels.mha';

mask = mha_read_volume(mask_file);
mask = permute(mask,[2 3 1]);

%% Image information

[H,W,T] = size(mask);

fprintf('Image size : %d x %d\n',H,W);
fprintf('Frames     : %d\n',T);

%% Extract centroid from every frame

centroids = NaN(T,2);

for t = 1:T

    centroids(t,:) = extract_tumor_centroid(mask(:,:,t));

end

%% Display first 10 centroids

disp(table((1:10)',...
    centroids(1:10,1),...
    centroids(1:10,2),...
    'VariableNames',{'Frame','X','Y'}))

%% Plot tumour motion

figure

plot(centroids(:,1),'r','LineWidth',1.8)
hold on
plot(centroids(:,2),'b','LineWidth',1.8)

xlabel('Frame')
ylabel('Centroid Position (pixels)')

legend('X','Y')
title('Tumour Centroid Motion')

grid on