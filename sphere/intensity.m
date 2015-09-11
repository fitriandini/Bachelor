function I = intensity(X,Y,Z,A,s)
% I = intensity(X,Y,Z,A,s) 
% calculate the intensity of 3D surface based on Lambertian surface
% X, Y, Z is the coordinate of 3D object
% A is the albedo of the surface
% s is the light source

% Normal Surface
n = normsurface(Z);

% Reshape Albedo
Ac = reshape(A, size(A,1)*size(A,2), 1);

% Ic (Mx1) = (Light Source (1 x 3) * Normal (3 x M))'
Ic = (s * n)';

i = find(Ic < 0);
Ic(i) = 0;

% Reflectance = Albedo * (Normal*Light Source)
Ic = Ac .* Ic;

Ic = double(Ic);
%--normalized surface intensity [0..1]
%-- get maximum value of I per column
m = max(Ic);
Ic = Ic/m;

Ic = reshape(Ic, size(A,1), size(A,2));
I = Ic;