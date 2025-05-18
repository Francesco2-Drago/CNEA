clear
close all
clc

lambda = -42;
y0 = 2;
t0 = 0;

f = @(t, y) lambda*y;
df_du = @(t, y) lambda;
y = @(t) y0 * exp(lambda * t);

% Punto 1

fplot(y)

% Punto 2

tmax = 1;

h = 0.05;

[tEAVect, uEAVect] = eulero_avanti(f, [t0, tmax], y0, h);
[tEINVect, uEINVect, itEINVect] = eulero_indietro_newton(f, df_du, [t0, tmax], y0, h);

figure
plot(tEAVect, uEAVect, tEINVect, uEINVect, tEAVect, y(tEAVect))
legend('EA', 'EIN', 'Esatta')

% EA non converge

% Punto 3

h = 0.01;

[tEAVect, uEAVect] = eulero_avanti(f, [t0, tmax], y0, h);
[tEINVect, uEINVect, itEINVect] = eulero_indietro_newton(f, df_du, [t0, tmax], y0, h);

figure
plot(tEAVect, uEAVect, tEINVect, uEINVect, tEAVect, y(tEAVect))
legend('EA', 'EIN', 'Esatta')

% Punto 4

hVect = [0.05 0.03 0.01];

for h = hVect
    [tEAVect, uEAVect] = eulero_avanti(f, [t0, tmax], y0, h);
    [tEIPFVect, uEIPFVect, itEIPFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h);

    figure
    plot(tEAVect, uEAVect, tEIPFVect, uEIPFVect, tEAVect, y(tEAVect))
    legend('EA', 'EIPF', 'Esatta')
end

fprintf('lambda * h = %d\n', lambda * hVect)