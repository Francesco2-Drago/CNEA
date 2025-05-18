clear
close all
clc

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

% Punto 1

a = 0:0.01:0.4;
d = -0.1:0.01:0.3;

plot_phi(a, d, Phi)

% Punto 2

% Funzione gradiente_coniugato_opt_BT_SA

% Punto 3

x0 = [0.1, 0.05]';
toll = 1e-5;
nmax = 100;

[xVectG, iterG] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'G', 'BT', x0, toll, nmax);
[xVectFR, iterFR] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'FR', 'BT', x0, toll, nmax);

% Punto 4

x0 = [0, 0.1]';

[xVectG2, iterG2] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'G', 'BT', x0, toll, nmax);
[xVectFR2, iterFR2] = gradiente_coniugato_opt_BT_SA(Phi, GradPhi, 'FR', 'SA', x0, toll, nmax);

errG = [];

for i=1:iterG+1
    errG = [errG, norm(xVectG(i) - xEx)];
end

errFR = [];

for i=1:iterFR+1
    errFR = [errFR, norm(xVectFR(i) - xEx)];
end

figure
semilogy(0:iterG, errG, 0:iterFR, errFR)
legend('Gradiente', 'Grad. Con. FR')
grid on