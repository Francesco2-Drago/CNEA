clear
close all
clc

A = [4 2 1
    2 4 1
    1 1 7];

b = [2 2 2]';

x0 = b;

r0 = b - A*x0;
alpha0 = (r0' * r0) / (r0' * A * r0)
x1 = x0 + alpha0 * r0