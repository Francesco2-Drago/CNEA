clear
close all
clc

f = @(x) sin(1 ./ (1 + x.^2));
a = -2 * pi;
b = 2 * pi;

% Punto 1

x = linspace(a, b, 1e3);

h = (b - a)/2;
xNodi = a:h:b;
p2 = polyfit(xNodi, f(xNodi), 2);
fx2 = polyval(p2, x);

h = (b - a)/4;
xNodi = a:h:b;
p4 = polyfit(xNodi, f(xNodi), 4);
fx4 = polyval(p4, x);

h = (b - a)/8;
xNodi = a:h:b;
p8 = polyfit(xNodi, f(xNodi), 8);
fx8 = polyval(p8, x);

h = (b - a)/10;
xNodi = a:h:b;
p10 = polyfit(xNodi, f(xNodi), 10);
fx10 = polyval(p10, x);

plot(x, f(x), x, fx2, x, fx4, x, fx8, x, fx10)
legend('f(x)', 'fx2', 'fx4', 'fx8', 'fx10')

% Punto 2

fx = f(x);

err2v = abs(fx - fx2);
err4v = abs(fx - fx4);
err8v = abs(fx - fx8);
err10v = abs(fx - fx10);

figure
plot([2 4 8 10], [max(err2v) max(err4v) max(err8v) max(err10v)])

figure
plot(x, err2v, x, err4v, x, err8v, x, err10v)
legend('err2', 'err4', 'err8', 'err10')

close all

% Punto 3

N = [2 4 8 10];
Xk = @(k, n) (b - a)/2 * ( - cos(pi * k/n)) + (a + b)/2;

figure
plot(x, fx)
hold on

errv = [];

for n = N
    k = 0:n;
    xNodi = Xk(k, n);
    p = polyfit(xNodi, f(xNodi), n);
    fx = polyval(p, x);
    plot(x, fx)
    errv = [errv; abs(f(x) - fx)];
end

legend('f(x)', 'fx2', 'fx4', 'fx8', 'fx10')

figure
plot(x, errv)
legend('err2', 'err4', 'err8', 'err10')
close all