%% Metodi iterativi precondizionati serie 02b

%% 1.2
clear
clc

% comando jacobi, richiede matrice, vettore termini noti, x0 come inizio
% iterazioni, tolleranza e nmax tolleranza che usa con residuo normalizzato
% secondo termine noto

n = 7;

A = diag(9*ones(n,1)) - diag(3*ones(n-1,1),1) - diag(3*ones(n-1,1),-1) ...
    + diag(ones(n-2,1),2) + diag(ones(n-2,1),-2);

b = [7 4 5 5 5 4 7]';

% Punto 2
% |Aii| > sumj(|Aij|)

ADiag = diag(abs(A));
AOutDiag = sum(abs(A), 2) - ADiag; % sum ,2 come somma per righe ,1 o senza nulla per colonne

if ADiag > AOutDiag
    disp('matrice è DDSR') % dominanza diagonale stretta per righe
end

% Punto 3

if A==A'
    if eig(A)>0
        disp('matrice è SDP') % simmetrica definita positiva
    end
end

% Punto 5

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1000;

tic
[x_gs, k_gs] = gs(A, b, x0, toll, nmax)
toc

tic
[x_j, k_j] = jacobi(A, b, x0, toll, nmax)
toc

% Raggio spettrale Jacobi
PJInv = diag(1./diag(A));
BJ = eye(n) - PJInv * A;
rhoBJ = max(abs(eig(BJ)))

% Raggio spettrale Gauss - Seidel
PGS = tril(A);
BGS = eye(n) - PGS \ A; % al posto di inv(PGS) * A
rhoBGS = max(abs(eig(BGS)))

% eK = xEx - xK
% ||eK|| <= |rho(B)|^k * ||e0||
% kmin = log(toll) / log(rho(B)) come banale inversione della norma
% dell'errore sopra

kMinJ = log(toll) / log(rhoBJ)
kMinGS = log(toll) / log(rhoBGS)

%% Richardson 2.1

clear
clc

nmax = 10000;
n = 50;
A = diag(4*ones(n,1)) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1) ...
    - diag(ones(n-2,1),2) - diag(ones(n-2,1),-2);

b = 0.2 * ones(n,1);

toll = 1e-5;
x0 = zeros(n,1);

if A==A'
    if eig(A)>0
        disp('A è SDP')
    end
end

condA = max(eig(A)) / min(eig(A))

% Metodo di Richardson

% stessi parametri di GS e J + alpha solo nel caso statico quindi serve
% funzione che fa cose diverse in base al numero di parametri che passano

P = eye(n);

alpha1 = 0.2;
BAlpha1 = eye(n) - alpha1 * A;
rhoBAlpha1 = max(abs(eig(BAlpha1)));

alpha2 = 0.33;
BAlpha2 = eye(n) - alpha2 * A;
rhoBAlpha2 = max(abs(eig(BAlpha2)));

[x1, k1] = richardson(A, b, P, x0, toll, nmax, alpha1)
[x2, k2] = richardson(A, b, P, x0, toll, nmax, alpha2)

lambdaMax = max(eig(A));
lambdaMin = min(eig(A));
alphaOpt = 2 / (lambdaMax + lambdaMin);

[xOpt, kOpt] = richardson(A, b, P, x0, toll, nmax, alphaOpt)

% Alpha dinamico

[xDyn, kDyn] = richardson(A, b, P, x0, toll, nmax)

% Scegliendo P come tril(A) e alpha = 1 abbiamo Gauss - Seidel

P = tril(A);
alpha = 1;

BR = eye(n) - alpha * (P \ A); % senza parentesi fa prima moltiplicazione e poi inverte
rhoBR =  max(abs(eig(BR)));

[xR, kR] = richardson(A, b, P, x0, toll, nmax, alpha)

[xGS, kGS] = gs(A, b, x0, toll, nmax)

max(abs(xR - xGS)) % con le impostazioni di prima Richardson è uguale a Gauss - Seidel

% Punto 6

P = diag(2*ones(n,1)) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);

if P==P'
    if eig(P)>0
        disp('P è SDP')
    end
end

condInvPA = cond(P \ A); % num condizionamento inversa di P per A

lambdaMaxInvPA = max(eig(P \ A));
lambdaMinInvPA = min(eig(P \ A));
alphaOptInvPA = 2 / (lambdaMinInvPA + lambdaMaxInvPA);

BROptInvPA = eye(n) - alphaOptInvPA * (P \ A);
rhoBROptInvPA = max(eig(BROptInvPA));

[xROptInvPA, kROptInvPA] = richardson(A, b, P, x0, toll, nmax, alphaOptInvPA)

[xGrad, kGrad] = richardson(A, b, P, x0, toll, nmax)

%% 4.1

clear
clc

n = 300;
A = diag(6*ones(n,1)) - 2*diag(ones(n-1,1),1) -2*diag(ones(n-1,1),-1) ...
    + diag(ones(n-2,1),2) + diag(ones(n-2,1),-2);

xEx = ones(n,1);
b = A * xEx;

% Punto 1

% P = diag(A) Jacobi

BJ = eye(n) - diag(1./diag(A)) * A;
rhoBJ = max(abs(eig(BJ)));

PGS = tril(A); % matrice P di Gauss - Seidel
BGS = eye(n) - PGS \ A;
rhoBGS = max(abs(eig(BGS))) % più veloce Gauss Seidel perché ha raggio spettrale più piccolo ??

% Nota: A è SDP quindi GS converge

x0 = b;
toll = 1e-6;
nmax = 1000;

[xGS, kGS] = gs(A, b, x0, toll, nmax)

% resNorm = ||b - A*xk|| / ||b||
% errRel = ||xk - xEx|| / ||xEx||
% errRelStima = K(A) * resNorm

resNorm = norm(b - A * xGS) / norm(b)
errRel = norm(xEx - xGS) / norm(xEx)
errRelStima = cond(A) * resNorm

% Punto 4

% ||ek||A <= d^k * ||e0||A

condA = max(eig(A)) / min(eig(A)); % perché A è SDP
k = 20;
d = (condA - 1) / (condA + 1);

err0NormA = sqrt((xEx - x0)' * A * (xEx - x0));

errNormAStima = d^k * err0NormA

% Crea funzione norma A e fuznione matrice tridiagonale

betav= [2 3 4 5];
dv = [];

for beta=betav % scorre da solo il vettore SOLO se riga
    P = diag(beta*ones(n,1)) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);
    condInvPA = max(eig(P \ A)) / min(eig(P \ A));
    d = (condInvPA - 1) / (condInvPA + 1);
    dv = [dv d]; % dv spazio o virgola fa vettore riga, con punto e virgola fa vettore colonna
end

plot(betav, dv)