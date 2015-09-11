% BACKPROP
%--- Fitria Nur Andini 5104100155

function [V, W, A] = backprop(I, R, s, v, w, lr)
%-- [V, W, A] = backprop(I, R, s, v, w)
%-- I = original image intensity (normalized) -- L1
%-- R = Lambertian Reflectance Map (normalized) -- L6
%-- s = light source direction [sx sy sz] -- L4 (1 x 3)
%-- update weight (normal vector V, weight W, and Albedo A)

% lr = learning rate

% Vt (3 x M) = V(t + 1) -- update normal vector v dengan gradient descent
Vt = v + (2*lr*s'*(I-R)');

% n (1 x M) = magnitude of Vt 
n = sqrt(sum(Vt.^2));

warning off, 'divideByZero';
% normalized V
V = Vt ./ (ones(3,1) * n);
i = isnan(V) | isinf(V);
V(i) = 0;

% update weight W (M x 3) --  W = inv(V' * V) * V';
W = pinv(V);

% updated Albedo (M x 1)
A = n';
i = isnan(A) | isinf(A);
A(i) = eps;