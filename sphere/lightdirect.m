function s = lightdirect(tilt, slant)
% LIGHT DIRECT
% get light source direction in x,y,z coordinate
% tilt and slant in degree
tilt = deg2rad(tilt);
slant = deg2rad(slant);
sx = cos(tilt) * sin(slant);
sy = sin(tilt) * sin(slant);
sz = cos(slant);
s = [sx sy sz];