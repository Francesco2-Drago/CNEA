%% Manfredi su scaglione iterate e molteplicità con Newton

clear
close all
clc

alpha = 7;

xVect = [6.675 6.800 6.900 6.980];

stimap(xVect); % Stima ordine di convergenza con stimap

errV = abs(alpha*ones(size(xVect)) - xVect);

fattAbb = errV(2:end) ./ errV(1:end-1).^1.43 % stima ordine di conv con errore

m = (xVect(end-1) - xVect(end-2)) / (2*xVect(end-1) - xVect(end) - xVect(end-2))

% !!! ordine deve per forza essere 1 perché se uso Newton normale con zero
% non semplice (come in questo caso) l'ordine è 1 !!!