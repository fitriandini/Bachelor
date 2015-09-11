% CROPIMG
%--- Fitria Nur Andini 5104100155
function I = cropimg(file, left_eye, right_eye)
%-- I = cropimg(file, left_eye)
% left eye[x y]; 
%-- crop image and transpose it into column matrix (m x 1)
I = imread(file);

%-- boundary 51; 31
% for normal init : x - 72; y - 62
xleft = left_eye(1) - 51;
yleft = left_eye(2) - 31;
xright = right_eye(1) + 51;
imsz = xright - xleft;
% 211 144 199 199
I = imcrop(I, [xleft yleft imsz imsz]);
I = imresize(I,100/imsz);
%figure,imshow(I)
% I = reshape(I, size(I,1) * size(I,2), 1);

% % rotate image
% y = left_eye(2) - right_eye(2);
% x = left_eye(1) - right_eye(1);
% t = atan2(y,x);
% I = imrotate(I, -t, 'bilinear', 'crop');