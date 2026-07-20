clc
clear
close all

%% ==========================================================
% Example : Motion Statistics
% ==========================================================

image_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/images/A_005_frames.mha';

mask_file = ...
'D:/TrackRAD2025/trackrad2025_labeled_training_data/A_005/targets/A_005_labels.mha';

%% Load MRI

img = mha_read_volume(image_file);
img = permute(img,[2 3 1]);

%% Load Masks

mask = mha_read_volume(mask_file);
mask = permute(mask,[2 3 1]);

%% Extract motion

motion = extract_motion_signal(mask);

%% Compute statistics

stats = compute_motion_statistics(motion);

%% Display

fprintf('\n========== Motion Statistics ==========\n\n');

fprintf('Number of Frames           : %d\n',stats.NumFrames);

fprintf('Mean X Position (pixels)   : %.2f\n',stats.MeanX);
fprintf('Mean Y Position (pixels)   : %.2f\n',stats.MeanY);

fprintf('Std X (pixels)             : %.2f\n',stats.StdX);
fprintf('Std Y (pixels)             : %.2f\n',stats.StdY);

fprintf('Range X (pixels)           : %.2f\n',stats.RangeX);
fprintf('Range Y (pixels)           : %.2f\n',stats.RangeY);

fprintf('Mean Displacement (pixels) : %.3f\n',stats.MeanDisplacement);

fprintf('Maximum Displacement       : %.3f\n',stats.MaxDisplacement);

fprintf('Total Distance Travelled   : %.3f pixels\n',stats.TotalDistance);