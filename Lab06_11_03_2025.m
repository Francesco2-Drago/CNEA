%% 3.2 Gradiente e gradiente precondizionato

% Funzione pcg per metodo del gradiente e gradiente coniugato

clear
close all
clc

toll = 1e-6;
nmax = 5e3;
N = 5:20;

itP = [];
itNP = []; % vettori numero di iterazioni nei due casi
K = []; % numero di condizionamento
KPrec = [];
itCG = [];

for n = N
    A = 4*diag(ones(1, n)) + diag(ones(1, n-1), 1) + diag(ones(1, n-1), -1) ...
        + 2*diag(ones(1, n-2), 2) + 2*diag(ones(1, n-2), -2);

    K = [K cond(A)];
    P = tril(A);
    KPrec = [KPrec cond(P \ A)];

    b = ones(n, 1);

    x0 = zeros(n, 1);

    [xNP, kNP] = richardson(A, b, eye(n), x0, toll, nmax); % metodo del gradiente non precondizionato
    itNP = [itNP kNP];

    [xP, kP] = richardson(A, b, P, x0, toll, nmax); % metodo del gradiente precondizionato
    itP = [itP kP];

    [~, ~, ~, kCG] = pcg(A, b, toll, nmax, [], [], x0);
    itCG = [itCG kCG];
end

% Punto 2

semilogy(N, itNP, N, itP, 'LineWidth', 2)
grid on
legend('Gradiente non prec.', 'Gradiente precondizionato')

figure
plot(N, K, N, KPrec, 'LineWidth', 2)
grid on
legend('K(A)', 'K(P\A)')

% Ora chiamata a gradiente coniugato uguale
% M1 e M2 come precondizionatori sinistro e destro rispettivamente, da
% sopprimere se non ci interessano con eye o [] per arrivare ad input di
% x0, risultati x come vettore soluzione, flag se arriva a convergenza o
% meno, residuo relativo, numero di iterazioni e vettore residuo

figure
semilogy(N, itNP, N, itP, N, itCG, 'LineWidth', 2)
grid on
legend('Gradiente non prec.', 'Gradiente precondizionato', 'Grad. coniugato non prec.')

%% 4.1 ultimo punto, resto copiato da scorso laboratorio

clear
close all
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
grid on
xlabel('\beta')
ylabel('d')

% Punto 6

[xCG, ~, ~, kCG] = pcg(A, b, toll, nmax, [], [], b);

errNormA = sqrt((xCG - xEx)' * A * (xCG - xEx));

%% 4.2

clear
close all
clc

n = 4;

A = [1 -3 -2 -1;
    -3 1e1 -3 -2;
    -2 -3 1e2 -3;
    -1 -2 -3 1e3];

b = [-5 2 92 994]';

% grad: ||x-xk||_A <= d^k ||x-x0||_A
% d = (K(A)-1)/(K(A)+1)

% grad conj: ||x-xk||_A <= (2*c^k)/(1+c^(2k)) ||x-x0||_A
% c = sqrt((K(A)-1)/(K(A)+1))

k = 100;
condA = max(eig(A))/min(eig(A));
d = (condA - 1)/(condA + 1);
fattAbbGrad100 = d^k;

c = (sqrt(condA) - 1) / (sqrt(condA) + 1);
fattAbbGradConj100 = (2 * c^k) / (1 + c^(2 * k));

% Punto 2

x0 = zeros(n, 1);
r0 = b - A * x0;
alpha0 = (r0' * r0) / (r0' * A * r0);

x1 = x0 + alpha0 * r0;
r1 = r0 - alpha0 * A * r0;
alpha1 = (r1' * r1) / (r1' * A * r1);

x2 = x1 + alpha1 * r1;
r2 = r1 - alpha1 * A * r1;

% angolo tra v1 e v2: acos((v1/||v1||) * (v2/||v2||))
angolo1 = acos((r0 / norm(r0))' * (r1 / norm(r1))) * 180 / pi % per convertire in gradi
angolo2 = acos((r1 / norm(r1))' * (r2 / norm(r2))) * 180 / pi

% Punto 3

x0 = zeros(n, 1);
r0 = b - A * x0;
p0 = r0;
alpha0 = (p0' * r0) / (p0' * A * p0);

x1 = x0 + alpha0 * p0;
r1 = r0 - alpha0 * A * p0;
beta0 = (p0' * r1) / (p0' * A * p0);
p1 = r1 - beta0 * p0;

alpha1 = (p1' * r1) / (p1' * A * p1);
x2 = x1 + alpha1 * p1;
r2 = r1 - alpha1 * A * p1;
beta1 = (p1' * r2) / (p1' * A * p1);
p2 = r2 - beta1 * p1;

angolo1 = acos((p0 / norm(p0))' * (p1 / norm(p1))) * 180 / pi
angolo2 = acos((p1 / norm(p1))' * (p2 / norm(p2))) * 180 / pi