clear
close all
clc

n = 100;

A = diag(ones(1, n-2), -2) + diag(ones(1, n-2), 2) - 4*diag(ones(1, n-1), -1)...
    - 4*diag(ones(1, n-1), 1) + 6*diag(ones(1, n));

xEx = ones(n, 1);

b = A * xEx;

% Punto 1

% Fattorizzazione lu come metodo di Gauss per scrivere P*A = L*U

costo = 2/3 * n^3;

[L, U, P] = lu(A);

y = fwsub(L, P*b);
x = bksub(U, y);

resNorm = norm(b - A*x) / norm(b)

cond(A)
errRelStima = resNorm * cond(A)

errVero = norm(xEx - x)

if sdp(A)
    fprintf('Essendo A SDP avrei potuto usare Cholesky\n')
end

costoCH = n^3/3 +2*n^2 % costo minore di lu

% Punto 2

clc

BJ = eye(n) - diag(1./diag(A)) * A;
BGS = eye(n) - tril(A) \ A;

rhoBJ = max(abs(eig(BJ))) % >1 non converge
rhoGS = max(abs(eig(BGS))) % <1 converge

x0 = zeros(n, 1);
toll = 1e-3;
nmax = 1e3;

[x, iter] = gs(A, b, x0, toll, nmax)

resNorm = norm(b - A*x) / norm(b)
errRel = norm(xEx - x) / norm(xEx)

% Metodo converge molto lentamente perché raggio spettrale molto vicino ad
% 1 e quindi anche con residuo relativo/normalizzato basso rimane alto
% l'errore vero. GS fa controllo su residuo relativo per errore

% Punto 3

clc

P1 = eye(n);
P2 = - diag(ones(n-1, 1), -1) - diag(ones(n-1, 1), 1) + 2*diag(ones(n, 1));
P3 = diag(diag(A, -1), -1) + diag(diag(A, 1), 1) + diag(diag(A));

sdp(P1)
sdp(P2)
sdp(P3) % non è SDP quindi non posso usare gradiente coniugato!

cond(A) % = cond(P1 \ A)
B = P2 \ A;
condB = max(eig(B)) / min(eig(B))

c = (sqrt(condB)-1)/(sqrt(condB)+1)
% Precondizionamento con matrice P2 conveniente perché matrice risultante
% molto meglio condizionata rispetto sola A

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

[x, ~, ~, iter] = pcg(A, b, toll, nmax, P2, [], x0)

normaA(x-xEx, A)

% Punto 4

clc

x0 = (1:n)';
y0 = x0 ./ norm(x0);
toll = 1e-3;
nmax = 1e3;

[lambda, x, iter] = eigpower(A, toll, nmax, y0) % 15.579891987824944, 28

lambda1 = 15.992306133853464;
lambda2 = 15.969243057163879;

syms N
ceil(double(solve(abs(lambda2/lambda1)^(2*N) < 1e-3, N, "Real", true)))

1/2*log(1e-3)/log(abs(lambda2/lambda1)) % fallo a mano che esce leggermente
% diverso!!! Solve fa casino!

y = x0/norm(x0); % y0
lambda0 = y'*A*y;
eigval=eig(A);
eigval=sort(eigval,1,"descend");
c=abs(eigval(1)-lambda0);

k=1/2*log((1e-3))/log(abs(eigval(2)/eigval(1)))

% Ordine di convergenza calcolato calcolando il fattore di abbattimento
% come abs(lambda2/lambda1)^2 come rapporto tra N=0 e N=1 sfruttando che
% per N=0 si ha che lambda1(A) - lambda1(A)_{0} = C

% Punto 5

clc

n = 100;
xVect = zeros(n, 1);
mu = 1.7;
toll = 1e-3;
nmax = 1e3;

err = toll + 1;
iter = 0;
x = zeros(n, 1);

while err>toll && iter<nmax
    iter = iter + 1;

    for i=1:n
        x(i) = (1-mu)*x(i) + mu/A(i, i) * (b(i) - A(i, 1:i-1)*x(1:i-1) - A(i, i+1:end)*x(i+1:end));
    end

    xVect = [xVect, x];
    err = norm(b-A*x)/norm(b);
end

x1 = xVect(1, 2)
x2 = xVect(1, 3)
x3 = xVect(1, end)