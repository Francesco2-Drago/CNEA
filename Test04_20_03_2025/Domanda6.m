clear
close all
clc

n = 100;

A = 8.1*diag(ones(1, n)) - 3*diag(ones(1, n-1), 1) - 3*diag(ones(1, n-1), -1)...
    - diag(ones(1, n-2), 2) - diag(ones(1, n-2), -2);

rhoB = [];

for beta=2:0.001:2.5
    P = beta*diag(ones(1, n)) - diag(ones(1, n-1), 1) - diag(ones(1, n-1), -1);
    alphaOpt = 2 / (min(eig(P\A)) + max(eig(P\A)));
    B = eye(n) - alphaOpt * (P\A);
    rhoB = [rhoB max(eig(B))];
end

plot(2:0.001:2.5, rhoB, '*-')
title('Grafico')
legend('Raggio Spet.', Location='northeastoutside')
xlabel('\beta')