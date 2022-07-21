function [Gramm,sourceNum] = setGrammConfig()
%[Gral,sourceNum] = setGralConfig()
%   Dec. 22, Xiaole
% set the parameters of GRAMM
Gramm.ncols = 67;
Gramm.nrows = 40;
Gramm.xllcorner = 225900;
Gramm.yllcorner = 3384300;
Gramm.cellsize = 300;
sourceNum = 2;

xll =Gramm. xllcorner:Gramm.cellsize:(Gramm.xllcorner+Gramm.ncols*Gramm.cellsize-Gramm.cellsize);
yll = Gramm.yllcorner:Gramm.cellsize:(Gramm.yllcorner+Gramm.nrows*Gramm.cellsize-Gramm.cellsize);
[xll, yll] = meshgrid(xll, (yll));
Gramm.xll = xll;
Gramm.yll = yll;

Gramm.windx = (0:Gramm.ncols)*Gramm.cellsize + Gramm.xllcorner;
Gramm.windy = (0:Gramm.nrows)*Gramm.cellsize + Gramm.yllcorner;
end

