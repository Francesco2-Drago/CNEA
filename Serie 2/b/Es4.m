%% 4.1

clear
close all
clc

n = 300;

A = 6*diag(ones(1, n)) - 2*diag(ones(1, n-1), 1) - 2*diag(ones(1, n-1), -1)...
    + diag(ones(1, n-2), 2) + diag(ones(1, n-2), -2);

xEx = ones(n, 1);

b = A * xEx;

% Punto 1

D = diag(diag(A));
DInv = diag(1./diag(A));
BJ = eye(n) - DInv * A;

P = tril(A);
BGS = eye(n) - P \ A;

rhoBJ = max(abs(eig(BJ)));
rhoBGS = max(abs(eig(BGS)));
% i raggi spettrali sono entrambi minori di 1 quindi convergono entrambi i
% metodi per ogni scelta di x0

% Punto 2

% Utilizzerei Gauss-Seidel perché il raggio spettrale della matrice di
% iterazione BGS è molto più piccolo di quella del metodo del gradiente
% quindi arriverà a convergenza prima, con minori iterazioni e tempo

% Punto 3

toll = 1e-6;
nmax = 1e3;
x0 = b;

[xGS, kGS] = gs(A, b, x0, toll, nmax);

kGS

errRel = norm(xEx - xGS) / norm(xEx)
resNorm = norm(b - A*xGS) / norm(b)
errStima = cond(A) * resNorm % Stima errore ipotesi variazione matrice A
% fratto matrice a in norma 2 è zero. cond(A) da numero di condizionamento
% in norma 2, spettrale con condeig(A)

% Punto 4

d = (cond(A) - 1) / (cond(A) + 1);
err0 = xEx - x0;
errNormAStima = d^20 * sqrt(err0' * A * err0)

% Punto 5

dv = [];

for beta=2:5
    P = beta*diag(ones(1, n)) - diag(ones(1, n-1), 1) - diag(ones(1, n-1), -1);

    condPInvA = max(abs(eig(P \ A))) / min(abs(eig(P \ A)));
    d = (condPInvA - 1) / (condPInvA + 1);

    [xGrad, kGrad] = richardson(A, b, P, x0, toll, nmax);
    kGrad

    dv = [dv d];
end

plot(2:5, dv, '*-', 'MarkerSize', 10)
legend('No. di cond.')

% Converge prima per beta = 4 perché la matrice di iterazione ha numero di
% condizionamento minore e quindi la coppa è più simile ad un vaso di
% cerchi, gli autovalori sono tutti simili. L'errore in norma A scenderà
% prima

% Punto 6

xPCG = pcg(A, b, toll, nmax, [], [], x0);

errNormA = sqrt((xPCG - xEx)' * A * (xPCG - xEx))

%% 4.2

clear
close all
clc

n = 4;

A = diag([1 10 100 1000]) - 3*diag(ones(1, n-1), 1) - 3*diag(ones(1, n-1), -1)...
    - 2*diag(ones(1, n-2), 2) - 2*diag(ones(1, n-2), -2) - diag(ones(1, n-3), 3)...
    - diag(ones(1, n-3), -3);

b = [-5 2 92 994]';

% A è SDP?

if isequal(A, A')
    disp('A è simmetrica')
    if eig(A)>0
        disp('A è definita positiva')
    else
        disp('A non è definita positiva')
    end
else
    disp('A non è simmetrica')
end

% Punto 1

k = 100;

condA = max(eig(A)) / min(eig(A));
d = (condA - 1) / (condA + 1);
fattAbbGrad = d^k

c = (sqrt(condA) - 1) / (sqrt(condA) + 1);
fattAbbGradConj = (2 * c^k) / (1 + c^(2 * k))

% Punto 2

x0 = zeros(n, 1);

r0 = b - A * x0;

alpha0 = (r0' * r0) / (r0' * A * r0);

x1 = x0 + alpha0 * r0;
r1 = r0 - alpha0 * A * r0;
alpha1 = (r1' * r1) / (r1' * A * r1);

x2 = x1 + alpha1 * r1;
r2 = r1 - alpha1 * A * r1;

angolo1 = acos((r0 / norm(r0))' * (r1 / norm(r1))) * 180 / pi
angolo2 = acos((r1 / norm(r1))' * (r2 / norm(r2))) * 180 / pi

% Punto 3

x0 = zeros(n, 1);

r0 = b - A * x0;
p0 = r0;

alpha0 = (p0' * r0) / (p0' * A * p0);

x1 = x0 + alpha0 * p0;
r1 = r0 - alpha0 * A * p0;
beta0 = (p0' * A * r1) / (p0' * A * p0);
p1 = r1 - beta0 * p0;

alpha1 = (p1' * r1) / (p1' * A * p1);

x2 = x1 + alpha1 * p1;
r2 = r1 - alpha1 * A * p1;
beta1 = (p1' * A * r2) / (p1' * A * p1);
p2 = r2 - beta1 * p1;

angolo1Conj = acos((p1 / norm(p1))' * (p0 / norm(p0))) * 180 / pi
angolo2Conj = acos((p2 / norm(p2))' * (p1 / norm(p1))) * 180 / pi

% Punto 4 funzione conjgrad_it

% Punto 5

nmax = 1e3;
toll = 1e-6;

[x, k] = conjgrad_it(A, b, x0, nmax, toll)

% Punto 6

xEx = ones(n, 1);

errRelV = [];
resNormV = [];

for i=1:k+1
    errRelV(i) = norm(xEx - x(:, i)) / norm(xEx);
    resNormV(i) = norm(b - A * x(:, i)) / norm(b);
end

semilogy(0:k, errRelV, 'o-', 0:k, resNormV, '*-')
grid on
legend('Err. Rel.', 'Res. Norm.')
xlabel('No. iterazioni')