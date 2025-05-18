clear
close
clc

gamma = 1;

A = [2*gamma 2 -8
     2 0 1
     gamma 1 8]

[L, U] = lu(A)
y = fwsub(L, [1 8 2]')

%%

clear
close
clc

g = sym('pippo') % definisco variabile con nome "g" e valore "pippo"
assume(g>0)
A = [2*g 2 -8; 2 0 1; g 1 8]

[L, U] = lu(A)
y = L \ [1 8 2]'