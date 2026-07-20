function T = export_features_csv(mask,filename)
% EXPORT_FEATURES_CSV
%
% Extracts tumour motion and shape features from a cine-MRI mask
% sequence and exports them to a CSV file.
%
% INPUT
%   mask      : H x W x T binary mask sequence
%   filename  : output CSV filename
%
% OUTPUT
%   T : MATLAB table
%
% Example
%   T = export_features_csv(mask,'tumour_features.csv');

if nargin<2
    filename='tumour_features.csv';
end

[~,~,Tframes]=size(mask);

%% Motion

motion=extract_motion_signal(mask);

%% Allocate

Area            = NaN(Tframes,1);
Perimeter       = NaN(Tframes,1);
Circularity     = NaN(Tframes,1);
Eccentricity    = NaN(Tframes,1);
MajorAxis       = NaN(Tframes,1);
MinorAxis       = NaN(Tframes,1);
Solidity        = NaN(Tframes,1);
Extent          = NaN(Tframes,1);

%% Loop over frames

for t=1:Tframes

    S=extract_shape_features(mask(:,:,t));

    Area(t)=S.Area;
    Perimeter(t)=S.Perimeter;
    Circularity(t)=S.Circularity;
    Eccentricity(t)=S.Eccentricity;
    MajorAxis(t)=S.MajorAxisLength;
    MinorAxis(t)=S.MinorAxisLength;
    Solidity(t)=S.Solidity;
    Extent(t)=S.Extent;

end

%% Create table

T=table(...
    motion.Frame,...
    motion.X,...
    motion.Y,...
    motion.Displacement,...
    motion.Distance,...
    Area,...
    Perimeter,...
    Circularity,...
    Eccentricity,...
    MajorAxis,...
    MinorAxis,...
    Solidity,...
    Extent,...
    'VariableNames',...
    {'Frame',...
     'CentroidX',...
     'CentroidY',...
     'Displacement',...
     'CumulativeDistance',...
     'Area',...
     'Perimeter',...
     'Circularity',...
     'Eccentricity',...
     'MajorAxisLength',...
     'MinorAxisLength',...
     'Solidity',...
     'Extent'});

%% Write CSV

writetable(T,filename);

fprintf('\nCSV exported successfully.\n');
fprintf('File : %s\n',filename);

end