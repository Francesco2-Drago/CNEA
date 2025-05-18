%% 4.1

clear
clc

L = 20;
K = 100;
T = zeros(3, 10);

for i=1:10
    n = 500 * i;

    A = -2 * diag(ones(1, n)) + diag(ones(1, n-1), 1) + diag(ones(1, n-1), -1);
    A = K * A;

    f = zeros(n, 1);
    f(end) = - K * L;

    tic % Inizio fattorizzazione LU

    [LL, UU, PP] = lu(A);

    % y = fwsub(LL, PP * f);
    % x = bksub(UU, y);

    x = UU \ (LL \ (PP * f));

    T(1, i) = toc;

    tic % Inizio fattorizzazione Thomas

    [LL, UU, x] = thomas(A, f);

    T(2, i) = toc;

    tic % Inizio fattorizzazione Cholesky

    R = chol(-A);

    % y = fwsub(R', -f);
    % x = bksub(R, y);

    x = R \ (R' \ -f);

    T(3, i) = toc;
end

figure
plot(500:500:5000, T(1, :), 'o-b', 'LineWidth', 2)
hold on
plot(500:500:5000, T(2, :), '*-r', 'LineWidth', 2)
plot(500:500:5000, T(3, :), '+-w', 'LineWidth', 2)
title('Confronto prestazioni')
legend('LU', 'Thomas', 'Cholesky', 'Location','northeast')