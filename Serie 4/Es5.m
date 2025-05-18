clear
close all
clc

F = @(x1, x2) [6*x1 - 2*x2*exp(-2*x1*x2) - 1/4; 2*x2 - 2*x1*exp(-2*x1*x2) - 1/6];

alpha = [0.099299729019640, 0.179161952163217]';

% Punto 1

x0 = [-0.14, 0.14]';

nmax = 5;
toll = 0;

[xVect, iter] = newtonSistemi(F, x0, nmax, toll);

% Punto 2

err = [];

for i=1:iter-1
    err = [err, norm(xVect(:, i+1) - alpha)];
end

fattConv1 = err(2:end) ./ err(1:end-1)

fattConv2 = err(2:end) ./ err(1:end-1).^2

fattConv3 = err(2:end) ./ err(1:end-1).^3 % no converzenga ordine 3

% Abbiamo problemi per numeri troppo piccoli se calcoliamo tutti...
% Proviamo a lasciar perdere ultima iterazione