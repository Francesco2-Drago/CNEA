%% 6.1

clear
close
clc

% Punto 1+2

N = 10;
condAStima = zeros(1, N);
condA = zeros(1, N);

for i=1:N
    n = i * 10;

    A = 2 * diag(ones(1, n)) - diag(ones(1, n-1), 1) - diag(ones(1, n-1), -1);
    lamndaMax = 2 + 2 * cos(pi / (n+1));
    lamndaMin = 2 + 2 * cos(pi / (n+1) * n);

    condAStima(i) = lamndaMax / lamndaMin;
    condA(i) = cond(A);
end

semilogy(1:N, condAStima, 'o-r', 1:N, condA, '*-b')
legend('Stima', 'Vero', 'Location','northeast')

% Punto 3 + 4
% Thomas perché matrice è tridiagonale e scala come n e non come 2/3 * n^3
% Totale operazioni con Thomas: 8n-7

% Punto 5

n = 100;
xEx = ones(n, 1);
b = A * xEx;

c = rand(size(b));
c = c ./ norm(c);

deltaB = 1e-6 * c;

x = A \ (b + deltaB);

errRel = norm(x - xEx) / norm(xEx);