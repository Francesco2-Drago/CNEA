clear
close all
clc

h = 0.25;

x = 0;

f = @(x) (5 + 2^x);

df = @(x) (-3*f(x) + 4*f(x + h) - f(x + 2*h)) / (2*h);

dfReal = matlabFunction(diff(str2sym(func2str(f))));

dfReal(x)

df(x)