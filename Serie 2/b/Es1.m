%% 1.1

clear
close all
clc

n = 100;

A = diag(ones(1, n-1), -1) + 2 * diag(ones(1, n));
A(1, :) = 1;

% Punto 1

nnz(A)
figure
spy(A)

sparse(A) % 5576 bytes vs 80000

% Punto 2

[L, U] = lu(A);

figure
spy(L)

figure
spy(U) % fill-in su U

% Punto 3

D = diag(diag(A));
DInv = diag(1./diag(A));
BJ = DInv * (D - A);

T = tril(A);
BGS = eye(n) - T \ A;

rhoBJ = max(abs(eig(BJ)));
rhoGS = max(abs(eig(BGS)));
% !!! il raggio spettrale di BJ è 1 quindi non converge !!!

% Punto 4 creazione funzione jacobi

% Punto 5

b = ones(n, 1);
b(1) = 2;
x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1000;

[x,k] = jacobi(A, b, x0, toll, nmax);

%% 1.2

clear
close all
clc

n = 7;

% Punto 1

A = 9*diag(ones(1, n)) - 3*diag(ones(1, n-1), 1) - 3*diag(ones(1, n-1), -1) ...
    + diag(ones(1, n-2), 2) + diag(ones(1, n-2), -2);

b = [7 4 5 5 5 4 7]';

% Punto 2

% A è a dominanza diagonale stretta per righe?

if diag(A) - (sum(abs(A), 2) - diag(A))>0
    disp('A è a dominanza diagonale stretta per righe')
end

% Punto 3

% A è simmetrica definita positiva?

if isequal(A, A')
    if eig(A)>0
        disp('A è simmetrica definita positiva')
    else
        disp('A è simmetrica, non definita positiva')
    end
else
    disp('A non è simmetrica')
end

% Punto 5

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[xGS, kGS] = gs(A, b, x0, toll, nmax);

% Punto 6

[xJ, kJ] = jacobi(A, b, x0, toll, nmax);