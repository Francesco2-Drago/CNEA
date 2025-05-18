%% Es. 3

clear
close all
clc

B = [10 -1 1 0
    1 1 -1 3
    2 0 2 -1
    3 0 1 5];

% Punto 1

gershcircles(B)

% Punto 2

eig(B)

% Punto 3

toll = 1e-6;
nmax = 100;
x0 = ones(size(B, 1), 1);

[lambda, x, iter] = invpower(B, toll, nmax, x0)
% invpower non converge!!

% Punto 4

shift = 1i;
[mu, x, iter] = invpowershift(B, shift, toll, nmax, x0)

shift = -1i;
[mu, x, iter] = invpowershift(B, shift, toll, nmax, x0)

shift = 10;
[mu, x, iter] = invpowershift(B, shift, toll, nmax, x0)

[lambda, x, iter] = eigpower(B, toll, nmax, x0)