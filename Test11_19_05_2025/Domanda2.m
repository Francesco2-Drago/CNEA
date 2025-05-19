clear
close all
clc

f = @(t, y) -2*(1 + sin(pi*t)) * (2 - y)^2;

t0 = 0;
tmax = 5;

y0 = 3;

h = 1/4;

c = [0 3/4];
b = [1/3 2/3];
A = [0 0; 3/4 0];

[tVect, uVect] = Runge_Kutta(f, [t0 tmax], y0, h, c, b, A);

uVect(end)