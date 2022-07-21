%%
% Feb. 21, 2020 Xiaole Zhang
% 1. calcualate the normal vector of the extrances (inward direction)
% 2. define the region to calculate wind field
%%
buildingVector = [871.8 724.7] -[886.8 666];
buildingVector = buildingVector/norm(buildingVector);
theta = pi/2;
rotation = [cos(theta) sin(theta); -sin(theta) cos(theta)];
leftVector = rotation*buildingVector';

theta = -pi/2;
rotation = [cos(theta) sin(theta); -sin(theta) cos(theta)];
rightVector = rotation*buildingVector';

rightBox = [970 990;690 710]; %[llcx urcx;llcy urcy]
leftBox = [855 875;665 685];

save buildingFactor.mat leftVector rightVector rightBox leftBox