clear
close all
clc

% Punto 1

% Funzione twobodies

% Punto 2

y0 = [1 0 0 -5.1]';

t0 = 0;
tmax = 5;

options = odeset('reltol', 1e-6);

[t, y] = ode45('twobodies', [t0 tmax], y0, options);

plot(t, sqrt(y(:, 1).^2 + y(:, 3).^2))

figure
plot(y(:, 1), y(:, 3))

% Punto 3

% Funzione Eulero Avanti Sistemi

% Punto 4

Nh = 5*1e5;
[tVect, uVect] = eulero_avanti_sistemi('twobodies', [t0 tmax], y0, Nh);

figure
plot(t, sqrt(y(:, 1).^2 + y(:, 3).^2), tVect, sqrt(uVect(1, :).^2 + uVect(3, :).^2))

Nh = 5*1e3;
[tVect, uVect] = eulero_avanti_sistemi('twobodies', [t0 tmax], y0, Nh);

figure
plot(tVect, sqrt(uVect(1, :).^2 + uVect(3, :).^2))