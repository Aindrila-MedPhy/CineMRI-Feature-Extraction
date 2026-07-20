clc
clear
close all

%% ==========================================================
% Example : Shape feature extraction from cine-MRI
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

[H,W,T] = size(mask);

fprintf('Frames : %d\n',T);

%% Allocate arrays

Area          = NaN(T,1);
Perimeter     = NaN(T,1);
Circularity   = NaN(T,1);
Eccentricity  = NaN(T,1);

%% Loop over frames

for t = 1:T

    F = extract_shape_features(mask(:,:,t));

    Area(t)         = F.Area;
    Perimeter(t)    = F.Perimeter;
    Circularity(t)  = F.Circularity;
    Eccentricity(t) = F.Eccentricity;

end

%% Display first five frames

disp(table((1:5)',...
    Area(1:5),...
    Perimeter(1:5),...
    Circularity(1:5),...
    Eccentricity(1:5),...
    'VariableNames',...
    {'Frame','Area','Perimeter','Circularity','Eccentricity'}))

%% Plot Area

figure

plot(Area,'LineWidth',2)

xlabel('Frame')
ylabel('Tumour Area (pixels)')
title('Tumour Area')

grid on

%% Plot Circularity

figure

plot(Circularity,'LineWidth',2)

xlabel('Frame')
ylabel('Circularity')
title('Tumour Circularity')

grid on