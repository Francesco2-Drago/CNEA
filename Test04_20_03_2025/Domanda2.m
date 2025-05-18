clear
close all
clc

n = 3;

syms g
assume(g, 'clear')

A = g*ones(n);

for i=1:n
    A(i, i) = 1;
end

A

eig(A)

BJ = eye(n) - diag(1./diag(A)) * A

eig(BJ)

rhoBJ = max(abs(eig(BJ)))

sol = solve(-1<-2*g & -2*g<1, g, ReturnConditions=true)

% 2\gamma,\ \gamma\in\left(-\frac{1}{2},\ \frac{1}{2}\right)