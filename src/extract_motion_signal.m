function motion = extract_motion_signal(mask)
% EXTRACT_MOTION_SIGNAL
%
% Extracts tumour motion from a cine-MRI binary mask sequence.
%
% INPUT
%   mask : H × W × T binary tumour masks
%
% OUTPUT
%   motion : structure containing
%       .Frame          Frame numbers
%       .X              X centroid
%       .Y              Y centroid
%       .Displacement   Frame-to-frame displacement (pixels)
%       .Distance       Cumulative travelled distance (pixels)
%
% Example
%   motion = extract_motion_signal(mask);

[~,~,T] = size(mask);

X = NaN(T,1);
Y = NaN(T,1);

%% Extract centroid from every frame

for t = 1:T

    c = extract_tumor_centroid(mask(:,:,t));

    X(t) = c(1);
    Y(t) = c(2);

end

%% Frame-to-frame displacement

Displacement = zeros(T,1);

for t = 2:T

    dx = X(t)-X(t-1);
    dy = Y(t)-Y(t-1);

    Displacement(t) = hypot(dx,dy);

end

%% Cumulative travelled distance

Distance = cumsum(Displacement);

%% Store results

motion.Frame = (1:T)';
motion.X = X;
motion.Y = Y;
motion.Displacement = Displacement;
motion.Distance = Distance;

end