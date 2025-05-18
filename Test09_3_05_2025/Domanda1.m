clear
close all
clc

f = @(x) cos(pi*x);

a = -1;
b = 1;

I = simpcomp(a, b, 1, f)