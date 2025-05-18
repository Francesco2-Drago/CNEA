clear
close all
clc

f = @(x) x.^3 - (2+exp(1))*x.^2 + (2*exp(1)+1)*x + (1-exp(1)) - cosh(x-1);

a = 0.5;
b = 6.5;

% Punto 1

plot(a:0.1:b, f(a:0.1:b))
yline(0, '--r')
grid on

% Punto 2

% Metodo della bisezione utilizzabile solo per gli zeri in: ~3.5 e ~6.3
% poiché gli unici ad avere molteplicità diapsi e quindi cambio di segno
% intorno allo zero

% Punto 3 funzione bisez

% Punto 4

toll = 1e-12;

a = 3;
b = 4;
[x, iter] = bisez(a, b, toll, f)

a = 5.5;
b = 6.5;
[x, iter] = bisez(a, b, toll, f)