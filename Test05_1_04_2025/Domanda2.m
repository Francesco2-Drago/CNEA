clear
close all
clc

A = hilb(3);

abbErr = 200;

d = (cond(A) - 1) / (cond(A) + 1)

syms k

double(solve(1/abbErr == d^k, k,"Real",true))

solve(1/abbErr <= d^k, k, "Real",true,"ReturnConditions",true)