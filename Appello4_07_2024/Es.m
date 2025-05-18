clear
close all
clc

n = 100;

A = full(gallery('poisson',round(sqrt(n))));

xEx = ones(n, 1);

b = A * xEx;

% Punto 1

% metodo per calcolare matrice R triangolare superiore tale che A = R'*R
% costo computazionale: 1/3 * n^3 per assemblare matrice R e poi 2*n^2 per
% risolvere sistema con sotituzione in avanti a indietro

costo = 1/3 * n^3 + 2 * n^2; % 3.5333e+05

R = chol(A);

y = fwsub(R', b);
x = bksub(R, y);

condA = max(eig(A)) / min(eig(A)); % 48.374150078708162

resNorm = norm(b - A*x) / norm(b); % 7.4078e-16

errRel = condA * resNorm; % 3.5835e-14
errVero = norm(x - xEx) / norm(xEx); % 3.1165e-16

% Punto 2

% 0<a<2/lambdamax(A)

costo = 2/max(eig(A)); % 0.2552

aOpt = 2/(min(eig(A)) + max(eig(A)));

fattAbb = (condA - 1) / (condA + 1); % 0.9595

% syms k
% 
% double(solve(fattAbb^k < 1e-3, k, "Real", true))

k = ceil(log(1e-3)/log(fattAbb)); % 168

x0 = zeros(n, 1);

[x, iter] = richardson(A, b, eye(n), x0, 0, k, aOpt);

resNorm = norm(b - A*x) / norm(b); % 1.9781e-04

fattAbb = normaA(x-xEx, A)/normaA(x0-xEx, A); % 5.3832e-04

% Punto 3

P1 = eye(n);
P2 = diag(diag(A));
P3 = diag(diag(A)) + diag(diag(A, -1), -1) + diag(diag(A, 1), 1);

% Numero di condizionamento più piccolo

condP1A = max(eig(P1\A)) / min(eig(P1\A)); % = condA = 48.374150078708162
condP2A = max(eig(P2\A)) / min(eig(P2\A)); % = 48.374150078708162
condP3A = max(eig(P3\A)) / min(eig(P3\A)); % = 24.687075039353299

c = (sqrt(condP3A) - 1) / (sqrt(condP3A) + 1);

fattAbb = (2*c^10) / (1+c^(2*10)); % 0.0338

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[x, ~, ~, iter] = pcg(A, b, toll, nmax, P3, [], x0);

errNormaA = normaA(x-xEx, A); % 3.5043e-06

% Punto 4

x0 = ones(n, 1);
toll = 1e-12;
nmax = 1e3;
s = 7.5;

[lambdaVect, x, iter] = invpowershift_it(A, s, toll, nmax, x0);

[p, c] = stimap(lambdaVect);

% Punto 5

n = 100;
x0 = ones(n, 1);
toll = 1e-3;
nmax = 1e3;

F = @(x) sin((x') * x) + 1/2 * (x') * A * x;

GradF = @(x) 2 * cos((x') * x) * x + A * x;

B = 0.5 * eye(n);
xVect = x0;
err = norm(GradF(xVect));
iter = 0;

while err>toll && iter<nmax
    iter = iter + 1;

    xVect = [xVect, xVect(:, iter) - B * GradF(xVect(:, iter))];

    s = GradF(xVect(:, end)) - GradF(xVect(:, iter));

    B = B * (eye(n) - 1/(norm(s)^2) * GradF(xVect(:, end)) * s');

    err = norm(GradF(xVect(:, end)));
end

% iter = 30

x1 = xVect(1, 2)
x2 = xVect(1, 3)
x3 = xVect(1, end)