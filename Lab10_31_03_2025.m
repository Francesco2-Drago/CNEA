%% 4 Punto fisso

clear
close all
clc

f = @(x) cos(2*x).^2 - x.^2;
x = linspace(-1, 1, 1000);

plot(x, f(x), x, zeros(size(x)))
grid on

% Punto 2

% |phi'(alpha)| < 1
% | 1 + A*f'(alpha)| < 1
% -2 < A*f'(alpha) < 0
% 0 < A < -2/f'(alpha)

% syms x
% vpasolve(f(x)==0, x, 0.5)

% Punto 3

phi = @(x) x + 0.1 * f(x);
figure
[succ1, it1] = ptofis(0.1, phi, 1000, 1e-10, -1, 1);

% stima a posteriori

alpha = succ1(end);

df = @(x) -4*cos(2*x).*sin(2*x) - 2*x;
Asup = -2 / df(alpha);

% 0 < A < 0.7154

phi = @(x) x + 0.6 * f(x);
figure
[succ2, it2] = ptofis(0.1, phi, 1000, 1e-10, -1, 1);

phi = @(x) x + 0.75 * f(x);
figure
[succ3, it3] = ptofis(0.1, phi, 1000, 1e-10, -1, 1);

phi = @(x) x + 0.6 * f(x);
figure
[succ4, it4] = ptofis(2, phi, 1000, 1e-10, -1, 1);

% Punto 4

[p1, c1] = stimap(succ1);
[p2, c2] = stimap(succ2);

% metodo del secondo ordine:
% 1 + A*f'(alpha) = 0
% Aopt = -1/f'(alpha)

Aopt = -1 / df(alpha)

phi = @(x) x + Aopt * f(x); % per convergenza quadratica come newton
[succOpt, itOpt] = ptofis(0.1, phi, 1000, 1e-10, -1, 1);
stimap(succOpt)

% Punto 6

phiN = @(x) x - f(x)./df(x);
[succN, itN] = ptofis(0.1, phiN, 1000, 1e-10, -1, 1);
stimap(succN)

vettX0 = 0.01:0.01:1;
vettSol = [];

for x0=vettX0
    [succN, itN] = ptofis(x0, phiN, 1000, 1e-10, -1, 1);
    vettSol = [vettSol, succN(end)];
end

figure
plot(vettX0, vettSol)

% x0 in [0.12, 0.88]

%% 5

clear
close all
clc

F = @(x1, x2) [6*x1 - 2*exp(-2*x1.*x2).*x2 - 1/4;
    2*x2 - 2*exp(-2*x1.*x2).*x1 - 1/6];

JF = @(x1, x2) [6+4*exp(-2*x1.*x2).*x2.^2, (4*x1.*x2-2).*exp(-2*x1.*x2);
    (4*x1.*x2-2).*exp(-2*x1.*x2), 2+4*exp(-2*x1.*x2).*x1.^2];

alpha = [0.099299729019640, 0.179161952163217]';

x0 = [-0.14 0.14]';
x = x0;
kmax = 5;
xvec = [];

for k=1:kmax
    Fvec = F(x(1), x(2));
    Jmat = JF(x(1), x(2));
    x = x - Jmat \ Fvec;
    xvec = [xvec x];
end

xvec(:, end)

det(JF(alpha(1), alpha(2)))

% Punto 2

errv = [];

for k=1:kmax-1
    errv = [errv, norm(xvec(:, k) - alpha)];
end

convOrd1 = errv(2:end) ./ errv(1:end-1)

convOrd2 = errv(2:end) ./ errv(1:end-1).^2

% Se il metodo è di ordine p, allora:
% lim ||x^(k+1) - alpha|| / ||x^k - alpha||^p = mu (fattore di
% abbattimento)