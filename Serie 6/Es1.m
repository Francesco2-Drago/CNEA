clear
close all
clc

f = @(x) x.*sin(x);

% Punto 1

a = -2;
b = 6;

fplot(f, [a b])
close

% Punto 2

x = linspace(a, b, 1e3);

% grado = 2

h = (b-a)/2;
xNodi = a:h:b;
fx = f(xNodi);
p2 = polyfit(xNodi, fx, 2);
fx2 = polyval(p2, x);

% grado = 4

h = (b-a)/4;
xNodi = a:h:b;
fx = f(xNodi);
p4 = polyfit(xNodi, fx, 4);
fx4 = polyval(p4, x);

% grado = 6

h = (b-a)/6;
xNodi = a:h:b;
fx = f(xNodi);
p6 = polyfit(xNodi, fx, 6);
fx6 = polyval(p6, x);

plot(x, f(x), x, fx2, x, fx4, x, fx6)
legend('f(x)', 'fx2', 'fx4', 'fx6')
close

% Punto 3

fx = f(x);

err2 = max(abs(fx - fx2))
err4 = max(abs(fx - fx4))
err6 = max(abs(fx - fx6))

err2v = abs(fx - fx2);
err4v = abs(fx - fx4);
err6v = abs(fx - fx6);

plot(x, err2v, x, err4v, x, err6v)
legend('err2', 'err4', 'err6')
close