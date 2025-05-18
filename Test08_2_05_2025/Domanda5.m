clear
close all
clc

f = @(x) exp(x) .* sin(pi*x);

a = -1;
b = 1;

h = (b - a) / 10;
xNodi = a:h:b;

interp1(xNodi, f(xNodi), 0.7)