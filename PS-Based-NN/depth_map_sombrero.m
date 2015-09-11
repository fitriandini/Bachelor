function [X,Y,Z,mag] = depth_map_sombrero(width, height, C)
%-- [X,Y,Z] = depth_map
%-- generate the X,Y,Z coordinate of synthetic sphere

if nargin == 0
    width = 100;
    height = 100;
    C = 51;
end

%-- width and height = 100
[X,Y] = meshgrid([1:1:width]);

%-- C = 51;
Xc = X - C;
Yc = Y - C;
Z = 15+(15*cos((pi*sqrt(Xc.^2+Yc.^2))/17));