clear
close all
clc

A = [1 2
    -1 4]

BJ = eye(size(A)) - diag(1./diag(A)) * A

% A è tridiagonale? Sì

rhoBJ = max(abs(eig(BJ)))

BGS = eye(size(A)) - tril(A) \ A

rhoBGS = max(abs(eig(BGS)))

rhoBJ ^ 2

% D falsa: Il metodo di Gauss-Seidel non converge per ogni scelta
% dell'iterata iniziale x0