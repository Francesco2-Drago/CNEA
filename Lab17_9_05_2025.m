%% Es. 1

clear
close all
clc

f = @(x) exp(-x.^2).*sin(2*x + 1);
df = matlabFunction(diff(str2sym(func2str(f))));

xb = 0;
hv = 0.4./(2.^(0:5));

% Punto 1

errDFA = [];
errDFI = [];
errDFC = [];

dfEx = df(xb);

for h = hv
    dfa = (f(xb + h) - f(xb)) / h;
    dfi = (f(xb) - f(xb - h)) / h;
    dfc = (f(xb + h) - f(xb - h)) / (2*h);

    errDFA = [errDFA, abs(dfa - dfEx)];
    errDFI = [errDFI, abs(dfi - dfEx)];
    errDFC = [errDFC, abs(dfc - dfEx)];
end

figure
loglog(hv, errDFA, hv, errDFI, hv, errDFC, hv, hv, '-.', hv, hv.^2, '-.')
legend('dfa', 'dfi', 'dfc', 'h', 'h^2')

% Punto 2

d2f = matlabFunction(diff(str2sym(func2str(f)), 2));

d2fEx = d2f(xb);

errDFC2 = [];

for h = hv
    dfc2 = (df(xb + h) - df(xb - h)) / (2*h);

    errDFC2 = [errDFC2, abs(dfc2 - d2fEx)];
end

figure
loglog(hv, errDFC2, hv, hv, '-.', hv, hv.^2, '-.')
legend('dfc2', 'h', 'h^2')

%% Es. 2.1

clear
close all
clc

y0 = 0.1;
lambda = 2.4;
tMax = 3;
t0 = 0;

f = @(t, y) lambda*y;
yEx = @(t) y0 * exp(lambda*(t - t0));

h1 = 0.05;
h2 = 0.01;

[th1Vect, uh1Vect] = eulero_avanti(f, [t0, tMax], y0, h1);
[th2Vect, uh2Vect] = eulero_avanti(f, [t0, tMax], y0, h2);

figure
plot(th1Vect, uh1Vect, th2Vect, uh2Vect, th2Vect, yEx(th2Vect))
legend('h1', 'h2', 'Exact')

% Punto 4

[th1Vect, uh1Vect, itPFh1Vect] = eulero_indietro_punto_fisso(f, [t0, tMax], y0, h1);
[th2Vect, uh2Vect, itPFh2Vect] = eulero_indietro_punto_fisso(f, [t0, tMax], y0, h2);

figure
plot(th1Vect, uh1Vect, th2Vect, uh2Vect, th2Vect, yEx(th2Vect))
legend('h1', 'h2', 'Exact')

% Punto 5

figure
plot(th1Vect, itPFh1Vect, th2Vect, itPFh2Vect)
grid on

% Punto 6

hv = 0.04 ./ (2.^(0:4));

errEA = [];
errEI = [];

for h = hv
    [tVect, uVect] = eulero_avanti(f, [t0, tMax], y0, h);
    errEA = [errEA, max(abs(uVect - yEx(tVect)))];

    [tVect, uVect, itPFVect] = eulero_indietro_punto_fisso(f, [t0, tMax], y0, h);
    errEI = [errEI, max(abs(uVect - yEx(tVect)))];
end

figure
loglog(hv, errEA, hv, errEI, hv, hv, hv, hv.^2)

%% Es. 2.3

clear
close all
clc

lambda = -42;
y0 = 2;
t0 = 0;
tmax = 1;

y = @(t) y0 * exp(lambda*t);

% Punto 1/2

t = linspace(t0, tmax, 1e3);
plot(t, y(t))

h = 0.01; % 0.05 EA non converge

f = @(t, y) lambda*y;

[tVect, uVect] = eulero_avanti(f, [t0, tmax], y0, h);
figure
plot(tVect, uVect, tVect, y(tVect))

df_dy = @(t, y) lambda; % derivata parziale di f rispetto a y

[t_h, u_h, vett_it_newton] = eulero_indietro_newton (f, df_dy, tmax, y0, h);

figure
plot(tVect, uVect, tVect, y(tVect), t_h, u_h)
legend('EA', 'Esatta', 'EINewton')

% Punto 3

[tVect, uVect, itPFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h);

figure
plot(tVect, uVect)