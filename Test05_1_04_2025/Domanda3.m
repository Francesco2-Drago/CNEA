clear
close all
clc

syms g real
assume(g>1)

n = 2;

A = [4 -1
    -1 g];

b = ones(n, 1);
x0 = zeros(n, 1);

r0 = b - A*x0;
p0 = r0;

alpha0 = (p0' * r0) / (p0' * A * p0);
x1 = x0 + alpha0 * p0;
r1 = r0 - alpha0 * A * p0;
beta0 = (p0' * A * r1) / (p0' * A * p0);
p1 = r1 - beta0 * p0