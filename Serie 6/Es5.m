clear
close all
clc

f = @(x) exp(-x.^2) .* sin(x);

a = -2;
b = 3;

x = linspace(a, b, 1e3);

% Punto 1

h = (b - a)/3;
xNodi = a:h:b;
fLin = interp1(xNodi, f(xNodi), x);

plot(x, f(x), x, fLin)
legend('f(x)', 'Comp. Lin.')

% Punto 2

errMax = max(abs(f(x) - fLin));

% Punto 3

N = [4 8 16 32 64 128];

errMaxV = [];
errStimaV = [];

for n = N
    h = (b - a)/n;
    xNodi = a:h:b;
    fLin = interp1(xNodi, f(xNodi), x);
    errMaxV = [errMaxV max(abs(f(x) - fLin))];
    fx = str2sym(func2str(f));
    d2f = matlabFunction(diff(fx, 2));
    errStimaV = [errStimaV h^2/8*max(abs(d2f(x)))];
end

loglog(N, errMaxV, N, errStimaV)
legend('Errore', 'Stima')
grid on