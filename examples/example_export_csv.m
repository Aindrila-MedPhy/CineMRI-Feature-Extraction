clc
clear
close all

%% =====================================================
% Example : Export cine-MRI tumour features to CSV
% =====================================================

image_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/images/A_005_frames.mha';

mask_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/targets/A_005_labels.mha';

%% Load image

img = mha_read_volume(image_file);
img = permute(img,[2 3 1]);

%% Load mask

mask = mha_read_volume(mask_file);
mask = permute(mask,[2 3 1]);

%% Export

T = export_features_csv(mask,'A005_features.csv');

%% Display first 10 rows

disp(T(1:10,:))