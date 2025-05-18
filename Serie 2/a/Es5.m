%% 5.1

clear
clc

n = 20;

A = 4 * eye(n) - 1 * diag(ones(1, n-1), 1) - 1 * diag(ones(1, n-1), -1);
A(1, :) = 1;
A(:, 1) = 1;
spy(A)

[L, U, P] = lu(A);

figure
spy(L)

figure
spy(U)

figure
spy(P)

% Pivoting totale richiede matrice di ingresso sparsa
% LU = PAQ
% full per invertire sparse

[L, U, P, Q] = lu(sparse(A));

figure
spy(L)

figure
spy(U)

figure
spy(P)

figure
spy(Q)