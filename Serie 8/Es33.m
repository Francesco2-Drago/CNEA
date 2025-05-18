clear
close all
clc

% Punto 1

N = 1e7;
E0 = 100;
I0 = 30;
R0 = 0;

t0 = 0;
tmax = 300;

h = 0.25;

Nh = ceil((tmax - t0) / h);

S0 = N - E0 - I0 - R0;

y0 = [S0 E0 I0 R0]';

[tVect, uVect] = eulero_avanti_sistemi('seir', [t0 tmax], y0, Nh);

Percentuale = 100 * uVect(4, end) / N; % 84.56 %

% Punto 2

% Uguale ma inserito if per portare beta = 0.25 dall'80esimo giorno in poi

Percentuale = 100 * uVect(4, end) / N; % 35.1176 %

% Uguale ma beta risale a beta = 0.65 dal 120esimo giorno in poi

Percentuale = 100 * uVect(4, end) / N; % 59.2399 %

% Punto 3

% Stabilità punto fisso: |R(h*lambda)| < 1 <-> Re{z}<0
% R(z) = 1 + z

% z = df/dy

beta = 0.7586;
alpha = 1/5.2;
gamma = 1/2.9;

Lambda = @(y) [-beta*y(3)/N, 0, -beta*y(1)/N, 0
                beta*y(3)/N + alpha, 0, -beta*y(1)/N + alpha, alpha
                0, alpha, -gamma, 0
                0, 0, gamma, 0];

for i=1:length(uVect)
    Autoval(:, i) = h*eig(Lambda(uVect(:, i)));
end

figure
plot(real(Autoval), imag(Autoval), '*', cos(0:0.1:2*pi) - 1, sin(0:0.1:2*pi))