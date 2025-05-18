clear
close all
clc

f = @(x) - x.^3 + 3.*x.^2 - 2;

a = 0;
b = 2;

x = linspace(a, b, 1e3);

xNodi = [0 0.5 2];
p = polyfit(xNodi, f(xNodi), 2);
fx = polyval(p, x);

plot(x, f(x), x, fx)
legend('f(x)', 'fx')

h = (b - a)/2;
xNodi = a:h:b;
p = polyfit(xNodi, f(xNodi), 2);
fx = polyval(p, x);

figure
plot(x, f(x), x, fx)
legend('f(x)', 'fx2')

xNodi = [0 exp(-sqrt(2)) 3^(-sqrt(0.5)) 2];
p = polyfit(xNodi, f(xNodi), 3)
fx = polyval(p, x);

figure
plot(x, f(x), x, fx)
legend('f(x)', 'fx')
close all