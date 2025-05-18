clear
close all
clc

f = @(x) cos(pi*x)*(x-1/2);

alpha = 1/2;

df = diff(str2sym(func2str(f)));
double(subs(df, alpha))

d2f = diff(str2sym(func2str(f)), 2);
double(subs(d2f, alpha)) % zero di molteplicità 2

% Punto 1

toll = 1e-6;
nmax = 1000;
x0 = 0.9;
mol = 2;

[xVect1, iter1] = newton(x0, nmax, toll, f, matlabFunction(df));

[xVect2, iter2] = newton(x0, nmax, toll, f, matlabFunction(df), mol);

% Punto 2

% il criterio di arresto basato sulle iterate successive è affidabile solo
% se lo zero è semplice, quindi mol = 1. Non è questo il caso

% Punto 3

x0 = 0.9;
x1 = 0.7;
xVect = [x0, x1];

for i=1:10-1
    q = (f(xVect(i+1)) - f(xVect(i))) / (xVect(i+1) - xVect(i));
    xVect = [xVect, xVect(i+1) - f(xVect(i+1))/q];
end

[p, c] = stimap(xVect)

% Ordine di convergenza circa = 1

% Punto 4

% phi = x + mu/(2*pi) * cos(pi * x)
% phi' = 1 - mu/2 * sin(pi * x)
% |phi'|<1
% -1 < phi' < 1
% -1 < 1 - mu/2 * sin(pi * alpha1) < 1
% -1 < 1 - mu/2 < 1
% -2 < -mu/2 < 0
% 2 > mu/2 > 0
% 4 > mu > 0

% Almeno ordine di convergenza 2 se phi'(alpha) = 0
% phi'(alpha) = 1 - mu/2
% phi'(alpha) = 0 => 1 - mu/2 = 0
% 1 = mu/2
% mu = 2

% Punto 5

% Convergenza monotona se derivata prima è maggiore o uguale al più a zero
% 0 <= phi'(alpha) < 1
% 0 <= 1 - mu/2 < 1
% -1 <= -mu/2 < 0
% 2 >= mu > 0

% Punto 6

mu = 1;

phi = @(x) x + mu/(2*pi) * cos(pi * x);

fplot(phi)

nmax = 1000;
toll = 1e-6;
x0Vect = -0.5:0.01:1.5;

for x0=x0Vect
    [xVect, iter] = ptofis(x0, phi, nmax, toll);
end

% phi'(x) = 1 - mu/2 * sin(x * pi) = 1 - sin(pi * x)/2
% |phi'(x)| < 1
% -1 < 1 - sin(pi * x)/2 < 1
% 4 > sin(pi * x) > 0
% 0 < pi * x < pi
% 0 < x < 1