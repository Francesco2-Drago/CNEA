clear
close all
clc

% Punto 1

% Funzione eulero avanti

% Punto 2

y0 = 2;
t0 = 0;
tmax = 10;

f = @(t, y) y * ((pi*cos(pi*t)) ./ (2 + sin(pi*t)) - 1/2);
y = @(t) (2 + sin(pi*t)) .* exp(-t/2);

h1 = 0.05;
[th1Vect, uh1Vect] = eulero_avanti(f, [t0, tmax], y0, h1);

h2 = 0.01;
[th2Vect, uh2Vect] = eulero_avanti(f, [t0, tmax], y0, h2);

plot(th1Vect, uh1Vect, th2Vect, uh2Vect, th2Vect, y(th2Vect))
legend('h_1', 'h_2', 'Esatta')

% Punto 3

% Funzione eulero indietro

% Punto 4

[th1PFVect, uh1PFVect, ith1PFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h1);
[th2PFVect, uh2PFVect, ith2PFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h2);

figure
plot(th1PFVect, uh1PFVect, th2PFVect, uh2PFVect, th2Vect, y(th2Vect))
legend('h_1', 'h_2', 'Esatta')

% Punto 5

figure
plot(th1PFVect, ith1PFVect)
legend('No. Iterazioni')

% Punto 6

hVect = [0.04 0.02 0.01 0.005 0.0025];

Err = [];

for h = hVect
    [tVect, uVect] = eulero_avanti(f, [t0, tmax], y0, h);
    [tPFVect, uPFVect, itPFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h);

    Err = [Err, [max(abs(uVect - y(tVect))); max(abs(uPFVect - y(tPFVect)))]];
end

figure
loglog(hVect, Err, hVect, hVect, '--', hVect, hVect.^2, '--')
legend('EA', 'EI')