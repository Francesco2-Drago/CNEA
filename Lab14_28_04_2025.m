%% Es. 5

clear
close all
clc

f = @(x) exp(-x.^2) .* sin(x);

a = -2;
b = 3;

xDis = a:0.01:b;
fDis = f(xDis);

plot(xDis, fDis)

n = 3;
h = (b - a)/n;

xNodi = a:h:b;
fNodi = f(xNodi);

PDis = interp1(xNodi, fNodi, xDis);

hold on
plot(xDis, PDis)
plot(xNodi, fNodi, 'bo')
legend('f(x)', 'interpolante', 'nodi')

err = max(abs(fDis - PDis)); % 0.4379

H = [];
err = [];

for n = 2.^(2:7)
    h = (b - a)/n;
    H = [H h];
    xNodi = a:h:b;
    fNodi = f(xNodi);
    PDis = interp1(xNodi, fNodi, xDis);
    err = [err, max(abs(fDis - PDis))];
end

figure
loglog(H, err, H, H, H, H.^2)
legend('err', 'H', 'H^2')

%% Es. 7

clear
close all
clc

g = @(x) 10 * x.^2; % Segnale fisico
f = @(x) g(x) + 2 * rand(size(x)) - 1; % Rilevazione dello strumento

a = 0;
b = 1;

n = 9;
xNodi = linspace(a, b, n + 1);
fNodi = f(xNodi);

xDis = a:0.01:b;
gDis = g(xDis);
fDis = f(xDis);

PL = polyfit(xNodi, fNodi, n);
PLDis = polyval(PL, xDis);

Pmq = polyfit(xNodi, fNodi, 2);
PmqDis = polyval(Pmq, xDis);

plot(xDis, fDis, xDis, gDis, xDis, PLDis, xDis, PmqDis)
legend('f(x)', 'g(x)', 'Lagrange', 'Min. quad.')

%

xDis = a:0.01:2;
gDis = g(xDis);
fDis = f(xDis);

PL = polyfit(xNodi, fNodi, n);
PLDis = polyval(PL, xDis);

Pmq = polyfit(xNodi, fNodi, 2);
PmqDis = polyval(Pmq, xDis);

plot(xDis, fDis, xDis, gDis, xDis, PLDis, xDis, PmqDis)
legend('f(x)', 'g(x)', 'Lagrange', 'Min. quad.')

%% Es. 8

clear
close all
clc

% Funzione Gauss-Newton
% [w_vect, it] = gauss_newton(x, y, r_fun, J_fun, w0, toll, nmax)

U = 1;
A = 20; % valori esatti da testo, da stimare

d = 1;
a = 0.8;

f = @(x, w) (d * w(1) / a) * exp(- w(2) * (x/a).^2);
r = @(x, y, w) y - f(x, w);
J = @(x, y, w) [-(d/a) * exp(-w(2) * (x/a).^2), (d * w(1) / a) * exp(-w(2) * (x/a).^2).*(x/a).^2];

x = linspace(-0.5, 0.5, 50)';
w_true = [U A]';
y = f(x, w_true);

w0 = [2 2]';
toll = 1e-6;
nmax = 1e3;

[w_vect, it] = gauss_newton(x, y, r, J, w0, toll, nmax);
w_vect(:, end)

plot(x, y, 'o', x, f(x, w_vect(:, end)))

%

y_noise = y + 3e-2*randn(size(x));
[w_vect, it] = gauss_newton(x, y_noise, r, J, w0, toll, nmax)
figure
plot(x, y_noise, 'o', x, f(x, w_vect(:, end)))