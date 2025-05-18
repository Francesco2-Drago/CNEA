%% Es. 4

clear
close all
clc

% Punto 1 funzione qrbasic

syms a

A = [a 2 3 13
    5 11 10 8
    9 7 6 12
    4 14 15 1];

toll = 1e-10;
nmax = 1000;

a = 30;

D1 = qrbasic(double(subs(A)), toll, nmax)
eig(double(subs(A)))

a = -30;

D2 = qrbasic(double(subs(A)), toll, nmax)
eig(double(subs(A)))

v1 = abs(D1(2:end) ./ D1(1:end-1));
max(v1) % velocità di convergenza

v2 = abs(D2(2:end) ./ D2(1:end-1));
max(v2) % velocità di convergenza