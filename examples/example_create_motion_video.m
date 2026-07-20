clc
clear
close all

%% =====================================================
% Example : Create Tumour Motion Video
% =====================================================

image_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/images/A_005_frames.mha';

mask_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/targets/A_005_labels.mha';

%% Load image stack

img = mha_read_volume(image_file);
img = permute(img,[2 3 1]);

%% Load mask stack

mask = mha_read_volume(mask_file);
mask = permute(mask,[2 3 1]);

%% Create video

create_motion_video(...
    img,...
    mask,...
    'A005_TumourMotion.mp4',...
    10);

disp('Video creation completed.');