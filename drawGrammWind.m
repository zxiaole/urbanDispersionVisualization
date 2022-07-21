%%
% Feb. 20, 2020, Xiaole Zhang
% Read wind data from .wnd
% Draw the wind flow field
%%
clear
close all
%% set Gramm 
[Gramm,sourceNum] = setGrammConfig();
[Gral,sourceNum] = setGralConfig();
fontsize =12;
%% basic configurations
categoryId = 1;
monitorHeight = 3; % height above ground

filename = [num2str(categoryId,'%05d') '.wnd'];
fid = fopen(filename, 'r');
Gramm.header = fread(fid,1, 'int');
Gramm.ni = fread(fid,1, 'int');
Gramm.nj = fread(fid,1, 'int');
Gramm.nk = fread(fid,1, 'int');
Gramm.horgridsize = fread(fid,1, 'float');
Gramm.wind = fread(fid,Gramm.ni*Gramm.nj*Gramm.nk*3, 'int16');
flagData = fread(fid);
if(~isempty(flagData))
    error('Data number not correct')
end
fclose(fid)
%%
coords = importdata('backmap.jgw');
img = imread('backmap.jpg');
img = repmat(uint8(mean(img,3)),1,1,3);
[im.ny, im.nx, im.nz] = size(img);
im.orgx = coords(5);
im.orgy = coords(6);
im.size = coords(1);
im.x = im.orgx:im.size:im.orgx+(im.nx-1)*im.size;
im.y = im.orgy:-im.size:im.orgy-(im.ny-1)*im.size;
imagesc(im.x, im.y, img, 'alphadata', 0.75)
hold on
%%
axis xy
axis equal
Gramm.wind = reshape(Gramm.wind, 3, Gramm.nk, Gramm.nj, Gramm.ni);
set(gca, 'fontname', 'arial', 'fontsize', fontsize);
rectangle('Position',[Gral.xllcorner Gral.yllcorner, max(Gral.xll(:))-min(Gral.xll(:)), max(Gral.yll(:))-min(Gral.yll(:))], 'linewidth', 1.5)
xlabel('West-East (m)')
ylabel('South-North (m)')

d=2;
streakarrow(Gramm.xll(1:d:end,1:d:end),Gramm.yll(1:d:end,1:d:end),  squeeze(Gramm.wind(1,1,1:d:end,1:d:end))/100, squeeze(Gramm.wind(2,1,1:d:end,1:d:end))/100, 1, 1)
set(gca, 'xlim', [2.26*10^5 2.46*10^5]);
streakbar(Gramm.xll(1:d:end,1:d:end),Gramm.yll(1:d:end,1:d:end),  squeeze(Gramm.wind(1,1,1:d:end,1:d:end))/100, squeeze(Gramm.wind(2,1,1:d:end,1:d:end))/100, 'm/s')
axis xy