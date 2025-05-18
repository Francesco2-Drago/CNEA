%% Da funzione a simbolica
str2sym(func2str(x))

% ES.
f = @(x) sin(x);

g = str2sym(func2str(f))

%% Da simbolica a funzione
matlabFunction(x)

% ES.

h = matlabFunction(g)

%%
pretty(eqn) % per stampa in formato matematico
simplify(eqn) % per semplificazioni matematiche equazione

%% Derivata

% Per fare derivata funzione usa diff su simbolica e tieni sempre
% simbolica, appena fai cambio su anonymous e poi provi di nuovo a cambiare
% in simbolica si rompe. Fai cambio in anonymous solo alla fine. Per
% controllo valore usa:

double(subs(df, alpha)) % dove df è simbolica e alpha è il valore per cui
% si vuole valutare la funzione. df rimane simbolica

% Es.

df = diff(str2sym(func2str(f)))
d2f = diff(df)
d3f = diff(d2f)

double(subs(df, alpha1))
double(subs(d2f, alpha1))
double(subs(d3f, alpha1)) % alpha1 valore per cui si vuole valutare funzione

df = matlabFunction(df)
d2f = matlabFunction(d2f)
d3f = matlabFunction(d3f) % tornare in anonymous

%% Radice approx con Erone

% Serie 1 no. 9, guarda file salvati!!!

function sqrtn = es9(n)
% Calcola la radice quadrata di n usando la
% successione di Erone.
r(1) = n;
toll = 1e-6;
incr = toll+1;
k = 2;
while incr > toll
    r(k) = 0.5*(r(k-1) + n/r(k-1));
    incr = abs(r(k) - r(k-1)); 
    k = k+1;
end
sqrtn = r(end);
plot(r,'ro-')
end

function sqrtn = erone(n)
% Calcola la radice quadrata di n usando la
% successione di Erone.
r(1) = n;
toll = 1e-6;
incr = toll+1;
k = 2;
while incr > toll
    r(k) = 0.5*(r(k-1) + n/r(k-1));
    incr = abs(r(k) - r(k-1)); 
    k = k+1;
end
sqrtn = r(end);
plot(r,'ro-')
end

%% Newton sistemi
% Per sistemi n-dimensionali di equazioni purché si passi F come anonymous
% e con variabili ben distinte (NO campi di un vettore!!!)

%% Jacobi e Gauss Seidel + residuo norm, cond, err2 + Punto 3 + Punto 5

% n = 10;
% 
% A = pentadiag(1, -5, 8, -5, 1, n);
% 
% xEx = ones(n, 1);
% 
% b = A * xEx;

BJ = eye(n) - diag(1./diag(A)) * A;
BGS = eye(n) - tril(A) \ A;

rhoBJ = max(abs(eig(BJ)));
rhoBGS = max(abs(eig(BGS)));

% x0 = zeros(n, 1);
% toll = 1e-6;
% nmax = 1e3;
% 
% [x, iter] = gs(A, b, x0, toll, nmax);

resNorm = norm(b - A*x)/norm(b);

if sdp(A)
    condA = max(eig(A)) / min(eig(A));
end

errRelStima = condA * resNorm;



% Punto 3 convergenza gradiente coniugato

P1 = eye(n);
P2 = diag(diag(A));
P3 = diag(diag(A)) + diag(diag(A, -1), -1) + diag(diag(A, 1), 1);

% Numero di condizionamento più piccolo

condP1A = max(eig(P1\A)) / min(eig(P1\A)); % = condA
condP2A = max(eig(P2\A)) / min(eig(P2\A));
condP3A = max(eig(P3\A)) / min(eig(P3\A));



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

%% fwsub bksub LU

[L, U, P] = lu(A);

y = fwsub(L, P*b);
x = bksub(U, y);


%% Condizioni cicli/funzioni

x0 = zeros(n, 1);
toll = 1e-6;
nmax = 1e3;

%% Guass_newton

% J come vettore nx2
% r come vettore nx1

% Lab 14, ultimo problema come esempio