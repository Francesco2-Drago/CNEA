clear
close all
clc

% Punto 1

% Funzione Crank-Nicolson

% Punto 2

t0 = 0;
tmax = 1;

y0 = 2;

lambda = -42;

h = 0.02;

yEx = @(t) y0 * exp(lambda*t);

f = @(t, y) lambda*y;

[tVect, uVect, itPFVect] = Crank_Nicolson(f, [t0 tmax], y0, h);

% Punto 3

plot(tVect, itPFVect)

figure
plot(tVect, uVect, tVect, yEx(tVect))
legend('CN', 'Exact')

% Punto 4

% Funzione Heun

% Punto 5

[tVect, uVect] = Heun(f, [t0 tmax], y0, h);

figure
plot(tVect, uVect, tVect, yEx(tVect))
legend('Heun', 'Exact')

% Punto 6

H = [0.02 0.01 0.005 0.0025 0.00125];

Err = [];

i = 1;

for h=H
    [tVect, uVect, itPFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h);
    Err(1, i) = max(abs(uVect - yEx(tVect)));

    [tVect, uVect, itPFVect] = Crank_Nicolson(f, [t0 tmax], y0, h);
    Err(2, i) = max(abs(uVect - yEx(tVect)));

    [tVect, uVect] = Heun(f, [t0 tmax], y0, h);
    Err(3, i) = max(abs(uVect - yEx(tVect)));

    [tVect, uVect] = Runge_Kutta_4(f, [t0 tmax], y0, h);
    Err(4, i) = max(abs(uVect - yEx(tVect)));

    i = i + 1;
end

loglog(H, Err, H, H, '--', H, H.^2, '--', H, H.^4, '--')
legend('EI', 'CN', 'Heun', 'RK', 'H', 'H^2', 'H^4')