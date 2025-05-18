clear
close all
clc

A = [8 -2 -2
    -2 6 -1
    -2 -1 9];

b = [1 1 1]';
x0 = b;

pcg(A, b, [], 2, [], [], x0)