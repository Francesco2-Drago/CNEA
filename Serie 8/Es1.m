clear
close all
clc

f = @(x) exp(-x.^2) * sin(2*x + 1);

x0 = 0;

% Punto 1

hVect = [0.4 0.2 0.1 0.05 0.025 0.0125];

D = zeros(3, length(hVect));

i = 0;

for h = hVect
    i = i + 1;
    D(1, i) = (f(x0 + h) - f(x0)) / h;
    D(2, i) = (f(x0) - f(x0 - h)) / h;
    D(3, i) = (f(x0 + h) - f(x0 - h)) / (2 * h);
end

df = matlabFunction(diff(str2sym(func2str(f))));

Err = abs(D - df(x0) * ones(size(D)));

figure
loglog(hVect, Err, hVect, hVect, '--', hVect, hVect.^2, '--')
legend('Avanti', 'Indietro', 'Centrate')

% Punto 2

D2 = zeros(size(hVect));

i = 0;

for h = hVect
    i = i + 1;
    D2(i) = (df(x0 + h) - df(x0 - h)) / (2 * h);
end

d2f = matlabFunction(diff(str2sym(func2str(f)), 2));

Err2 = abs(D2 - d2f(x0) * ones(size(D2)));

figure
loglog(hVect, Err2, hVect, hVect,'--', hVect, hVect.^2, '--')
legend('Centrate 2', 'h', 'h^2')