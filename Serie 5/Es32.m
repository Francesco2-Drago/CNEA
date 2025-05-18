clear
close all
clc

Phi = @(x, y) 3*x.^2 + y.^2 - x/4 - y/6 + exp(-2*x*y);

GradPhi = gradient(str2sym(func2str(Phi)));

HessPhi = matlabFunction(jacobian(GradPhi));

GradPhi = matlabFunction(GradPhi);

xEx = [0.099299729019640, 0.179161952163217]';

x0 = [-0.14, 0.14]';
toll = 1e-8;
nmax = 200;

[xVectBFGS, iterBFGS] = bfgs(Phi, GradPhi, x0, toll, nmax);

[xVectN, iterN] = newton_opt(GradPhi, HessPhi, x0, toll, nmax);

[xVectG, iterG] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'G', 'BT', x0, toll, nmax);

[xVectFR, iterFR] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'FR', 'BT', x0, toll, nmax);

% Errori

errG = [];

for i=1:iterG+1
    errG = [errG, norm(xVectG(:, i) - xEx)];
end

errFR = [];

for i=1:iterFR+1
    errFR = [errFR, norm(xVectFR(:, i) - xEx)];
end

errN = [];

for i=1:iterN+1
    errN = [errN, norm(xVectN(:, i) - xEx)];
end

errBFGS = [];

for i=1:iterBFGS+1
    errBFGS = [errBFGS, norm(xVectBFGS(:, i) - xEx)];
end

figure
semilogy(0:iterFR, errFR, 0:iterG, errG, 0:iterBFGS, errBFGS, 0:iterN, errN)
legend('FR', 'Gradiente', 'BFGS', 'Newton')
grid on

% Ordini di convergenza rapporto ed esponente che cambio io

[pN, cN] = stimap(xVectN);
[pBFGS, cBFGS] = stimap(xVectBFGS);
[pFR, cFR] = stimap(xVectFR);
[pG, cG] = stimap(xVectG);

fattConvN = errN(2:end) ./ errN(1:end-1).^2
fattConvBFGS = errBFGS(2:end) ./ errBFGS(1:end-1).^1
fattConvFR = errFR(2:end) ./ errFR(1:end-1).^1 % In realtà leggermente minore di 1
fattConvG = errG(2:end) ./ errG(1:end-1).^1