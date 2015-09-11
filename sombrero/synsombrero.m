function I = synsombrero(tilt, slant)
[X, Y, Z] = depth_map;
[height, width] = size(X);
A = 0.4*(ones(size(X)));

s = lightdirect(tilt, slant);
I = intensity(X,Y,Z,A,s);