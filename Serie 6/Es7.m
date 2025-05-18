clear
close all
clc

a = 0;
b = 1;

g = @(x) 10 * x.^2; % Segnale fisico
f = @(x) g(x) + 2 * rand(size(x)) - 1; % Rilevazione dello strumento

% Punto 1

n = 9;
xNodi = linspace(a, b, n + 1);
x = linspace(a, b, 1e3);

p = polyfit(xNodi, f(xNodi), n);
f9 = polyval(p, x);

p = polyfit(xNodi, f(xNodi), 2);
f2 = polyval(p, x);

plot(x, f(x), x, g(x), x, f9, x, f2)
legend('f(x)', 'g(x)', 'f9', 'f2')

% Punto 2

x = 2;

p = polyfit(xNodi, f(xNodi), n);
f9 = polyval(p, x)

p = polyfit(xNodi, f(xNodi), 2);
f2 = polyval(p, x)

g(x)
f(x)

% Punto 3