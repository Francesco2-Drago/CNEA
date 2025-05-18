clear
close all
clc

syms b

A = [10 -2
    -2 b];

x = [1 1]';

assume(b > 0)

l = x' * A * x

l1 = (x' * A * x) / (x' * x) % Così perché autovettore deve avere norma 1!!!