% SYMNN
%--- Fitria Nur Andini 5104100155
function [N, An, p1, p2, p3] = symnn(I1, I2, I3, lr, maxIter, minError, postmethod)
%-- [n, R] = symnn(I) 
%-- I = image intensity (m^2 x 1)
%n1, R1, A1, W1, sse1, n2, R2, A2, W2, sse2, n3, R3, A3, W3, sse3
% initialization
[A V W] = initNetwork(I1, I2, I3);
% lr = 0.05;
const = 0;

% Run NN
% disp('Image 1');
[p1.n1, p1.R1, p1.A1, p1.W1, p1.sse1] = simnnet(I1, A, V, W, lr, const, maxIter, minError);
% disp('Image 2');
[p2.n2, p2.R2, p2.A2, p2.W2, p2.sse2] = simnnet(I2, A, V, W, lr, const, maxIter, minError);
% disp('Image 3');
[p3.n3, p3.R3, p3.A3, p3.W3, p3.sse3] = simnnet(I3, A, V, W, lr, const, maxIter, minError);

if(postmethod == 'pca')
%     disp('pca');
    % ---------PCA------------------
    % Matrix surface normal per komponen
    Nx = [p1.n1(1,:); p2.n2(1,:); p3.n3(1,:)];
    Ny = [p1.n1(2,:); p2.n2(2,:); p3.n3(2,:)];
    Nz = [p1.n1(3,:); p2.n2(3,:); p3.n3(3,:)];
    % get princpal component from surface normal
    Nxn = pca(Nx);
    Nyn = pca(Ny);
    Nzn = pca(Nz);
    % rebuild matrix surface normal
    N = [Nxn; Nyn; Nzn];
    
    % Albedo
    Ac = [p1.A1 p2.A2 p3.A3];
    cA = cov(Ac);
    [evA  egA] = eig(cA);
    An = evA(:,3)' * Ac';
    An = An';
elseif(postmethod == 'avg')
%         disp('avg');
    %----------AVERAGE DIRECTION VECTOR---
    N = (p1.n1 + p2.n2 + p3.n3)/3;
    An = (p1.A1 + p2.A2 + p3.A3)/3;
elseif(postmethod == 'sum')
%         disp('sum');
    %----------SUM VECTOR---
    N = p1.n1 + p2.n2 + p3.n3;
    An = p1.A1 + p2.A2 + p3.A3;
end


function Ncn = pca(Nc)
covar = cov(Nc');
[ev eg] = eig(covar);
Ncn = ev(:,3)' * Nc;

% pc = princomp(Nc');
% Ncn = pc(:,1)' * Nc;

%--------------------
% eA = eig(cA);
% An = eA' * A';
%--------------------------------

% g1 = n1./(ones(3,1)*n1(3,:));
% g2 = n2./(ones(3,1)*n2(3,:));
% g3 = n3./(ones(3,1)*n3(3,:));
% N12 = cross(g1, g2);
% N = cross(N12, g3);
% 
% A = [A1 A2 A3]';
% An = mean(A);