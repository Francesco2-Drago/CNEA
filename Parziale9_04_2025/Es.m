clear
close all
clc

n = 100;

A = pentadiag(1, -16, 303/10, -16, 1, n);

b = zeros(n, 1);

for i=1:n
    b(i) = (n+i)/n;
end

% Punto 1

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[x, iter] = gs(A, b, x0, toll, nmax) % iter = 667

resNorm = norm(b-A*x)/norm(b) % 9.8817e-07

if sdp(A)
    condA = max(eig(A)) / min(eig(A)) % 206.2620
end

errRelStima = condA * resNorm % 2.0382e-04

for Beta=0:0.01:1
    PBeta = Beta.*diag(diag(A)) + (1-Beta).*tril(A);
    B = eye(n) - PBeta\A;
    % d = (cond(B) - 1)/(cond(B) + 1);
    plot(Beta, max(abs(eig(B))), 'xr')
    hold on
end

yline(1)

% Punto 2
close all
clc

P1 = eye(n)*((303)/10);
P2 = tridiag(-1, 2, -1, n);
P3 = tridiag(-1, 3, -1, n);

% Numero di condizionamento più piccolo

condP1A = max(eig(P1\A)) / min(eig(P1\A))
condP2A = max(eig(P2\A)) / min(eig(P2\A)) % = 24.5933
condP3A = max(eig(P3\A)) / min(eig(P3\A))

c = (sqrt(condP2A) - 1)/(sqrt(condP2A) + 1);

% Stima numero di iterazini necessarie con solve

syms k

ceil(double(solve((2*c^k)/(1+c^(2*k)) == 1e-6, k, "Real", true)))

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[x,~,~,iter] = pcg(A, b, toll, nmax, P2, [], x0)

resNorm = norm(b - A*x)/norm(b) % = 3.9338e-07

% Punto 3
clc

x0 = ones(n, 1);

[lambdaVect, x, iter] = invpower_it(A, toll, nmax, x0)

[p, c] = stimap(lambdaVect);



% Punto 4

x0 = ones(n, 1);
nmax = 1e3;
toll = 1e-2;

y0 = x0/norm(x0);
lambda0 = y0'*A*y0