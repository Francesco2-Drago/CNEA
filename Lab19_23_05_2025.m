%% Es. 1.1

clear
close all
clc

a = 0;
b = 1;

alpha = 1;
beta = -2;

mu = 1;

f = @(x) exp(3*x) .* (-4 + 3*x + 9*x.^2);

yEx = @(x) exp(3*x) .* (x - x.^2) + 1 - 3*x;

% Punto 1

% Verifico che yEx sia la soluzione, verificando che il problema sia
% un'identità

% yEx' = 3*exp(3*x) * (x - x^2) + exp(3*x) * (1 - 2*x) - 3
% yEx'' = 3*exp(3*x) * (1 + x - 3*x^2) + exp(3*x) * (1 - 6*x) = 
%       = exp(3*x) * (-4 + 3*x + 9*x^2)
% -yEx'' = f OK
% yEx(0) = 1 OK
% yEx(1) = -2 OK

d2yEx = diff(str2sym(func2str(yEx)), 2);
f_sym = str2sym(func2str(f));

err = simplify(d2yEx + f_sym); % differenza uguale a zero quindi ho identità OK
yEx(0); % = 1 OK
yEx(1); % = -2 OK

% Punto 2

% Differenze centrate, v. appunti

% A = mu/h^2 * tridiag(-1, 2, -1) matrice N x N a coefficienti reali
% b = [f(u1) + alpha * mu/h^2; f(u2); ...; f(uN) + beta * mu/h^2]

% Punto 2

% N + 1 = 20

N = 20 - 1;
h = (b - a) / (N + 1);
xNodi = nodi_general('EQ', N + 1, a, b); % funzione crea N + 1 nodi di tipo equispaziato ('EQ') nell'intervallo definito tra a e b (in assenza -> simbolico)

% Af = diag(2 * ones(N, 1));
A = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
A = (mu / h^2) * A;

bv = f(xNodi(2:end-1));
bv(1) = bv(1) + (alpha * mu)/h^2;
bv(end) = bv(end) + (beta * mu)/h^2;

% A * u = b
u = A \ bv;
u = [alpha; u; beta];

plot(xNodi, yEx(xNodi), xNodi, u)
legend('Exact', 'Approx')

% Punto 4

Nv = [10 20 40 80 160];
hv = (b - a) ./ (Nv + 1);
errv = [];
Kv = [];
it = 1;

for N = Nv
    % xNodi = linspace(a, b, N)';
    xNodi = nodi_general('EQ', N + 1, a, b);
    h = hv(it);

    % Af = diag(2 * ones(N, 1));
    A = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
    A = (mu / h^2) * A;
    
    bv = f(xNodi(2:end-1));
    bv(1) = bv(1) + (alpha * mu)/h^2;
    bv(end) = bv(end) + (beta * mu)/h^2;
    
    % A * u = b
    u = A \ bv;
    u = [alpha; u; beta];

    errv = [errv, max(abs(u - yEx(xNodi)))];
    it = it + 1;

    Kv = [Kv, condest(A)];
end

figure
loglog(hv, errv, hv, hv, '-.', hv, hv.^2, '-.')
legend('Err', 'h', 'h^2')

figure
loglog(hv, Kv, hv, 1./hv, '-.', hv, 1./hv.^2, '-.')
legend('Cond', '1/h', '1/h^2')

%% Es. 1.2

clear
close all
clc

a = 0;
b = 1;

alpha = 1;
beta = exp(3);

mu = 1;

sigma = @(x) 1 + sin(2*pi*x);
f = @(x) exp(3*x) .* (sin(2*pi*x) - 8);

yEx = @(x) exp(3*x);

% Punto 3

N = 20 - 1;
h = (b - a) / (N + 1);
xNodi = nodi_general('EQ', N + 1, a, b); % funzione crea N + 1 nodi di tipo equispaziato ('EQ') nell'intervallo definito tra a e b (in assenza -> simbolico)

% Af = diag(2 * ones(N, 1));
A = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
A = (mu / h^2) * A;
A = A + sparse(1:N, 1:N, sigma(xNodi(2:end-1)));

bv = f(xNodi(2:end-1));
bv(1) = bv(1) + (alpha * mu)/h^2;
bv(end) = bv(end) + (beta * mu)/h^2;

% A * u = b
u = A \ bv;
u = [alpha; u; beta];

plot(xNodi, yEx(xNodi), xNodi, u)
legend('Exact', 'Approx')

% Punto 4

hv = [0.04 0.02 0.01 0.005 0.0025];
Nv = ceil((b - a) ./ hv - 1);
errv = [];
Kv = [];
it = 1;

for N = Nv
    % xNodi = linspace(a, b, N)';
    xNodi = nodi_general('EQ', N + 1, a, b);
    h = hv(it);

    % Af = diag(2 * ones(N, 1));
    A = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
    A = (mu / h^2) * A;
    A = A + sparse(1:N, 1:N, sigma(xNodi(2:end-1)));
    
    bv = f(xNodi(2:end-1));
    bv(1) = bv(1) + (alpha * mu)/h^2;
    bv(end) = bv(end) + (beta * mu)/h^2;
    
    % A * u = b
    u = A \ bv;
    u = [alpha; u; beta];

    errv = [errv, max(abs(u - yEx(xNodi)))];
    it = it + 1;

    Kv = [Kv, condest(A)];
end

figure
loglog(hv, errv, hv, hv, '-.', hv, hv.^2, '-.')
legend('Err', 'h', 'h^2')

figure
loglog(hv, Kv, hv, 1./hv, '-.', hv, 1./hv.^2, '-.')
legend('Cond', '1/h', '1/h^2')

%% Es. 2.1

clear
close all
clc

a = 0;
b = 1;

alpha = 0;
beta = 1;

mu = 1e-2;
eta = 1;

f = @(x) 0 * x;

yEx = @(x) (exp(eta / mu * x) - 1) / (exp(eta / mu) - 1);

N = 20 - 1;
h = (b - a) / (N + 1);
xNodi = nodi_general('EQ', N + 1, a, b); % funzione crea N + 1 nodi di tipo equispaziato ('EQ') nell'intervallo definito tra a e b (in assenza -> simbolico)

% Af = diag(2 * ones(N, 1));
Ad = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
Ad = (mu / h^2) * Ad;
At = sparse(1:N - 1, 2:N, 1, N, N) + sparse(2:N, 1:N - 1, -1, N, N);
At = (eta / (2*h)) * At;

A = Ad + At;

bv = f(xNodi(2:end-1));
bv(1) = bv(1) + (alpha * mu)/h^2 + (alpha * eta) / (2*h);
bv(end) = bv(end) + (beta * mu)/h^2 - (beta * eta) / (2*h);

% A * u = b
u = A \ bv;
u = [alpha; u; beta];

plot(xNodi, yEx(xNodi), xNodi, u)
legend('Exact', 'Approx')

% Punto

Peh = (abs(eta) * h) / (2 * mu); % 2.5

% Peh < 1 => h < hmax
hmax = (2 * mu) / abs(eta);

Nv = [30 60 120 240 480] - 1;
hv = (b - a) ./ (Nv + 1);
errv = [];
Kv = [];
it = 1;

for N = Nv
    % xNodi = linspace(a, b, N)';
    xNodi = nodi_general('EQ', N + 1, a, b);
    h = hv(it);

    % Af = diag(2 * ones(N, 1));
    Ad = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
    Ad = (mu / h^2) * Ad;
    At = sparse(1:N - 1, 2:N, 1, N, N) + sparse(2:N, 1:N - 1, -1, N, N);
    At = (eta / (2*h)) * At;

    A = Ad + At;

    bv = f(xNodi(2:end-1));
    bv(1) = bv(1) + (alpha * mu)/h^2 + (alpha * eta) / (2*h);
    bv(end) = bv(end) + (beta * mu)/h^2 - (beta * eta) / (2*h);
    
    % A * u = b
    u = A \ bv;
    u = [alpha; u; beta];

    errv = [errv, max(abs(u - yEx(xNodi)))];
    it = it + 1;

    Kv = [Kv, condest(A)];
end

figure
loglog(hv, errv, hv, hv, '-.', hv, hv.^2, '-.')
legend('Err', 'h', 'h^2')

figure
loglog(hv, Kv, hv, 1./hv, '-.', hv, 1./hv.^2, '-.')
legend('Cond', '1/h', '1/h^2')

% Punto 6

N = 20 - 1;
h = (b - a) / (N + 1);
xNodi = nodi_general('EQ', N + 1, a, b); % funzione crea N + 1 nodi di tipo equispaziato ('EQ') nell'intervallo definito tra a e b (in assenza -> simbolico)

mu = mu*(1 + Peh);

% Af = diag(2 * ones(N, 1));
Ad = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
Ad = (mu / h^2) * Ad;
At = sparse(1:N - 1, 2:N, 1, N, N) + sparse(2:N, 1:N - 1, -1, N, N);
At = (eta / (2*h)) * At;

A = Ad + At;

bv = f(xNodi(2:end-1));
bv(1) = bv(1) + (alpha * mu)/h^2 + (alpha * eta) / (2*h);
bv(end) = bv(end) + (beta * mu)/h^2 - (beta * eta) / (2*h);

% A * u = b
u = A \ bv;
u = [alpha; u; beta];

figure
plot(xNodi, yEx(xNodi), xNodi, u)
legend('Exact', 'Approx')

% Punto 7

Nv = [30 60 120 240 480] - 1;
hv = (b - a) ./ (Nv + 1);
errv = [];
Kv = [];
it = 1;

for N = Nv
    % xNodi = linspace(a, b, N)';
    xNodi = nodi_general('EQ', N + 1, a, b);
    h = hv(it);

    % Af = diag(2 * ones(N, 1));
    Ad = sparse(1:N, 1:N, 2) + sparse(1:N - 1, 2:N, -1, N, N) + sparse(2:N, 1:N - 1, -1, N, N); % primo N come numero di righe, secondo come numero colonne
    Ad = (mu / h^2) * Ad;
    At = sparse(1:N - 1, 2:N, 1, N, N) + sparse(2:N, 1:N - 1, -1, N, N);
    At = (eta / (2*h)) * At;

    A = Ad + At;

    bv = f(xNodi(2:end-1));
    bv(1) = bv(1) + (alpha * mu)/h^2 + (alpha * eta) / (2*h);
    bv(end) = bv(end) + (beta * mu)/h^2 - (beta * eta) / (2*h);
    
    % A * u = b
    u = A \ bv;
    u = [alpha; u; beta];

    errv = [errv, max(abs(u - yEx(xNodi)))];
    it = it + 1;

    Kv = [Kv, condest(A)];
end

figure
loglog(hv, errv, hv, hv, '-.', hv, hv.^2, '-.')
legend('Err', 'h', 'h^2')

figure
loglog(hv, Kv, hv, 1./hv, '-.', hv, 1./hv.^2, '-.')
legend('Cond', '1/h', '1/h^2')

%%

clear
close all
clc

a = 0;
b = 1;

alpha = 1;
gamma = -exp(3);

mu = 1;
f = @(x) exp(3*x) .* (-4 + 3*x + 9*x.^2);
yEx = @(x) exp(3*x) .* (x - x.^2) + 1;

N = 100 - 1;
h = (b - a) / (N + 1);
xNodi = linspace(a, b, N + 2)';

A = sparse(1:N, 1:N, 2, N + 1, N + 1) + sparse(1:N - 1, 2:N, -1, N + 1, N + 1) + sparse(2:N, 1:N - 1, -1, N + 1, N + 1); % primo N come numero di righe, secondo come numero colonne
A = (mu / h^2) * A;
A(end, end - 1) = -mu/h;
A(end, end) = mu/h;

bv = f(xNodi(2:end));
bv(1) = bv(1) + alpha * mu/h^2;
bv(end) = gamma;

u = A \ bv;
u = [alpha; u];

plot(xNodi, yEx(xNodi), xNodi, u)
legend('Exact', 'Approx')

% 

Nv = [50 100 200 400 800];
hv = (b - a) ./ (Nv + 1);
errv = [];
Kv = [];
it = 1;

for N = Nv
    % xNodi = linspace(a, b, N)';
    xNodi = linspace(a, b, N + 2)';
    h = hv(it);

    A = sparse(1:N, 1:N, 2, N + 1, N + 1) + sparse(1:N - 1, 2:N, -1, N + 1, N + 1) + sparse(2:N, 1:N - 1, -1, N + 1, N + 1); % primo N come numero di righe, secondo come numero colonne
    A = (mu / h^2) * A;
    A(end, end - 1) = -mu/h;
    A(end, end) = mu/h;

    bv = f(xNodi(2:end));
    bv(1) = bv(1) + alpha * mu/h^2;
    bv(end) = gamma;

    u = A \ bv;
    u = [alpha; u];

    errv = [errv, max(abs(u - yEx(xNodi)))];
    it = it + 1;

    Kv = [Kv, condest(A)];
end

figure
loglog(hv, errv, hv, hv, '-.', hv, hv.^2, '-.')
legend('Err', 'h', 'h^2')

figure
loglog(hv, Kv, hv, 1./hv, '-.', hv, 1./hv.^2, '-.')
legend('Cond', '1/h', '1/h^2')