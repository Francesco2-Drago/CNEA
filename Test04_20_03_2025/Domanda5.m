clear
close all
clc

n = 4;

A = hilb(n)

fattoreAbb = 1e-3;

if isequal(A, A')
    disp('A è simmetrica')
    if eig(A)>0
        disp('A è definita positiva')
    end
end

condA = max(eig(A)) / min(eig(A));

d = (condA - 1) / (condA + 1)

syms k

x = solve(d^k == fattoreAbb)

double(x)