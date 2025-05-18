function [L, U, x] = thomas(A, b)

N = size(A, 1);

% inizializzazione

U = diag(diag(A, 1), 1);
L = eye(N);

% definizione vettori

y = zeros(N, 1);
x = zeros(N, 1);

% fattorizzazione

U(1,1) = A(1,1);

for i=2:N
    L(i, i-1) = A(i, i-1) / U(i-1, i-1);
    U(i, i) = A(i, i) - L(i, i-1) * U(i-1, i);
end

% Risoluzione

y(1) = b(1);

for i=2:N
    y(i) = b(i) - L(i, i-1) * y(i-1);
end

x(N) = y(N) / U(N, N);

for i=N-1:-1:1
    x(i) = (y(i) - U(i, i + 1) * x(i+1)) / U(i, i);
end

end