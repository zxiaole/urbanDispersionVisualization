function windData = getGralWind(fullPath)
% windData = getGralWind(fullpath)
% Feb. 21, Xiaole Zhang
% Load the GRAL wind data

fid = fopen(fullPath, 'r');
try
    cellN = fread(fid, 3, 'int');
    nz = cellN(1);
    ny = cellN(2);
    nx = cellN(3);
    
    windData.direction = fread(fid,1, 'float');
    windData.speed = fread(fid,1, 'float');
    windData.stability = fread(fid, 1, 'int');
    windData.cellsize = fread(fid, 1, 'float');
    windData.header = fread(fid, 1, 'int');
    
    windData.data = fread(fid, (nz+1)*(ny+1)*(nx+1)*3, 'int16');
    windData.data = reshape(windData.data*0.01, 3, nz+1, ny+1,nx+1);
    flagData = fread(fid);
    if(~isempty(flagData))
        error('Data number not correct')
    end
    
catch ME
    disp(ME)
end
fclose(fid);
windData.data = permute(windData.data, [1,3,4,2]);
end

