clear
close all
clc

A = [11 0 0
    5 -2 0
    3 0 -9];

s = -9;

x0 = ones(3, 1);

l = invpowershift(A, s, 1e-6, 1000, x0)