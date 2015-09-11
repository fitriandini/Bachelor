% RECON3D
% Do 3D reconstruction
% Usage : 
%       z = recon3D(n)
% Parameter :
%       n : surface normal (3xM)
%--- Fitria Nur Andini 5104100155
function z = recon3D(n)

width = sqrt(size(n,2));
height = size(n,2) / width;
[X,Y] = meshgrid([1:1:width]);

Q = n ./ (ones(3,1) * n(3,:));
i = isnan(Q) | isinf(Q);
Q(i) = 0;
zx = reshape(Q(1,:), height, width);
zy = reshape(Q(2,:), height, width);
z = frankotchellappa(-zx, -zy);
