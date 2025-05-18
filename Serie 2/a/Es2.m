%% 2.1

clear
clc

n = 1000;

A = hilb(n);
B = rand(n);

% Punto 1

xEx = ones(n, 1);
yEx = ones(n, 1);

b = A * xEx;
c = B * yEx;

% Punto 2

x = A \ b;
y = B \ c;

% Punto 3

errRelA = norm(xEx - x) / norm(xEx);
errRelB = norm(yEx - y) / norm(yEx);

cond(A)
cond(B)