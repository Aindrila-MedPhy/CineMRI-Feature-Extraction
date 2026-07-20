function features = extract_shape_features(mask2D)
% EXTRACT_SHAPE_FEATURES
%
% Extracts geometric shape features from the largest connected
% tumour region in a 2D binary segmentation mask.
%
% INPUT
%   mask2D : 2D binary tumour mask
%
% OUTPUT
%   features : structure containing
%       .Area
%       .Perimeter
%       .Circularity
%       .Eccentricity
%       .MajorAxisLength
%       .MinorAxisLength
%       .Solidity
%       .Extent
%
% Example
%   features = extract_shape_features(mask(:,:,1));

% Convert to logical
mask2D = logical(mask2D);

% Measure connected components
stats = regionprops(mask2D,...
    'Area',...
    'Perimeter',...
    'Eccentricity',...
    'MajorAxisLength',...
    'MinorAxisLength',...
    'Solidity',...
    'Extent');

% Empty mask
if isempty(stats)

    features.Area = NaN;
    features.Perimeter = NaN;
    features.Circularity = NaN;
    features.Eccentricity = NaN;
    features.MajorAxisLength = NaN;
    features.MinorAxisLength = NaN;
    features.Solidity = NaN;
    features.Extent = NaN;

    return

end

% Largest connected component
[~,idx] = max([stats.Area]);

S = stats(idx);

% Store features
features.Area = S.Area;
features.Perimeter = S.Perimeter;

features.Circularity = ...
    4*pi*S.Area/(S.Perimeter^2);

features.Eccentricity = S.Eccentricity;
features.MajorAxisLength = S.MajorAxisLength;
features.MinorAxisLength = S.MinorAxisLength;
features.Solidity = S.Solidity;
features.Extent = S.Extent;

end