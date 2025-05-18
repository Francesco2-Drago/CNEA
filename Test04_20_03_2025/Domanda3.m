clear
close all
clc

n = 4;

A = - diag(ones(1, n-1), -1) + 3*diag(ones(1, n)) + 2*diag(ones(1, n-1), 1);

b = ones(n, 1);

x0 = b;

[x, k] = gs(A, b, x0, 1e-6, 5)