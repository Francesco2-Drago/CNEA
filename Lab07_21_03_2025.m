%% 1

clear
close all
clc

% Punto 1

NA = 100;

A = randi([0, 1],NA);

sA = sum(A); % somma per colonne, uguale a mettere 1

for i=1:size(A, 1)
    A(i,:) = A(i,:) ./ sA;
end

% Punto 2

NB = 5;

B = [0 0 0 1 0
    1 0 0 0 0
    0 1 0 0 0
    0 1 0 0 1
    1 1 1 1 0];

sB = sum(B); % somma per colonne, uguale a mettere 1

for i=1:size(B, 1)
    B(i,:) = B(i,:) ./ sB;
end

% Punto 4

toll = 1e-6;
nmax = 100;
x0A = 1/NA * ones(NA, 1);
[mu, x, iter] = eigpower(A, toll, nmax, x0A)

x0B = 1/NB * ones(NB, 1);
[mu, x, iter] = eigpower(B, toll, nmax, x0B)

% NB ' fa trasposta coniugata

%% 2

clear
close all
clc

A = toeplitz(1:4);

toll = 1e-6;
nmax = 100;
x0 = [1 2 3 4]';

[mu, x, iter] = invpower(A, toll, nmax, x0)

x0 = ones(4, 1);

[mu, x, iter] = invpower(A, toll, nmax, x0) % non convergiamo al minimo
% perché per sfiga abbiamo scelto vettore ortogonale a quello minimo.
% Forzando per più iterazione per questioni di errore e approssimazioni
% numeriche piano piano arrivo effettivamente a quello minore
% v. invpower_mod

% NB: lu fa sempre pivoting per righe però restituisce P solo se la
% richiedi, altrimenti restituisce una matrice L non triangolare inferiore
% perché aggiustata con il pivoting. Non funziona però dopo fwsub perché la
% matrice non è più triangolare inferiore

%% 6

clear
close all
clc

n = 4;

A = 2*diag(ones(1, n)) - diag(ones(1, n-1), 1) - diag(ones(1, n-1), -1);

% A = -A; Anche se fosse definita negativa non cambierebbe nulla, avrei
% semplicemente entrambi gli autovalori negativi ma rapporto sempre
% positivo (numero di condizionamento)

nmax = 200;
toll = 1e-8;

K = sdpcond(A, toll, nmax) % v. funzione Antonello
cond(A)

% Calcolo della complessità come il numero di operazioni operate dalla
% funzione sdpcond. o((2/3)n^3) + o(*k*n^2)