%% Serie 5
%% 1

clear
close all
clc

% Punto 1

a = -1;
b = 3;
f = @(y) -y.^4/2 + 4*y.^3 - 7*y.^2 - 4*y + 10;

x = 2;

y = linspace(a, b, 100);
figure
plot(y, f(y))
hold on
plot(x, f(x), 'rx')
grid on

% Punto 3

toll = 1e-6;
nmax = 100;

[xv, k, stimaErrv] = sezione_aurea(f, a, b, toll, nmax);

% Punto 4

errv = abs(x*ones(size(xv)) - xv);

figure
semilogy(stimaErrv)
hold on
semilogy(errv)
grid on
legend('Stima', 'Errore')

%% 2.1

clear
close all
clc

CL0 = 0;
CLalpha = 5;
CLdelta = 0.3;
CD0 = 0.02;
CDalpha = 0.5;
CDdelta = 0.05;

phi = @(y1, y2) - (CL0 + CLalpha*y1 + CLdelta*y2) ./ (CD0 + CDalpha*y1.^2 + CDdelta*y2.^2);

gradPhi = @(y1, y2) [500*(50*y1.^2 + 6*y1.*y2 - 5*y2.^2 - 2)./(50*y1.^2 + 5*y2.^2 + 2).^2; ...
    10*(-150*y1.^2 + 500*y1.*y2 + 15*y2.^2 - 6)./(50*y1.^2 + 5*y2.^2 + 2).^2];

xEx = [0.196494373584908, 0.117896623783779]';

a1 = 0;
b1 = 0.4;
a2 = -0.1;
b2 = 0.3;

figure
y1 = linspace(a1, b1, 100);
y2 = linspace(a2, b2, 100);
plot_phi(y1, y2, phi)

% Punto 3

x0 = [0.1 0.05]';
toll = 1e-5;
nmax = 100;
close all

[xvectGBT, itGBT] = gradiente_coniugato_opt(phi, gradPhi, 'G', x0, toll, nmax);

[xvectFRBT, itFRBT] = gradiente_coniugato_opt(phi, gradPhi, 'FR', x0, toll, nmax);

figure
plot_phi(y1, y2, phi, 'Gradiente')
plot_soluzioni(phi, xvectGBT, [a1 b1], [a2 b2], xEx)

figure
plot_phi(y1, y2, phi, 'Gradiente Coniugato')
plot_soluzioni(phi, xvectFRBT, [a1 b1], [a2 b2], xEx)
close all

%% 2.2

clear
close all
clc

% Punto 1

Phi = 