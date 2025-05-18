%% Es. 1

clear
close all
clc

% Punto 1

N = 100;

A = randi([0, 1], N);

A = A ./ sum(A, 1); % oppure sum(A)

% Punto 2

n = 5;

B = randi([0, 1], n);

B = B ./ sum(B, 1);

% Punto 3 funzione eigpower

% Punto 4

toll = 1e-6;
nmax = 100;
x0 = ones(N, 1) / N;

[lambda, x, iter] = eigpower(A, toll, nmax, x0)

x0 = ones(n, 1) / n;

[lambda, x, iter] = eigpower(B, toll, nmax, x0)