function windSliceData = windgetWindAtCertainHeight(gralGeo, monitorHeight, windData)
% windSliceData = windgetWindAtCertainHeight(gralGeo, monitorHeight, windData)
% Feb. 21, 2020, Xiaole Zhang
% get the wind vectors at a certain height above ground
z = gralGeo.surface + monitorHeight;
xtmp = 0:gralGeo.nii;
ytmp = 0:gralGeo.njj;
[x, y] = meshgrid(xtmp, ytmp);
windSliceData = zeros(3, gralGeo.njj+1, gralGeo.nii+1);
for i=1:3
    windSliceData(i,:,:) = interp3(gralGeo.x,gralGeo.y,gralGeo.z,squeeze(windData(i,:,:,:)), x, y, z);
end
end

