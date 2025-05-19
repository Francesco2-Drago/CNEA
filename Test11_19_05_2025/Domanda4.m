clear
close all
clc

t0 = 0;
tmax = 3;

h = 0.2;

f = @(t, y) sin(pi*t) - y^2;

y0 = 2;
u1 = 1.2;
u2 = 0.9120;

[tVect, uVect] = multipasso_Adams_Bashforth(f, [t0 tmax], y0, u1, u2, h);
uVect(end)