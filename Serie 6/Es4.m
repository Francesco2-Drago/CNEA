clear
close all
clc

% Polyfit può anche fare interpolazione nel senso dei minimi quadrati se
% invece che passare il grado n per n+1 nodi passo un grado m<n
% Polyval si usa come prima

% interpl per interpolazione lineare (a tratti), NO regressione lineare

% cubicspline per spline cubica naturale
% comando spline per spline cubica "not-a-knot"

epsilon = [0.0005 0.0010 0.0013 0.0015 0.0020 0.0045 0.0060 0.0070 0.0085];
sigma = [0.1800 0.3000 0.5000 0.6000 0.7200 0.7500 0.8000 0.9000 1.0000];

x = linspace(0.0005, 0.0085, 1e3);

% Punto 1

% Lagrange
p = polyfit(epsilon, sigma, length(epsilon) - 1);
fLagrange = polyval(p, x);

% Lineare composita
fLineare = interp1(epsilon, sigma, x);
fLineare = interp1(epsilon, sigma, x);

% Spline cubica naturale
fSplineNat = cubicspline(epsilon, sigma, x);

% Spline cubica "not-a-knot"
fSplineNaK = spline(epsilon, sigma, x);

% Regressione lineare 1
p = polyfit(epsilon, sigma, 1);
fRegLineare = polyval(p, x);

% Regressione quadratica 2
p = polyfit(epsilon, sigma, 2);
fRegQuadratica = polyval(p, x);

% Regressione ordine 4
p = polyfit(epsilon, sigma, 4);
fReg4 = polyval(p, x);

% Plot

plot(epsilon, sigma, '.', x, fLagrange, x, fLineare, x, fSplineNat, x, fSplineNaK, x, fRegLineare, x, fRegQuadratica, x, fReg4, MarkerSize=15)
legend('Dati', 'Lagrange', 'Lin. Comp.', 'Spline nat', 'Spline NaK', 'Reg. lin.', 'Reg. quad.', 'Reg 4')

