function n = normsurface(Z)
% NORMSURFACE
% get the normal surface
% n (3 x M)
[p, q] = gradient(Z);
zx = reshape(p, size(p,1) * size(p,2), 1);
zy = reshape(q, size(q,1) * size(q,2), 1);
magZ = sqrt(zx.^2 + zy.^2+1);
n = [-zx -zy ones(size(zx))]./(magZ * ones(1,3));
n = n';