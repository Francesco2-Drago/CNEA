clear
close all
clc

syms x

f1 = @(x) x./pi;
f2 = @(x) (2 - x./pi).^2;
f = @(x) f1(x).*(x<=pi) + f2(x).*(x>pi);

n = 4;
j = 0:n;
h = 2*pi/(n + 1);
xNodi = j * h;

k = -2:2;

c = @(k) 1/(n+1) * f(xNodi)*(exp(-1i*k*xNodi')');

c(k)

I = @(x, k) c(k)*exp(1i*k*x);
I = str2sym(func2str(I))

c__2 = f(xNodi)*(exp(-1i*-2*xNodi)')*1/5;
c__1 = f(xNodi)*(exp(-1i*-1*xNodi)')*1/5;
c_0 = 2;

I = c_0 + c__2*exp(1i*-2*x) + c__1*exp(1i*-1*x) + conj(c__1)*exp(1i*1*x) + conj(c__2)*exp(1i*2*x)
simplify(I)
pretty(I)