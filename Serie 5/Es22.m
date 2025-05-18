clear
close all
clc

Phi = @(x, y) 3*x.^2 + y.^2 - x/4 - y/6 + exp(-2*x*y);

xEx = [0.099299729019640, 0.179161952163217]';

% Punto 1

x = -0.15:0.01:0.25;
y = -0.05:0.01:0.35;

plot_phi(x, y, Phi)

% Punto 2 Funzione newton_opt

% Punto 3

x0 = [-0.14, 0.14]';
toll = 1e-8;
nmax = 200;

GradPhi = gradient(str2sym(func2str(Phi)));
HessPhi = jacobian(GradPhi);

GradPhi = matlabFunction(GradPhi);
HessPhi = matlabFunction(HessPhi);

[xVectN, iterN] = newton_opt(GradPhi, HessPhi, x0, toll, nmax);

% Punto 4 Funzione bfgs

% Punto 5

x0 = [-0.14, 0.14]';
toll = 1e-8;
nmax = 200;

[xVectBFGS, iterBFGS] = bfgs(Phi, GradPhi, x0, toll, nmax);

% Punto 6

errN = [];

for i=1:iterN+1
    errN = [errN, norm(xVectN(:, i) - xEx)];
end

errBFGS = [];

for i=1:iterBFGS+1
    errBFGS = [errBFGS, norm(xVectBFGS(:, i) - xEx)];
end

figure
semilogy(0:iterN, errN, 0:iterBFGS, errBFGS)
legend('Newton', 'BFGS')
grid on