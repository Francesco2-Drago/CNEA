%% Leonardo con Newton sistemi

clear
close all
clc

syms x y

f1 = @(x, y) x.^2 - y.^2 - 1;
f2 = @(x, y) (x-1).^2 + (y-1).^2 - 2;

% F = @(x, y) [x.^2 - y.^2 - 1; (x-1).^2 + (y-1).^2 - 2];
F = subs([f1(x, y); f2(x, y)]);
F = matlabFunction(F);

% Applico metodo di Newton a sistema definito da F = 0

nmax = 5;
toll = 0;
x0 = [2, 2]';

[xVect, iter] = newtonSistemi(F, x0, nmax, toll);