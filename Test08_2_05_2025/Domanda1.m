clear
close all
clc

f = @(x) 1 - exp(sin(x));

a = -2;
b = 2;

x = linspace(a, b, 1e3);

h = (b - a)/5;
xNodi = a:h:b;

p = polyfit(xNodi, f(xNodi), length(xNodi) - 1);
y = polyval(p, x);

[err, idx] = max(abs(f(x) - y))