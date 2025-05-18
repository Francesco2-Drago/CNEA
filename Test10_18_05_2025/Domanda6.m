clear
close all
clc

y0 = 3;

f = @(t, y) -(1 + t/2) * y;

h = 0.1;

t0 = 0;
tmax = 10;

[tVect, uVect] = eulero_indietro_punto_fisso(f, [t0 tmax], y0, h);

uVect(2)