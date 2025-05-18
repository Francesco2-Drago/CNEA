%% 2.1

clear
close all
clc

n = 50;

% Punto 1

A = 4*diag(ones(1, n)) - diag(ones(1, n-1), 1) - diag(ones(1, n-1), -1)...
    - diag(ones(1, n-2), 2) - diag(ones(1, n-2), -2);

b = 0.2 * ones(n, 1);

x0 = zeros(n, 1);

% Punto 2

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

condA = max(eig(A)) / min(eig(A));

% Punto 4

P = eye(n);
PInvA = P \ A;

toll = 1e-5;
nmax = 1e4;

alpha1 = 0.2;
alpha2 = 0.33;
alphaOpt = 2 / (max(abs(eig(PInvA))) + min(abs(eig(PInvA))));

rho1 = max(abs(eig(eye(n) - alpha1 * PInvA)));
rho2 = max(abs(eig(eye(n) - alpha2 * PInvA)));
rhoOpt = max(abs(eig(eye(n) - alphaOpt * PInvA)));

[x1, k1] = richardson(A, b, P, x0, toll, nmax, alpha1)
[x2, k2] = richardson(A, b, P, x0, toll, nmax, alpha2)
[xOpt, kOpt] = richardson(A, b, P, x0, toll, nmax, alphaOpt)

% Punto 5

alphaGS = 1;
P = tril(A);

[xRGS, kRGS] = richardson(A, b, P, x0, toll, nmax, alphaGS)
[xGS, kGS] = gs(A, b, x0, toll, nmax)

% Punto 6

P = 2*diag(ones(1, n)) - diag(ones(1, n-1), 1) - diag(ones(1, n-1), -1);

if isequal(P, P')
    disp('P è simmetrica')
    if eig(P)>0
        disp('P è definita positiva')
    else
        disp('P non è definita positiva')
    end
else
    disp('P non è simmetrica')
end

PInvA = P \ A;

alphaOpt = 2 / (max(eig(PInvA)) + min(eig(PInvA)));

rho = max(abs(eig(eye(n) - alphaOpt * PInvA)));

condPInvA = cond(PInvA); % uguale a lambda max / lambda min perché A e P sono SDP quindi gli autovalori di PInvA sono sicuramente reali e positivi

[x, k] = richardson(A, b, P, x0, toll, nmax, alphaOpt)