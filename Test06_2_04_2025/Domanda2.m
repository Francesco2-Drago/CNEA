clear
close all
clc

A = [3 -1 0
    -1 2 -1
    0 -1 5];

if isequal(A, A')
    if eig(A)>0
        disp('A è SDP')
    end
end

x0 = ones(3, 1);

% Se A è SDP allora cond(A) = lmax / lmin

lmax = eigpower(A, 1e-6, 3, x0)
lmin = invpower(A, 1e-6, 3, x0)

condA = lmax / lmin % 4.4933