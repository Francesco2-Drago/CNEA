clear
close all
clc

% Punto 1 funzione gauss_newton

% Punto 2

a = 0.8;
d = 1;

U = 1;
A = 20;

f = @(x, w) (((w(1) * d)) / a) * exp(-w(2) * x.^2 / a^2);
r = @(x, y, w) y - f(x, w);
J = @(x, y, w) [-(d / a) * exp(-w(2) * x.^2 / a^2), (((w(1) * d)) / a) * exp(-w(2) * x.^2 / a^2) .* (x.^2 / a^2)];

a_left = -0.5;
a_right = 0.5;

n = 50;
x = linspace(a_left, a_right, n)';
y = f(x, [U A]);

w0 = [2 2]';
toll = 1e-6;
nmax = 1e3;

[wVect, it] = gauss_newton(x, y, r, J, w0, toll, nmax);
wVect(:, end)

plot(x, y, 'o', x, f(x, wVect(:, end)))

% Punto 3

sigma = 3e-2;
y_noise = y + sigma * randn(size(y));
[wVect, it] = gauss_newton(x, y_noise, r, J, w0, toll, nmax);

figure
plot(x, y_noise, 'o', x, f(x, wVect(:, end)))