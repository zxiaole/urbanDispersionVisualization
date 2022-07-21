%%
% Feb. 20, 2020, Xiaole Zhang
% Read wind data from .gff
% Draw the wind flow field
%%
clear
close all
%% basic configurations
uncompressFlag = 1;
plotFlag = 1;
resultsFolder = 'winddata';
extractFolder = 'windExtract';
categoryId = 1;
monitorHeight = 3; % height above ground
shapefileName = 'wuhan building/building_test7.shp';

load buildingFactor.mat

%% load Gral configurations
[Gral,sourceNum] = setGralConfig();

%% load geometries
geometryFileName = fullfile(resultsFolder, 'GRAL_geometries.bin');
gralGeo = readGeometry(geometryFileName);

%% uncompress gff data
for categoryId = 1
    disp(categoryId)
    filename = [num2str(categoryId,'%05d') '.gff'];
    fullPath = fullfile(resultsFolder, filename);
    % meteoFrequency = meteoCategories(categoryId, 4);
    if(uncompressFlag)
        unzip(fullPath, extractFolder);
    end
    
    %% Read data
    fullPathData = fullfile(extractFolder, filename);
    windData = getGralWind(fullPathData);
    
    %% Get the wind at certain height
    windSliceData = windgetWindAtCertainHeight(gralGeo, monitorHeight, windData.data);
    wu = squeeze(windSliceData(1,:,:));
    wv = squeeze(windSliceData(2,:,:));
    wx = Gral.windx-Gral.xllcorner;
    wy = Gral.windy-Gral.yllcorner;
    wspeed = sqrt(wu.^2+wv.^2);
    
    %% draw
    if(plotFlag)
        figure('Position',[1 1 800 600])
        hold on
        d=3;
        
        % imagesc(wx, wy, wspeed)
        
        draw2dBuilding(Gral, shapefileName);
%         hq = quiver(wx(1:d:end), wy(1:d:end), ...
%             squeeze(wu(1:d:end,1:d:end)), squeeze(wv(1:d:end,1:d:end)), 3, 'color', 'b');
%         
iddx = 400:d:510;
iddy = 280:d:400;
        [xt , yt] = meshgrid(wx(iddx), wy(iddy));
streakarrow(xt,yt,   squeeze(wu(iddy, iddx)),  squeeze(wv(iddy, iddx)), 1, 1)
% set(gca, 'xlim', [2.26*10^5 2.46*10^5]);


        box on
        % set(hq,'AutoScale','on', 'AutoScaleFactor', 2)
        axis equal
        set(gca, 'xlim', [850 1000], 'ylim', [600 780])
        
%         rectangle('position', [leftBox(1,1) leftBox(2,1) leftBox(1,2)-leftBox(1,1) leftBox(2,2)-leftBox(2,1)], 'edgecolor', 'k', 'linestyle','--', 'linewidth',4)
%         rectangle('position', [rightBox(1,1) rightBox(2,1) rightBox(1,2)-rightBox(1,1) rightBox(2,2)-rightBox(2,1)], 'edgecolor', 'k', 'linestyle','--', 'linewidth',4)
        xlabel('West-East (m)')
        ylabel('South-North (m)')
        
        set(gca, 'fontname', 'arial', 'fontsize', 18)
        streakbar(xt,yt,   squeeze(wu(iddy, iddx)),  squeeze(wv(iddy, iddx)), 'm/s')
set(gca, 'fontname', 'arial', 'fontsize', 18)
set(gcf,'PaperPositionMode','auto')
print('wind','-dpng','-r300')
    end
    %% calculate angles
    [xwf, ywf] = meshgrid(wx, wy);
    idleft = xwf>=leftBox(1,1)&xwf<=leftBox(1,2)&ywf>=leftBox(2,1)&ywf<=leftBox(2,2);
    idright = xwf>=rightBox(1,1)&xwf<=rightBox(1,2)&ywf>=rightBox(2,1)&ywf<=rightBox(2,2);
    
    % Calculate wind vector
    windRight = [mean(mean(wu(idright))) mean(mean(wv(idright)))];
    windLeft = [mean(mean(wu(idleft))) mean(mean(wv(idleft)))];
    windSpeedRight(categoryId)=norm(windRight);
    windSpeedLeft(categoryId)=norm(windLeft);
    
    
    windLeft = windLeft/norm(windLeft);
    windRight = windRight/norm(windRight);
    
    % calculate attack angle
    attackAngleRight(categoryId) = acos(windRight*rightVector);
    attackAngleLeft(categoryId) = acos(windLeft*leftVector);
    
    delete(fullPathData)
end
% save windData.mat windSpeedRight windSpeedLeft attackAngleRight attackAngleLeft