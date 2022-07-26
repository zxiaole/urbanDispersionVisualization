%%
% Feb. 07, 2020
% Xiaole Zhang
% Visualize Wuhan Data
%%
figure
sourceIntensity = 10^5;
dir = '5 h';
fontsize = 12;


% filename = 'Mean_statistics_Bioaerosols_total_1.5m.txt';
% filename = 'Daymax_statistics_Bioaerosols_total_1.5m.txt';
filename = '98_98thprecentiles_Bioaerosols_total_1.5m.txt';
f = fullfile(dir,filename);
%%
data = importdata(f, ' ', 6);
tmp = regexp(data.textdata{5}, ' *', 'split');
cellsize = str2double(tmp{2});

conc = data.data;
[yn, xn] = size(conc);
x = (1:xn)*cellsize;
y = (1:yn)*cellsize;
% [x, y] = meshgrid(x,y);

% covert from mug m**-3 to kg m**-3
conc = conc*10^-9*sourceIntensity;

contourf(x, fliplr(y), log10(conc),-7:1:1,'linecolor', 'none')
axis equal
% axis ij
cb = colorbar;
colormap jet
barTicks = cb.Ticks;
for i=1:length(barTicks)
    cb.TickLabels{i} = ['10^{' num2str(barTicks(i)) '}'];
    cb.FontSize = fontsize;
    cb.FontName = 'Arial';
end

cb.Label.String = 'Droplet nuclei (# m^{-3})';
cb.Label.Rotation = 0;
cb.Label.Position = [0.8 2 0];
%%
set(gca, 'fontname', 'arial', 'fontsize', fontsize);
xlabel('West-East (m)', 'fontsize', fontsize);
ylabel('South-North (m)', 'fontsize', fontsize);
