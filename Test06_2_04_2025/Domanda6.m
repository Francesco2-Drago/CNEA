clear
close all
clc

syms k
syms g natural

eqn = 2^(-g) >= 4/2^(k+1);

solve(eqn, k, "Real",true,"ReturnConditions",true)