clear
close all
clc

f = @(x) atan(7*(x-pi/2)) + sin((x-pi/2).^3);

a = -1;
b = 6;

% Punto 1

plot(a:0.01:b, f(a:0.01:b))
yline(0, '--r')
legend('f(x)')
grid on

% Punto 2

alpha1 = pi/2;
toll = 1e-10;
nmax = 1000;

df = matlabFunction(diff(str2sym(func2str(f))));

x0 = 1.5;
[xVect1, iter1] = newton(x0, nmax, toll, f, df); % 1.570796326794897

x0 = 4;
[xVect2, iter2] = newton(x0, nmax, toll, f, df);

solEx = alpha1*ones(size(xVect1));
err1 = abs(solEx - xVect1);
solEx = alpha1*ones(size(xVect2));
err2 = abs(solEx - xVect2);

figure
semilogy(0:iter1, err1, 0:iter2, err2)
legend('1.5', '4')
grid on

% Non convergo, rimango incastrato in loop quasi infinito a causa della
% strana forma della funzione e della sua derivata prima

% Punto 3

% Funzione continua e f(a)*f(b)<0 quindi posso usare bisezione in [-1, 6]

toll = (b-a)/(2^31);

[xVect, iter] = bisez(a, b, toll, f); % 1.570796326734126

% Punto 4

% funzione biseznewton: usa bisez per avvicinarsi a zero e poi metodo di
% newton per calcolare effettivamente lo zero

% Punto 5

nmaxB = 5;
[xVectBN, iterBN] = biseznewton(a, b, nmaxB, nmax, toll, f, df);