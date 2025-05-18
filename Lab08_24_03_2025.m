%% Es. 3

clear
close all
clc

B = [10 -1 1 0
    1 1 -1 3
    2 0 2 -1
    3 0 1 5];

% Punto 1

gershcircles(B);

% Punto 2

eig(B)

% Punto 3

[mu, x, iter] = invpower(B, 1e-6, 100, ones(4, 1))

% Punto 4

shift = 1i;
[mu, x, iter] = invpowershift(B, shift, 1e-6, 100, ones(4, 1))

shift = -1i;
[mu, x, iter] = invpowershift(B, shift, 1e-6, 100, ones(4, 1))

% Punto 5

shift = 10;
[mu, x, iter] = invpowershift(B, shift, 1e-6, 100, ones(4, 1))

[lambda, x, iter] = eigpower(B, 1e-6, 100, ones(4, 1))

% Meno iterazioni invpowershift però più flops quindi magari conviene
% sempre usare eigpower, è tutto da valutare

%% Es. 4

% Fattorizzazione QR di una matrice per approssimare tutto lo spettro,
% tutti gli autovalori. Matrice diventa triangolare superiore con stesso
% spettro di quella di partenza

clear
close all
clc

% Punto 1 funzione qrbasic

% Punto 2

syms a

A = [a 2 3 13
    5 11 10 8
    9 7 6 12
    4 14 15 1];

a = 30;

nmax = 1000;
toll = 1e-10;

D1 = qrbasic(double(subs(A)), toll, nmax)
eig(double(subs(A)))

a = -30;

D2 = qrbasic(double(subs(A)), toll, nmax)
eig(double(subs(A)))

v1 = abs(D1(2:end) ./ D1(1:end-1));
max(v1) % velocità di convergenza

v2 = abs(D2(2:end) ./ D2(1:end-1));
max(v2) % velocità di convergenza

%% Es. 5

clear
close all
clc

IM = imread("saturn.png"); % legge file
IM = rgb2gray(IM); % mette file in scala di grigi
imshow(IM);
A = double(IM); % converto a formato in virgola mobile

[U, S, V] = svd(A);

AA = U * S * V';
norm(AA - A)

k = 10;
Ak = U(:, 1:k) * S(1:k, 1:k) * (V(:, 1:k))'; % prendo solo le prime k colonne...
norm(Ak - A)

figure
subplot(1, 2, 1) % per fare un'unica figura con più plot affiancati
imshow(IM)
subplot(1, 2, 2)
imshow(uint8(Ak)) % per tornare a dimensione interi senza segno per poterla far vedere

% Confronto dimensioni e fattori di compressione

[n, m] = size(A);
uncompressedSize = n * m; % numero di caselle necessarie per salvare A non compressa

compressedSize = n * k + k + m * k; % numero di caselle necessarie per salvare A compressa

fprintf('Fattore di compressione: %g\n', uncompressedSize/compressedSize)

figure
semilogy(1:rank(A), diag(S))