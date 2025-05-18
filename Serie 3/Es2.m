%% Es. 2

clear
close all
clc

% Punto 1 funzione invpower

% Punto 2

A = toeplitz(1:4);

toll = 1e-6;
nmax = 100;

x0 = [1 2 3 4]';

[lambda, x, iter] = invpower(A, toll, nmax, x0)

x0 = ones(4, 1);

[lambda, x, iter] = invpower(A, toll, nmax, x0)
% Sfortunatamente abbiamo scelto x0 ortogonale all'autovettore
% dell'autovalore minimo quindi non convergiamo.
% Usando invece la funzione invpower_mod, riusciamo a convergere perché
% continuiamo a iterare e ad ogni iterazione abbiamo degli errori dati
% dall'aritmetica non esatta del computer che vengono amplificati
% dall'autovalore minimo e quindi convergiamo (fossimo già sul minimo,
% all'iterazione successiva se ne andrebbe e poi eventualmente tornerebbe
% in forma minima e così via)

[lambda, x, iter] = invpower_mod(A, nmax, x0)

% In questo caso iter non rappresenta il numero di terazioni ma è un
% vettore che indica la differenza in modulo tra l'autovettore esatto e
% calcolato approssimato alla iterazione. Quando è 1 allora coincidono, il
% vettore è lungo nmax + 1