clear
close all
clc

% Punto 1 funzione gradiente_coniugato_opt_BT_SA

% Punto 2

CL0 = 0;
CLalpha = 5;
CLdelta = 0.3;

CD0 = 0.02;
CDalpha = 0.5;
CDdelta = 0.05;

syms a d

Phi = matlabFunction(subs(- (CL0 + CLalpha .* a + CLdelta .* d) / (CD0 + CDalpha .* a.^2 + CDdelta .* d.^2)));

GradPhi = matlabFunction(gradient(str2sym(func2str(Phi))));

xEx = [0.196494373584908, 0.117896623783779]';

x0 = [0.1, 0.05]';
toll = 1e-5;
nmax = 100;
flag_alpha = 'SA';

[xVectG, iterG] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'G', flag_alpha, x0, toll, nmax);
[xVectFR, iterFR] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'FR', flag_alpha, x0, toll, nmax);

errG = [];

for i=1:iterG+1
    errG = [errG, norm(xVectG(:, i) - xEx)];
end

errFR = [];

for i=1:iterFR+1
    errFR = [errFR, norm(xVectFR(:, i) - xEx)];
end

semilogy(0:iterG, errG, 0:iterFR, errFR)
legend('Gradiente', 'Grad. con. FR')
grid on