clear
close all
clc

f = @(x) x.^3 - (2+exp(1))*x.^2 + (2*exp(1)+1)*x + (1-exp(1)) - cosh(x-1);

% Punto 1

df = @(x) 3 * x.^2 - 2 * (2 + exp(1)) * x + (2 * exp(1) + 1) - sinh(x - 1);

d2f = @(x) 6 * x - 2 * (2 + exp(1)) - cosh(x - 1);

a = 0.5;
b = 6.5;
plot(a:0.1:b, f(a:0.1:b), a:0.1:b, df(a:0.1:b), a:0.1:b, d2f(a:0.1:b))
yline(0, '--r')
legend('f', 'df', 'd2f')
grid on

alpha1 = 1; % molteplicità 2 perché prima derivata ad essere diversa da
% zero in alpha1 è la seconda

df = diff(str2sym(func2str(f)))
d2f = diff(df)

double(subs(df, alpha1))
double(subs(d2f, alpha1))

df = matlabFunction(df)
d2f = matlabFunction(d2f)

% Punto 2 funzione newton

% Punto 3

toll = 1e-6;
nmax = 1000;
mol = 2;

x0 = 0.5;
[xVect1, it1] = newton(x0, nmax, toll, f, df);
[xVect1M, it1M] = newton(x0, nmax, toll, f, df, mol);
% 0.999999998974064 con derivata computer diff, 0.999999993873743 con
% derivata fatta a mano

x0 = 3;
[xVect2, it2] = newton(x0, nmax, toll, f, df);

x0 = 6;
[xVect3, it3] = newton(x0, nmax, toll, f, df);

solEx = ones(size(xVect1));
err1 = solEx - xVect1;
solEx = ones(size(xVect1M));
err1M = solEx - xVect1M;

figure
semilogy(0:it1, err1, 0:it1M, err1M)
legend('lineare', 'quadratico')
grid on