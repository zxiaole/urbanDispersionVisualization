%% Dec. 5, Xiaole Zhang
% read the plant coverage data for each province
clear
close all
regionId =15;
xllcorner = 236116;
yllcorner  =   3389950;
scenarioId = 1;%63;
sourceIdT = 1;
sourceIntensity = 25;%15
heights = [1.5 5 10 20 40 80 120 200 300];
figure('Position',[1 1 800 600])
hold on
dir = 'wuhan building';
filename ='building_test7.shp';
f = fullfile(dir,filename);
%%
[Gral,sourceNum] = setGralConfig();
allConc = zeros(Gral.nrows, Gral.ncols, 9);

for sourceId = sourceIdT
    for layerId =1:9
        concTmp = getGralConc(scenarioId,sourceId, Gral, layerId);
        concTmp = squeeze(concTmp(:,:,sourceId));
        allConc(:,:,layerId) = flipud(concTmp);
    end
    allConc = allConc*10^-9*sourceIntensity;
    x = (1:Gral.ncols)*Gral.cellsize;
    y = (1:Gral.nrows)*Gral.cellsize;
    [x, y, z] = meshgrid(x, y, heights);
    
    %%
    
    p = patch(isosurface(x,y,z,allConc,0.0075/5000), ...
        'FaceVertexCData',[0 1 0],'FaceColor','flat', 'EdgeColor', 'none', 'FaceAlpha', 0.8);
end
% [I, R] = geotiffread('coverage.tif');

info = shapeinfo(f);
roi = shaperead(f);

for regionId=1:length(roi)
    rx = roi(regionId).X(1:end-1) - xllcorner;
    ry = roi(regionId).Y(1:end-1) - yllcorner;
    rheight = roi(regionId).height;
    
    for faceId = 1:length(rx)-1
        vert = [rx(faceId) ry(faceId) 0;
            rx(faceId+1) ry(faceId+1) 0;
            rx(faceId+1) ry(faceId+1) rheight;
            rx(faceId) ry(faceId) rheight];
        fac = [1 2 3 4];
        patch('Vertices',vert,'Faces',fac,...
            'FaceVertexCData',hsv(1),'FaceColor','flat', 'EdgeColor', 'none');
    end
    
    % top surface
    vert = [rx(1:end-1)' ry(1:end-1)' ones(size(ry(1:end-1)'))*rheight];
    fac = 1:size(vert,1);
    patch('Vertices',vert,'Faces',fac,...
        'FaceVertexCData',hsv(1),'FaceColor','flat', 'EdgeColor', 'none');
    
end

material shiny
axis equal
set(gca, 'xlim', [800 1100], 'ylim', [600 895])

hl = camlight('right');
hl.Style = 'infinite';
% view(50,80)
if(sourceId==2)
    view(45,30)
else
    view(-95,35)
end
xlabel('West-East (m)')
ylabel('South-North (m)')
zlabel('Height (m)')
set(gca, 'fontname', 'arial', 'fontsize', 16)
set(gcf,'PaperPositionMode','auto')
print(['3dConc_' num2str(scenarioId)],'-dpng','-r300')