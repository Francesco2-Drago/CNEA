clear
close all
clc

n = 3;

A = [1e-6 1e6 1
    1 0 1
    1 1 1]

epsMacchina = 2^(-52)

rho = 1e12/1e6

errore = 8 * n^3 * epsMacchina * rho