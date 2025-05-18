%% 3.1

clear
clc

N = 20;
n = N - 1;
L = 20;
K = 100;

A = -2 * diag(ones(1, n)) + diag(ones(1, n-1), 1) + diag(ones(1, n-1), -1);

A = K * A;

f = zeros(n, 1);
f(end) = - K * L;

[LA, UA, PA] = lu(A);

y = fwsub(LA, PA * f);
x = bksub(UA, y);