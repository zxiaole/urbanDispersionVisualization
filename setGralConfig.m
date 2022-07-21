function [Gral,sourceNum] = setGralConfig()
%[Gral,sourceNum] = setGralConfig()
%   Dec. 14, Xiaole
% set the parameters of GRAL
Gral.ncols = 930;
Gral.nrows = 714;
Gral.xllcorner = 236116;
Gral.yllcorner = 3389950;
Gral.cellsize = 2;
sourceNum = 2;

xll =Gral. xllcorner:Gral.cellsize:(Gral.xllcorner+Gral.ncols*Gral.cellsize-Gral.cellsize);
yll = Gral.yllcorner:Gral.cellsize:(Gral.yllcorner+Gral.nrows*Gral.cellsize-Gral.cellsize);
[xll, yll] = meshgrid(xll, fliplr(yll));
Gral.xll = xll;
Gral.yll = yll;

Gral.windx = (0:Gral.ncols)*Gral.cellsize + Gral.xllcorner;
Gral.windy = (0:Gral.nrows)*Gral.cellsize + Gral.yllcorner;
end

