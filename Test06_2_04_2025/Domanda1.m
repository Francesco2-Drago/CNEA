clear
close all
clc

syms g

A = [(5+4*g) (10-2*g)
    -2*g g]

abs(eig(A))

% metodo delle potenze applicabile per modulo di gamma diverso da 1 |g|~=1