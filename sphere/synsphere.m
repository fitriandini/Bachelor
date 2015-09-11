function [I1, I2, I3, I4, I5, I6, I7, I8, I9] = synsphere
[X,Y,Z] = depth_map;
A = albedo_sphere(X,Y,Z);

%--synthetic sphere 1
s1 = lightdirect(-140, 30);
I1 = intensity(X,Y,Z,A,s1);

%--synthetic sphere 2
s2 = lightdirect(-90, 30);
I2 = intensity(X,Y,Z,A,s2);

%--synthetic sphere 3
s3 = lightdirect(-40, 30);
I3 = intensity(X,Y,Z,A,s3);

%--synthetic sphere 4
s4 = lightdirect(-180, 30);
I4 = intensity(X,Y,Z,A,s4);

%--synthetic sphere 5 
s5 = lightdirect(0, 0);
I5 = intensity(X,Y,Z,A,s5);

%--synthetic sphere 6 -- sph2cart(0, 60, 51)
s6 = lightdirect(0, 30);
I6 = intensity(X,Y,Z,A,s6);

%--synthetic sphere 7 -- sph2cart(140, 60, 51)
s7 = lightdirect(140, 30);
I7 = intensity(X,Y,Z,A,s7);

%--synthetic sphere 8 -- sph2cart(90, 60, 51)
s8 = lightdirect(90, 30);
I8 = intensity(X,Y,Z,A,s8);

%--synthetic sphere 9 -- sph2cart(40, 60, 51)
s9 = lightdirect(40, 30);
I9 = intensity(X,Y,Z,A,s9);

%-- write synthetic sphere into file
% imwrite(I1, './s1.pgm','pgm');
% imwrite(I2, './s2.pgm','pgm');
% imwrite(I3, './s3.pgm','pgm');
% imwrite(I4, './s4.pgm','pgm');
% imwrite(I5, './s5.pgm','pgm');
% imwrite(I6, './s6.pgm','pgm');
% imwrite(I7, './s7.pgm','pgm');
% imwrite(I8, './s8.pgm','pgm');
% imwrite(I9, './s9.pgm','pgm');

%-- subplot
figure,
subplot 331, imshow(I1), title('s1(30,140)');
subplot 332, imshow(I2), title('s2(30,90)');
subplot 333, imshow(I3), title('s3(30,40)');
subplot 334, imshow(I4), title('s4(30,180)');
subplot 335, imshow(I5), title('s5(0,0)');
subplot 336, imshow(I6), title('s6(30,0)');
subplot 337, imshow(I7), title('s7(30,-140)');
subplot 338, imshow(I8), title('s8(30,-90)');
subplot 339, imshow(I9), title('s9(30,-40)');