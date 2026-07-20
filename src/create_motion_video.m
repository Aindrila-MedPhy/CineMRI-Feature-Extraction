function create_motion_video(imageStack, maskStack, outputVideo, fps)
% CREATE_MOTION_VIDEO
%
% Creates an MP4 video showing tumour motion on cine-MRI.
%
% INPUTS
%   imageStack  : H x W x T cine-MRI image stack
%   maskStack   : H x W x T binary tumour masks
%   outputVideo : Output video filename (.mp4)
%   fps         : Frames per second (default = 10)
%
% Example:
% create_motion_video(img, mask, 'TumourMotion.mp4', 10);

if nargin < 4
    fps = 10;
end

if nargin < 3
    outputVideo = 'TumourMotion.mp4';
end

if ~isequal(size(imageStack),size(maskStack))
    error('Image stack and mask stack must have identical dimensions.');
end

[~,~,numFrames] = size(imageStack);

%% Create Video Writer

videoObj = VideoWriter(outputVideo,'MPEG-4');
videoObj.FrameRate = fps;
open(videoObj);

%% Fixed-size figure (important)

fig = figure(...
    'Color','w',...
    'Position',[100 100 700 700],...
    'Resize','off');

ax = axes('Parent',fig);

for t = 1:numFrames

    cla(ax)

    %% Show MRI

    imshow(imageStack(:,:,t),[],...
        'Parent',ax);
    hold(ax,'on')

    %% Tumour boundary

    B = bwboundaries(maskStack(:,:,t));

    for k = 1:length(B)

        boundary = B{k};

        plot(ax,...
            boundary(:,2),...
            boundary(:,1),...
            'r',...
            'LineWidth',2);

    end

    %% Centroid

    C = extract_tumor_centroid(maskStack(:,:,t));

    if ~isnan(C(1))

        plot(ax,...
            C(1),...
            C(2),...
            'yo',...
            'MarkerFaceColor','y',...
            'MarkerSize',8);

    end

    %% Shape features

    S = extract_shape_features(maskStack(:,:,t));

    text(ax,10,20,...
        sprintf('Frame : %d',t),...
        'Color','y',...
        'FontWeight','bold',...
        'FontSize',12);

    text(ax,10,40,...
        sprintf('Area : %.0f pixels',S.Area),...
        'Color','y',...
        'FontWeight','bold',...
        'FontSize',12);

    title(ax,'Tumour Motion Tracking')

    hold(ax,'off')

    drawnow

    %% Capture only the axes

    F = getframe(ax);

    %% Convert to RGB image

    RGB = frame2im(F);

    %% Write frame

    writeVideo(videoObj,RGB);

end

close(videoObj);

close(fig);

fprintf('\n=========================================\n');
fprintf('Video saved successfully.\n');
fprintf('Output : %s\n',outputVideo);
fprintf('Frames : %d\n',numFrames);
fprintf('=========================================\n');

end