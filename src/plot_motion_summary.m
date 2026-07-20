function plot_motion_summary(motion)
% PLOT_MOTION_SUMMARY
%
% Creates a summary figure showing tumour motion.
%
% INPUT
%   motion : structure returned by extract_motion_signal()
%
% Example
%   motion = extract_motion_signal(mask);
%   plot_motion_summary(motion);

figure('Color','w','Position',[100 100 1000 700]);

%% -------------------------------------------------------
% X Motion
%% -------------------------------------------------------

subplot(2,2,1)

plot(motion.Frame,motion.X,...
    'r','LineWidth',2)

xlabel('Frame')
ylabel('X Position (pixels)')
title('X Motion')

grid on
box on

%% -------------------------------------------------------
% Y Motion
%% -------------------------------------------------------

subplot(2,2,2)

plot(motion.Frame,motion.Y,...
    'b','LineWidth',2)

xlabel('Frame')
ylabel('Y Position (pixels)')
title('Y Motion')

grid on
box on

%% -------------------------------------------------------
% Displacement
%% -------------------------------------------------------

subplot(2,2,3)

plot(motion.Frame,...
    motion.Displacement,...
    'k','LineWidth',2)

xlabel('Frame')
ylabel('Displacement (pixels)')
title('Frame-to-Frame Displacement')

grid on
box on

%% -------------------------------------------------------
% Tumour trajectory
%% -------------------------------------------------------

subplot(2,2,4)

plot(motion.X,...
     motion.Y,...
     '-o',...
     'LineWidth',1.5,...
     'MarkerSize',3)

set(gca,'YDir','reverse')

xlabel('X Position (pixels)')
ylabel('Y Position (pixels)')

title('Tumour Trajectory')

axis equal
grid on
box on

sgtitle('Tumour Motion Summary','FontSize',14,'FontWeight','bold')

end