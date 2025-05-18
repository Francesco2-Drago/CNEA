%% Serie 02a

%% 2.1

clear
clc

n = 1000;

A = hilb(n);
B = rand(n);

x_ex = ones(1000, 1);
y_ex = ones(1000, 1);

b = A * x_ex;
c = B * y_ex;

% comando backslash come "mldivide" quando chiamo help

x = A \ b;
y = B \ c;

cond(A)
cond(B) % stampo i due numeri di condizionamento

norm(x - x_ex) / norm(x_ex)
norm(y - y_ex) / norm(y_ex)

%% Capitolo 3 Thomas, funzione thomas 3.1

clear
clc

K = 100;
L = 20;
N = 20;

tic

n = N - 1;
A = diag(-2*ones(n, 1)) + diag(ones(n-1, 1),-1) + diag(ones(n-1,1),1);

A = K * A;

f = zeros(n, 1);
f(end) = - K * L; % per accedere ad ultima casella

[LL, UU, x] = thomas(A, f);

toc

%% Continuo sopra con confronto prestazioni tempo 4.1

% tic e toc per calcolare il tempo di esecuzione

clear
clc

K = 100;
L = 20;

T = zeros(3, 10);
for i=1:10
    n = 500 * i;

    A = diag(-2*ones(n, 1)) + diag(ones(n-1, 1),-1) + diag(ones(n-1,1),1);

    A = K * A;

    f = zeros(n, 1);
    f(end) = - K * L; % per accedere ad ultima casella

    tic
    
    [LL, UU, PP] = lu(A);
    x_lu = UU \ (LL \ (PP * f));

    T(1, i) = toc;

    tic
 
    [LL, UU, x] = thomas(A, f);

    T(2, i) = toc;

    A_chol = -A;
    f_chol = -f;

    tic

    H = chol(A_chol);
    x_chol = H \ (H' \ f_chol);

    T(3, i) = toc;
end

dim = 500:500:5000;
figure;
hold on;
plot(dim, T(1, :), '-ob', 'LineWidth', 2);
plot(dim, T(2, :), '-or', 'LineWidth', 2);
plot(dim, T(3, :), '-ow', 'LineWidth', 2);
legend('LU', 'Thomas', 'Cholesky')
hold off

%% 5.1

clear
clc

n = 20;
A = diag(4*ones(n, 1)) - diag(ones(n - 1, 1), 1) + ...
    - diag(ones(n - 1, 1), - 1);

A(1, :) = ones(1, n);
A(:, 1) = ones(n, 1);

spy(A) % componeneti non nulle segnate in basso

% comando sparse crea matrice sparsa o costruisce matrice sparsa da piena

% As = sparse(A);

[L, U, P, Q] = lu(sparse(A)); % guarda commento dopo per pivoting totale

figure(1)
spy(A)

figure(2)
spy(L)

figure(3)
spy(U)

% proviamo a usare pivoting totale, solo con sparse(A)
% PAQ = LU