%% Es. 6

clear
close all
clc

n = 4;
A = 2*diag(ones(1, n)) - diag(ones(1,n-1), 1) - diag(ones(1,n-1), 1);

% Punto 1 funzione sdpcond

% Punto 2

nmax = 200;
toll = 1e-8;

K = sdpcond(A, toll, nmax)

% Punto 3

% 2/3 n^3 + k*8n^2