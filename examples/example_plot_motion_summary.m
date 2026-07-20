clc
clear
close all

%% =====================================================
% Example : Motion Summary Figure
% =====================================================

image_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/images/A_005_frames.mha';

mask_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/targets/A_005_labels.mha';

%% Load MRI

img = mha_read_volume(image_file);
img = permute(img,[2 3 1]);

%% Load tumour mask

mask = mha_read_volume(mask_file);
mask = permute(mask,[2 3 1]);

%% Extract motion

motion = extract_motion_signal(mask);

%% Plot summary

plot_motion_summary(motion);