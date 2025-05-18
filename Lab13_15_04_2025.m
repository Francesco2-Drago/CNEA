%% Es. 1

clear
close all
clc

% Punto 1

f = @(x) x.*sin(x);
a = -2;
b = 6;

x = linspace(a, b, 1e3);
fx = f(x);

plot(x, fx)
close

% Punto 2, 3

nv = [2 4 6];

PPDis = [];
errDis = [];
errMax = [];

for n=nv
    h = (b-a)/n;
    xNodi = a:h:b; % n+1 nodi equispaziati
    fNodi = f(xNodi);
    p = polyfit(xNodi, fNodi, n);
    PDis = polyval(p, x); % vettore x come vettore dei punti
    % nell'intervallo, NO nodi. In uscita PDis come vettore riga!!!
    PPDis = [PPDis; PDis];
    errDis = [errDis; abs(PDis - fx)]; % matrice, ogni riga come vettore
    % errori punto per punto
    errMax = [errMax; max(abs(PDis - fx))]; % vettore colonna errori
    % massimi
end

figure
plot(x, fx, x, PPDis) % dando matrice a plot ho plot di ogni riga matrice
% per vettore ascisse che assegno (riga matrice come ordinata)
grid on
legend('f(x)', 'P2', 'P4', 'P6')

figure
plot(x, errDis)
title('Errori')
legend('P2', 'P4', 'P6')
close all

%% Es. 2

clear
close all
clc

f = @(x) sin(1./(1+x.^2));
a = -2*pi;
b = 2*pi;

x = linspace(a, b, 1e3);
fx = f(x);

nv = [2 4 8 10];

PPDis = [];
errDis = [];
errMax = [];

for n=nv
    h = (b-a)/n;
    xNodi = a:h:b;
    fNodi = f(xNodi);
    p = polyfit(xNodi, fNodi, n);
    PDis = polyval(p, x);
    PPDis = [PPDis; PDis];
    errDis = [errDis; abs(PDis - fx)];
    errMax = [errMax; max(abs(PDis - fx))];
end

figure
plot(x, fx, x, PPDis)
grid on
legend('f(x)', 'P2', 'P4', 'P8', 'P10')

figure
plot(x, errDis)
title('Errori')
legend('P2', 'P4', 'P8', 'P10')

figure
plot(nv, errMax);

close all

% Punto 3

PPDis = [];
errDis = [];
errMax = [];

t = @(x, n) -cos(pi.*x./n);

for n=nv
    k = 0:n;
    xNodi =(b-a)/2 * t(k, n) + (a+b)/2;
    fNodi = f(xNodi);
    p = polyfit(xNodi, fNodi, n);
    PDis = polyval(p, x);
    PPDis = [PPDis; PDis];
    errDis = [errDis; abs(PDis - fx)];
    errMax = [errMax; max(abs(PDis - fx))];
end

figure
plot(x, fx, x, PPDis)
grid on
legend('f(x)', 'P2', 'P4', 'P8', 'P10')

figure
plot(x, errDis)
title('Errori')
legend('P2', 'P4', 'P8', 'P10')

figure
plot(nv, errMax);

%% Es. 4

clear
close all
clc

% Polyfit può anche fare interpolazione nel senso dei minimi quadrati se
% invece che passare il grado n per n+1 nodi passo un grado m<n
% Polyval si usa come prima

% interpl per interpolazione lineare (a tratti), NO regressione lineare

% cubicspline per spline cubica naturale
% comando spline per spline cubica "not-a-knot"

xNodi = [0.1800 0.3000 0.5000 0.6000 0.7200 0.7500 0.8000 0.9000 1.0000];
fNodi = [0.0005 0.0010 0.0013 0.0015 0.0020 0.0045 0.0060 0.0070 0.0085];

a = min(xNodi);
b = max(xNodi);

x = linspace(a, b, 1e3);

plot(xNodi, fNodi, '.', MarkerSize=17)
hold on
% plot(x, polyval(polyfit(xNodi, fNodi, length(xNodi) - 1), x)) %
% interpolante ordine giusto
plot(x, polyval(polyfit(xNodi, fNodi, 1), x)) % interpolante ordine 1 Min quadrati
plot(x, polyval(polyfit(xNodi, fNodi, 2), x)) % interpolante ordine 2 Min quadrati
plot(x, polyval(polyfit(xNodi, fNodi, 4), x)) % interpolante ordine 4 Min quadrati
plot(x, interp1(xNodi, fNodi, x)) % interpolante ordine 1, come plot e basta
plot(x, cubicspline(xNodi, fNodi, x))
plot(x, spline(xNodi, fNodi, x))
legend('f(x)', 'grado1', 'grado2', 'grado4', 'interp1', 'cubicspline', 'spline')

% v. funzione fatta a laboratorio