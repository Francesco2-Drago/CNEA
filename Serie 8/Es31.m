clear
close all
clc

% Punto 1

% Problema come funzione mms

% Punto 2

t0 = 0;
tmax = 100;

y0 = [2 0];

[t, y] = ode45('mms', [t0 tmax], y0);

gamma = 0.1;
omega2 = 1;

omega1 = sqrt(4*omega2 - gamma^2) / 2;

f = @(x) sin(omega1 * x);

plot(t, y(:, 1), t, f(t))
legend('Ode', 'Exact')

% Punto 3

[t, y] = ode45('mms_forz', [t0 tmax], y0);

omegaf = 0.5;

f = @(x) sin(omegaf * x);

figure
plot(t, y(:, 1), t, f(t))
legend('Ode', 'Exact')