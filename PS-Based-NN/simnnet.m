% SIMNNET
%--- Fitria Nur Andini 5104100155
function [n, R, A, W, sse] = simnnet(I, A, V, W, lr, const, maxIter, minError)

% konversi type ke double -- I = M x 1
I = double(I);
% layer 1 -- normalisasi intensitas citra
L1 = I/max(I);

% init sum square error (sse) dan iterasi (t)
sse = [100];
t = 1;

% start iteration
while(sse(t) > minError & t < maxIter)
    %--symmetric neural network
    % layer 2 -- adjust intensity dengan albedo
    L2 = L1 ./ A;
    % layer 3 -- estimasi sumber cahaya (not normalized)
    L3 = L2' * W;
    % layer 4 -- normalisasi sumber cahaya
    L4 = L3/norm(L3);
    % layer 5 -- estimasi reflectance map (not normalized)
    L5 = L4 * V;
    % layer 6 -- normalisasi reflectance map
    L6 = (L5 - min(L5))/(max(L5) - min(L5));
    L6= L6';
   
    %-- sum square error
    t = t+1;
    e = L6 - L1;
    sse(t) = dot(e', e);   
  
    %--backprop
    [V, W, A] = backprop(L1, L6, L4, V, W, lr);
end;
n = V;
R = L6;
    
%     disp(['t: ', num2str(t)]);
%     disp(['sse: ', num2str(sse(t))]);
    %-- adjustment rule
%     if((t>2) & (sse(t-1) > sse(t)) & (sse(t-2) > sse(t)) )
%         lr = lr + const;
%         disp(['lr: ', num2str(lr)]);
%     elseif ( (t>2) &  (sse(t-1) < sse(t)) & (sse(t-2)<sse(t)) )
%         lr = lr - const;
%         disp(['lr: ', num2str(lr)]);
%     else
%         lr = lr;
%         disp(['lr: ', num2str(lr)]);
%     end;