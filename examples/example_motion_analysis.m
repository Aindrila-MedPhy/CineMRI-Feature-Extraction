clc
clear
close all

%% ==========================================================
% Example : Tumour motion extraction from cine-MRI
% ==========================================================

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

%% Extract motion

motion = extract_motion_signal(mask);

%% Display first 10 frames

disp(table(...
    motion.Frame(1:10),...
    motion.X(1:10),...
    motion.Y(1:10),...
    motion.Displacement(1:10),...
    motion.Distance(1:10),...
    'VariableNames',...
    {'Frame','X','Y','Displacement','Distance'}))

%% Plot X motion

figure

plot(motion.Frame,motion.X,'r','LineWidth',2)

xlabel('Frame')
ylabel('X Position (pixels)')
title('Tumour Motion in X')

grid on

%% Plot Y motion

figure

plot(motion.Frame,motion.Y,'b','LineWidth',2)

xlabel('Frame')
ylabel('Y Position (pixels)')
title('Tumour Motion in Y')

grid on

%% Plot displacement

figure

plot(motion.Frame,motion.Displacement,...
    'k','LineWidth',2)

xlabel('Frame')
ylabel('Displacement (pixels)')
title('Frame-to-Frame Displacement')

grid on

%% Plot cumulative distance

figure

plot(motion.Frame,motion.Distance,...
    'm','LineWidth',2)

xlabel('Frame')
ylabel('Distance (pixels)')
title('Cumulative Travelled Distance')

grid on

%% Plot tumour trajectory

figure

plot(motion.X,motion.Y,'b-o','LineWidth',1.5,...
    'MarkerSize',3)

set(gca,'YDir','reverse')

xlabel('X Position (pixels)')
ylabel('Y Position (pixels)')
title('Tumour Trajectory')

axis equal
grid on