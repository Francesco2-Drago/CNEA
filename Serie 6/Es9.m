clear
close all
clc

% Punto 1

% funzioni nn_forward e act_fn

% Punto 2

a = 0;
b = 1;
N = 100;

h = 20;
activation = 'Sigmoid';

x = linspace(a, b, N);

f = @(x) x.*sin(4*pi*x) + x.^2;