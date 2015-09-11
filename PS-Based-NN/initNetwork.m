% INITNETWORK
%--- Fitria Nur Andini 5104100155
function [A, V, W] = initNetwork(I1, I2, I3)
%------ INIT PAPER HYBRID NN----------- %
% [X Y Z] = depth_map;
% V = normsurface(Z);
% W = pinv(V);
% A = rand(size(I1));

%-- rekonstruksi matriks I = M x 3 --> 3 images
I = [I1 I2 I3];
I = double(I);

%---------------INIT 1------------------
% get image height
% height = sqrt(size(I1,1));
% init light source -- from solomon ikeuchi (column wise searching)
% s1
% indx_s1 = find(I1 == max(I1));
% s1 = [mod(indx_s1,height) ceil(indx_s1/height) 1];
% s1 = s1/norm(s1);
% % s2
% indx_s2 = find(I2 == max(I2));
% s2 = [mod(indx_s2,height) ceil(indx_s2/height) 1];
% s2 = s2/norm(s2);
% % s3
% indx_s3 = find(I3 == max(I3));
% s3 = [mod(indx_s3,height) ceil(indx_s3/height) 1];
% s3 = s3/norm(s3);
% 
% S = [s1; s2; s3];
% V = inv(S)*I';
% A = (sqrt(sum(V.^2)))';
% W = pinv(V);

%------------------INIT 2---------------------------------
% init light source (3x3) -- georghiades - belhumeur
% [uu ss vv] = svd(I, 0);
% S = vv * sqrt(ss);
% S = [S(2,:); S(3,:); S(1,:)];
% % init normal (3xM) -- woodham
% V = inv(S) * I';
% % init albedo (Mx1) -- woodham
% A = (sqrt(sum(V.^2)))';
% W = pinv(V);

%---------------INIT 3-- georghiades belhumeur uspatent----
% init albedo (M x 1)
A = mean(I')'/max(max(I));
A(find(A < 0.01)) = 0.01;
[uu ss vv] = svd(I, 0);
% init ligt source
S = vv * sqrt(ss);
% init normal
V = (S' \ double(I)') ./(ones(3,1) * A');
% init weight W
W = pinv(V);

%------------- INIT 4 
% % init albedo (M x 1)
% [u s v] = svds(I);
% % extract A, n from u
% A = u(:,1);
% % calculate V
% zx = u(:,2);
% zy = u(:,3);
% magZ = sqrt(zx.^2 + zy.^2+1);
% n = [-zx -zy ones(size(zx))]./(magZ * ones(1,3));
% V = n';
% % calculate W
% W = pinv(V);


%-----------------INIT 5 -- random weight-------------------------------------
% A = rand(size(I1));
% V = rand(3,size(I1,1));
% W = pinv(V);

%----------------------------

% init normal (3 X M)
%---- versi 1 --> (uu * ss)'
% V = ss * uu';
%---- versi 2
% S = vv * sqrt(ss);
% S = [S(2,:); S(3,:); S(1,:)];
% V = S' \ double(I)';
% A = (sqrt(sum(V.^2)))';
% V = (S' \ double(I)') ./(ones(3,1) * A');
% b = S' \ double(I');
% beb = [b(:,1), b(:,2), zeros(size(b,1),1)];
% v = b(:,3) \ beb;
% a = [1 0 0; 0 1 0; v];
% B = b' * a;
% V = (B ./(A * ones(1,3)))';

% V = (I ./ (A* ones(1,3))) * inv(S);
% V = V';

% A = ones(size(I,1),1) * 0.01;
% V = ones(3,size(I,1)) * 0.01;
% W = ones(size(I,1),3) * 0.01;

% init weight (M X 3)
% Vt = V./(ones(3,1) * A');
% W = pinv(V);
