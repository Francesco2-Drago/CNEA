%% Serie 7

% Teoria

% f apprtiente a C0 di [a, b]
% xk per k = 0, ..., n con x0 = a e xn = b
% H = (b - a) / n

% Punto medio come H per sommatoria da 1 a n di f(xki) con xki = (x(k-1) +
% x(k)) / 2 con k = 1, ..., n
% Trapezi con ... H/2 * [f(x0) + f(xn)] + H*sommatoria da 1 a n-1 di f(xk)
% Simpson con ... H/6 * sommatoria da 1 a n di [f(x(k-1) + 4*f(xki) + f(x(k)]

%% Es. 1

clear
close all
clc

f = @(x) cosh(x - 1/2);

a = 0;
b = 0.8;

V_ex = pi * ((sinh(1) + sinh(3/5)) / 4 + 2 / 5);
% f_int = @(x) pi*f(x).^2;
f_int = @(x) pi*cosh(x - 1/2).^2;

xV = linspace(a, b, 1e3);

figure
plot(xV, f(xV))
grid on
close

% Punto 5

N = 1:20;

I = zeros(3, length(N));

for n = N
    I(1, n) = pmedcomp(a, b, n, f_int);
    I(2, n) = trapcomp(a, b, n, f_int);
    I(3, n) = simpcomp(a, b, n, f_int);
end

figure
plot(N, I, 'o',  N, V_ex*ones(size(N)), 'w--')
grid on
legend('P.to Medio', 'Trapezi', 'Simpson', 'Esatta')
close

% Errori

Err = abs(I - V_ex*ones(size(I)));
H = (b - a)./N;

loglog(H, Err, 'o', H, H.^2, H, H.^4)
legend('Err. P.to Medio', 'Err. Trapezi', 'Err. Simpson', 'H^2', 'H^4', 'Location', 'best')
close

% Punto 7

toll = 1e-5;
d2fun = matlabFunction(diff(str2sym(func2str(f_int)), 2));
d4fun = matlabFunction(diff(str2sym(func2str(f_int)), 4));

Cmp = (b - a)/24;
Ctrap = (b - a)/12;
Csimp = (b - a)/2880;

Nmp = ceil((b - a) * sqrt(Cmp * max(abs(d2fun(xV))) / toll));
Ntrap = ceil((b - a) * sqrt(Ctrap * max(abs(d2fun(xV))) / toll));
Nsimp = ceil((b - a) * Csimp * max(abs(d4fun(xV))) / toll);

% Verifica errori

for n = N
    I(1, n) = pmedcomp(a, b, Nmp, f_int);
    I(2, n) = trapcomp(a, b, Ntrap, f_int);
    I(3, n) = simpcomp(a, b, Nsimp, f_int);
end

Err = abs(I - V_ex*ones(size(I)));
H = (b - a)./N;

loglog(H, Err, 'o', H, H.^2, H, H.^4)
legend('Err. P.to Medio', 'Err. Trapezi', 'Err. Simpson', 'H^2', 'H^4', 'Location', 'best')
close

% Punto 8

N = 1:20;
V_gl = [];

for n = N
    V_gl_n = gausscomp(a, b, n, f_int);
    V_gl = [V_gl, V_gl_n];
end

figure
plot(N, V_gl, 'o', N, V_ex*ones(size(N)))
legend('Soluzione Gauss-Legendre', 'Soluzione esatta')

Err_gl = abs(V_gl - V_ex);

figure
loglog(H, Err_gl, H, H.^2, H, H.^4)
grid on
legend('Err. G-L', 'H^2', 'H^4')