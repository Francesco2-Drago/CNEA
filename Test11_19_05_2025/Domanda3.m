clear
close all
clc

syms z real

R = 1 + z + z.^2/2 + z.^3/6 + z.^4/24;

solve(abs(R)<1, z, 'Real', true, 'ReturnConditions', true)

double((464^(1/2)/3 - 172/27)^(1/3) - 20/(9*(464^(1/2)/3 - 172/27)^(1/3)) - 4/3)