clear
close all
clc

n = 10;

A = pentadiag(1, -5, 8, -5, 1, n);

xEx = ones(n, 1);

b = A * xEx;

% Punto 1

BJ = eye(n) - diag(1./diag(A)) * A;
BGS = eye(n) - tril(A) \ A;

rhoBJ = max(abs(eig(BJ))); % 1.413665802548755
rhoBGS = max(abs(eig(BGS))); % 0.972643718112328
% GS converge perché raggio spettrale < 1

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[x, iter] = gs(A, b, x0, toll, nmax); % iter = 396

resNorm = norm(b - A*x)/norm(b); % 9.849799621083396e-07

if sdp(A)
    condA = max(eig(A)) / min(eig(A));
end

errRelStima = condA * resNorm; % 1.734919010622943e-04
errRel = norm(xEx - x) / norm(xEx); % 1.598209968052487e-05

% Punto 2

clc

P1 = eye(n);
P2 = tridiag(-4, 9, -4, n);
P3 = tridiag(-1, 2, -1, n);

% Convergenza più veloce per numero di condizionamento più basso per
% matrice P^-1 * A (e comunque minore di condA!)

condP1A = condA; % perché P1 = eye(n) % 1.761374928794863e+02

if sdp(P2)
    condP2A = max(eig(P2\A)) / min(eig(P2\A)); % 14.114489490430055
end

if sdp(P3)
    condP3A = max(eig(P3\A)) / min(eig(P3\A)); % 3.888874417165010
end

% Convergenza più rapida con P3

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[x, k] = richardson(A, b, P3, x0, toll, nmax);

errNormA = normaA(x - xEx, A); % 2.073397401649281e-06

% Punto 3

clc

% Gradiente coniugato in aritmetica esatta converge in al più n iterazioni
% quindi in questo caso n = 10

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[x, ~, ~, iter] = pcg(A, b, toll, nmax, [], [], x0); % iter = 5

errNormA = normaA(x - xEx, A); % 1.616711937598058e-13

% Punto 4

clc

toll = 0;
nmax = 3;

autoval = qrbasic(A, toll, nmax); % s = 0.541373824411331

toll = 1e-3;
nmax = 1e3;
x0 = [-1 1 -1 1 -1 1 -1 1 -1 1]';
s = 0.5414;

[lambda, x, iter] = invpowershift(A, s, toll, nmax, x0);
% iter = 3
% lambda = 0.505722172688480
y = x/norm(x); % autovalore normalizzato

% Punto 5

clc

n = 10;
x0 = ones(n, 1);
toll = 1e-3;
nmax = 1e3;

F = @(x) sin(1/10 * (x') * x) + 1/2 * (x') * A * x;

GradF = @(x) 2/10 * cos(1/10 * (x') * x) * x + A * x;

g = 0.1;
xVect = x0;
err = norm(GradF(xVect));
iter = 0;

while err>toll && iter<nmax
    iter = iter + 1;

    xVect = [xVect, xVect(:, iter) - g * GradF(xVect(:, iter))];

    g = abs((xVect(:, end) - xVect(:, iter))' * (GradF(xVect(:, end)) - GradF(xVect(:, iter)))) / ...
        norm(GradF(xVect(:, end)) - GradF(xVect(:, iter)))^2;

    err = norm(GradF(xVect(:, end)));
end

% iter = 44

x1 = xVect(1, 2)
x2 = xVect(1, 3)
x3 = xVect(1, end)