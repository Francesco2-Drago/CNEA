clear
close all
clc

treal = [0 2 5 7 8 10]';
Hreal = [400 399.1 397.5 396.9 396.4 395.7]';
H0 = 400;

H = @(t, w) H0 - w(1)*(1 - exp(-w(2)*t));
r = @(t, y, w) y - H(t, w);
J = @(t, y, w) [(1 - exp(-w(2)*t)), w(1)*t.*exp(-w(2)*t)];

w0 = [10 0.1]';

toll = 0;
nmax = 5;

[wVect, it] = gauss_newton(treal, Hreal, r, J, w0, toll, nmax)

syms t
double(solve(H(t, wVect(:, end)) <= 390, t, Real=true))