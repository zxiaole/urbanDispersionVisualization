function draw2dBuilding(Gral, shapefileName)
% draw2dBuilding(Gral, shapefileName)
%   Feb. 21, 2020, Xiaole Zhang
% Draw 2d building for wind

info = shapeinfo(shapefileName);
roi = shaperead(shapefileName);
h = [];
gray = ones(1,3)*0.8;
for regionId=1:length(roi)
    rx = roi(regionId).X(1:end-1) - Gral.xllcorner;
    ry = roi(regionId).Y(1:end-1) - Gral.yllcorner;
    rheight = roi(regionId).height;
    plot(rx(1:end), ry(1:end), 'k-', 'linewidth', 1.5);
     vert = [rx(1:end-1)' ry(1:end-1)' ones(size(ry(1:end-1)'))*rheight];
    fac = 1:size(vert,1);
    htmp = patch('Vertices',vert,'Faces',fac,...
       'FaceColor',gray, 'EdgeColor', gray, 'linewidth', 0.01);
% uistack(h,'bottom')
end

    
end

