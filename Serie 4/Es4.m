clear
close all
clc

f = @(x) cos(2*x).^2 - x.^2;

% Punto 1

plot(-1:0.01:1, f(-1:0.01:1))
yline(0)
grid on
legend('f')

% Punto 2

% phi(x) = x + A * f(x)
% |phi'(alpha1)|<1
% -1 < 1 + A * f'(alpha1) < 1
% -2 < A * f'(alpha1) < 0
% per alpha1>0 so che derivata prima è minore di zero!
% 0 < A < -2/f'(alpha1)

% Punto 3

A = 0.1;
x0 = 0.1;
toll = 1e-10;
nmax = 1000;

phi = @(x) x + A * f(x);
[xVect, iter] = ptofis(x0, phi, nmax, toll);

% stima numerica a posteriori di possibili valori per A

df = matlabFunction(diff(str2sym(func2str(f))));
-2/df(xVect(end));

% 0 < A < -2/f'(alpha1)
% 0 < A < 0.7154

% Punto 4

[p,c] = stimap(xVect);

% Punto 5

% Convergente secondo ordine: condizione necessaria: phi'(alpha1)=0
% Aopt = -2/f'(alpha1)

d2f = matlabFunction(diff(diff(str2sym(func2str(f)))));
d2f(xVect(end)) % 1.7575 ~= 0 quindi converfenza ordine 2

Aopt = -2/df(xVect(end));

% Punto 6

phiN = @(x) x - f(x) / df(x);
x0Vect = -1:0.01:1;
xSol = [];

for x0 = x0Vect
    [xVectN, iterN] = ptofis(x0, phiN, nmax, toll);
    xSol = [xSol xVectN(end)];
end

figure
plot(x0Vect, xSol)
grid on

% Per convergere ad alpha1>0 x0 in [0.12; 0.88]