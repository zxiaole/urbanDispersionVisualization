function gralGeo = readGeometry(fullName)
% Feb. 20, Xiaole Zhang
% Load the GRAL geomtry
% Generate the coordinates

fid = fopen(fullName);
gralGeo.nkk = fread(fid,1,'int');
gralGeo.njj = fread(fid,1,'int');
gralGeo.nii = fread(fid,1,'int');
gralGeo.ikooagral = fread(fid,1,'int');
gralGeo.jkooagral = fread(fid,1,'int');
gralGeo.dzk = fread(fid,1,'float');
gralGeo.stretch = fread(fid,1,'float');
gralGeo.ahmin = fread(fid,1,'float');
tmp = fread(fid,(gralGeo.njj+1)*(gralGeo.nii+1)*3,'float');
tmp =reshape(tmp, 3, (gralGeo.njj+1)*(gralGeo.nii+1));
gralGeo.ahk = reshape(tmp(1,:), gralGeo.njj+1, []); % total height including terrain and building
gralGeo.buiheight = reshape(tmp(3,:), gralGeo.njj+1, []); 
gralGeo.surface = gralGeo.ahk-gralGeo.buiheight; % terrain height;
strechFactors = gralGeo.stretch.^(0:gralGeo.nkk-1); 
ztmp = gralGeo.ahmin + [0 cumsum(gralGeo.dzk*strechFactors)]; % z coordinate
xtmp = 0:gralGeo.nii;
ytmp = 0:gralGeo.njj;
[gralGeo.x,gralGeo.y,gralGeo.z] = meshgrid(xtmp, ytmp, ztmp);
fclose(fid);
end

