function centroid = extract_tumor_centroid(mask2D)
% EXTRACT_TUMOR_CENTROID
%
% Computes the centroid of the largest connected tumour region
% from a 2D binary segmentation mask.
%
% INPUT
%   mask2D : 2D binary tumour mask
%
% OUTPUT
%   centroid : [x y] centroid coordinates
%
% Example
%   centroid = extract_tumor_centroid(mask(:,:,1));

% Ensure binary mask
mask2D = logical(mask2D);

% Measure connected regions
stats = regionprops(mask2D,'Area','Centroid');

% No tumour present
if isempty(stats)
    centroid = [NaN NaN];
    return;
end

% Select the largest connected component
[~,idx] = max([stats.Area]);

% Return centroid
centroid = stats(idx).Centroid;

end