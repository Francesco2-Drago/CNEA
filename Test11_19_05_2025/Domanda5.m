clear
close all
clc

f = @(t, y, v) sin(pi*t) - y^2 - 3*v; % Funzione del problema di Cauchy

t0 = 0;
tmax = 10;

y0 = 1;
v0 = 0;

h = 0.2;

[tVect, uVect, vVect] = Leap_Frog(f, [t0 tmax], y0, v0, h);

uVect(end)
vVect(end)