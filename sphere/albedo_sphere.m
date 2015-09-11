function A = albedo_sphere(x,y,z)
%-- albedo_sphere(x,y,z) get albedo matrix for synthetic sphere
%-- x,y is the coordinate of sphere and z = f(x,y)

width = 100;
height = 100;
center = 51;

%-- init albedo matrix
% A = zeros(height, width);
A = ones(height, width);
%-- set left top albedo
i = find( x<center & y<center & z~=0);
A(i) = 0.8;

%-- set bottom right albedo
i = find( x>center & y>center & z~=0);
A(i) = 0.6;

%-- set else position to albedo = 1
% i = find(~(x>center & y>center) & ~(x<center & y<center) & z~=0);
% A(i) = 1;

% i = find(z==0);
% A(i) = 0;