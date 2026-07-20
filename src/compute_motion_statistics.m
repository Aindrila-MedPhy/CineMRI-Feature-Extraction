function stats = compute_motion_statistics(motion)
% COMPUTE_MOTION_STATISTICS
%
% Computes summary statistics from a tumour motion signal.
%
% INPUT
%   motion : structure returned by extract_motion_signal()
%
% OUTPUT
%   stats : structure containing motion statistics
%
% Example
%   motion = extract_motion_signal(mask);
%   stats = compute_motion_statistics(motion);

% Extract variables
X = motion.X;
Y = motion.Y;
D = motion.Displacement;

%% Mean centroid position

stats.MeanX = mean(X,'omitnan');
stats.MeanY = mean(Y,'omitnan');

%% Standard deviation

stats.StdX = std(X,'omitnan');
stats.StdY = std(Y,'omitnan');

%% Motion range

stats.RangeX = max(X)-min(X);
stats.RangeY = max(Y)-min(Y);

%% Frame-to-frame displacement

stats.MeanDisplacement = mean(D(2:end),'omitnan');
stats.MaxDisplacement  = max(D);

%% Total travelled distance

stats.TotalDistance = sum(D);

%% Number of frames

stats.NumFrames = length(X);

end