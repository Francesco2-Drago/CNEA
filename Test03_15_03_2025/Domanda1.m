clear
close all
clc

n = 100;

A = 2*diag(ones(1, n)) - diag(ones(1, n-1), 1);
A(n, 1) = 1;

b = ones(n, 1);

[L, U, P, Q] = lu(sparse(A));

y = fwsub(L, P * b);
xStar = bksub(U, y);
x = Q * xStar;

L(2, 1)
y(n)
xStar(n)