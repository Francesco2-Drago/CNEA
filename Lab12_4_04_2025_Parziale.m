clear
close all
clc

n = 100;

A = diag(21*ones(n, 1)) + diag(-4*ones(n-1, 1), -1) + diag(-20*ones(n-1, 1), 1) + diag(2*ones(n-2, 1), 2) + diag(ones(n-2, 1), -2);

xEx = 2 * ones(n, 1);
b = A * xEx;

PJ = diag(diag(A));
BJ = eye(n) - PJ \ A;
rhoBJ = max(abs(eig(BJ)))

PGS = tril(A);
BGS = eye(n) - PGS \ A;
rhoBGS = max(abs(eig(BGS)))

alpha = 1;
x0 = b;
toll = 1e-3;
nmax = 10000;
[x, k] = richardson(A, b, PGS, x0, toll, nmax, alpha)

x(1)

resNorm = norm(b - A * x) / norm(b)

errRel = cond(A) * resNorm

rhoBGS^k * norm(xEx-x0)/norm(xEx) % dovrebbe stimare errore ma sbagliato

% 

T = tril(A);

wVec = 1.27:0.0001:1.32;
wVec = 0.68:0.001:0.86;
rhoVec = [];

for w=wVec
    B = (2*w-1) * eye(n) - w * (T \ A);
    rhoVec = [rhoVec max(abs(eig(B)))];
end

plot(wVec, rhoVec, wVec, ones(size(wVec)))
close

AtA = A' * A;
toll = 1e-5;
nmax = 1000;
x0 = ones(n, 1);
[lambda, x, iter] = eigpower(AtA, toll, nmax, x0)
[mu, x, iter] = invpower(AtA, toll, nmax, x0)

sqrt(lambda/mu)
cond(A)

% 

C = A(:, 1:end-2);
[Q, R] = qr(C);
z = R\(Q'*b);
z(1)

% 

F = @(x) A * x + exp(- x / 10) - b - ones(n, 1);
x0 = b;
B0 = A;
toll = 1e-6;
nmax = 1000;

[x, iter] = bfgs(F, x0, B0, toll, nmax)
x(1, 2:4)

% 

n = 100;
A = diag(6*ones(n, 1)) + diag(-4*ones(n-1, 1), -1) + diag(-4*ones(n-1, 1), 1) + diag(-2*ones(n-2, 1), 2) + diag(-2*ones(n-2, 1), -2);

x0 = (1:n)';
x0 = x0 / norm(x0);
toll = 1e-3;
nmax = 100;
[lambda, x, iter] = eigpower(A, toll, nmax, x0)