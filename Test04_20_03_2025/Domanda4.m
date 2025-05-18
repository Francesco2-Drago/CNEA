clear
close all
clc

n = 2;

A = [3 -1
    -1 2]

b = ones(n, 1)

syms beta
assume(beta ~= 0)

P = [beta -1
    0 2]

B = eye(n) - P\A

lambdaB = abs(eig(B))

solve(max(lambdaB) < 1, beta, "Real", true, "ReturnConditions", true)

% for beta=1:0.01:10
%     plot(beta, subs(lambdaB(2)), '*-')
%     hold on
% end