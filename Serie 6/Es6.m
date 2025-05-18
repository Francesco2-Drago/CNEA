clear
close all
clc

y0 = 10;
T = 1;
t = 0:0.1:T;

y = [10.0 9.89 9.75 9.66 9.10 8.95 8.10 7.49 6.80 6.13 5.05];
g = 9.81;

% Punto 1

f = @(x) y0 - 1/2 .* g .* x.^2;

plot(t, y, 'x', t, f(t))
legend('Sperimentale', 'Fisica')
close

% Punto 2

p = polyfit(t, y, length(y) - 1);
fLagrange = polyval(p, t);

fLin = interp1(t, y, t);

p = polyfit(t, y, 2);
fQuad = polyval(p, t);

plot(t, y, 'x', t, f(t), t, fLagrange, t, fLin, t, fQuad)
legend('Sper.', 'Fis.', 'Lagr.', 'Lin.', 'Quad.')

errLagrange = abs(f(t) - fLagrange);
errLin = abs(f(t) - fLin);
errQuad = abs(f(t) - fQuad);

figure
plot(t, errLagrange, t, errLin, t, errQuad)
legend('ErrLagr.', 'ErrLin.', 'ErrQuad')

figure
plot(0:2, [max(errLagrange) max(errLin) max(errQuad)], 'x')
close all

% Punto 3

x = 1.05;

p = polyfit(t, y, length(y) - 1);
fLagrange = polyval(p, x);

p = polyfit(t, y, 2);
fQuad = polyval(p, x);

abs(f(x) - fLagrange)
abs(f(x) - fQuad)