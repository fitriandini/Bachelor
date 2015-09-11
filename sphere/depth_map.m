function [X,Y,Z,mag] = depth_map
%-- [X,Y,Z] = depth_map
%-- generate the X,Y,Z coordinate of synthetic sphere

%-- width and height = 100
width = 100;
height = 100;
%-- center sphere = 51
C = 51;
%-- radius lingkaran = 48
rad = 48;

[X,Y] = meshgrid([1:1:width]);
%-- lingkaran -> r^2 = (x-c)^2 + (y-c)^2
%-- koordinat x,y setelah dikurangi titik pusat lingkaran
Xc = X - C;
Yc = Y - C;
%-- diketahui jari-jari lingkaran = 48
R = rad * ones(height, width);
%-- if (x-c)^2 + (y-c)^2 <= r^2 
%-- then z = abs(sqrt(r^2 - (x-c)^2 - (y-c)^2)) 
%-- else z = 0
XY = Xc.^2 + Yc.^2;
R2 = R.^2;
i = find(XY <= R2);
%-- create matrix Z
Z = zeros(height,width);
Z(i) = abs(sqrt(R2(i) - Xc(i).^2 - Yc(i).^2));


%-- if in argument output exist R
if(nargout == 4)
    mag = R;
end;

%-- 3D surface
%-- surf(X,Y,Z); xlabel('X'); ylabel('Y');