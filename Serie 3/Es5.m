%% Es. 5

clear
close all
clc

% Punto 1

IM = imread("pears.png"); % carico l'immagine
IM = rgb2gray(IM); % trasformo l'immagine in bianco e nero
imshow(IM) % visualizzo l'immagine
A = double(IM); % converto l'immagine in formato a virgola mobile

% Punto 2

[U,S,V] = svd(A);

k = 5;

Ak = U(:, 1:k) * S(1:k, 1:k) * V(:, 1:k)';

% Punto 3

figure
subplot(1, 2, 1)
imshow(IM)

subplot(1, 2, 2)
imshow(uint8(Ak))

% Punto 4

[m, n] = size(A);
rappComp = (m*n) / (k*m + k + k*n)

% 

figure
semilogy(1:rank(A), diag(S))
% Plot su scala logaritmica dei valori singolari di A. Come asse x il rank
% di A ovvero il minimo tra il numero di righe/colonne di A ovvero il
% numero di elementi contenuti in S (rifletti su come è fatta la matrice)