clear
close all
clc

f = @(x) exp(x) + exp(sin(2*pi*x));

a = -2;
b = 2;

M = 8;

I = gausscomp(a, b, M, f)