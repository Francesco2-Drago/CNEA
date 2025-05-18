clear
close all
clc

phi = @(x) - x.^4/2 + 4*x.^3 - 7*x.^2 - 4*x + 10;

a = -1;
b = 3;

% Punto 1

fplot(phi) % minimo in x=2
close

xEx = 2;

% Punto 2 funzione sezione_aurea

% Punto 3

nmax = 100;
toll = 1e-6;

[xVect, iter, errStima] = sezione_aurea(phi, a, b, toll, nmax);

% Punto 4

errV = [];

for i=1:iter+1
    errV = [errV, norm(xEx*ones(size(xVect(i))) - xVect(i))];
end

semilogy(0:iter, errV, 0:iter, errStima)
legend('Errore', 'Err Stima')
grid on