function e = calc_error(A,B)
if ~isequal(size(A), size(B))
    errordlg('Size not match');
    return;
end
D = size(A,1) * size(A,2);
% MSE
% e = sum(sum((A - B).^2))/D;

% Mean Absolute Depth Error
e = mean(mean(abs(A - B)));