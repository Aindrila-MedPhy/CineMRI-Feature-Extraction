function overlay_tumor_mask(image2D, mask2D)
% OVERLAY_TUMOR_MASK

% Displays a cine-MRI frame with the tumour boundary and centroid overlaid.

% INPUT
% image2D : 2D MRI image
% mask2D  : 2D binary tumour mask

% Example
% overlay_tumor_mask(img(:,:,1),mask(:,:,1))

% Check input size
if ~isequal(size(image2D),size(mask2D))
    error('Image and mask must have the same size.');
end

% Convert mask to logical
mask2D = logical(mask2D);

% Display image
figure
imshow(image2D,[])
hold on

% Plot tumour boundary
B = bwboundaries(mask2D);

for k = 1:length(B)

    boundary = B{k};

    plot(boundary(:,2),boundary(:,1),...
        'r','LineWidth',2)

end

% Plot centroid

C = extract_tumor_centroid(mask2D);

S = extract_shape_features(mask2D);

text(10,20,...
    sprintf('Area : %.0f pixels',S.Area),...
    'Color','y',...
    'FontSize',12,...
    'FontWeight','bold');

plot(C(1),C(2),...
    'yo',...
    'MarkerSize',10,...
    'MarkerFaceColor','y')

title(sprintf('Frame Overlay  |  Centroid = (%.1f, %.1f)',...
    C(1),C(2)));

legend({'Tumour Boundary','Centroid'},...
    'Location','best')

hold off

end