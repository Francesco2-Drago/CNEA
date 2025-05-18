clear
close all
clc

f = @(x) pi*cosh(x - 1/2).^2;

a = 0;
b = 0.8;

VEx = pi*((sinh(1) + sinh(3/5))/4 + 2/5);

% Punto 1

fplot(f, [a b])
close

% Punto 2, 3, 4

% Funzioni pmedcomp, trapcomp, simpcomp

% Punto 5

N = 1:20;
V = zeros(3, length(N));

for n = N
    V(1, n) = pmedcomp(a, b, n, f);
    V(2, n) = trapcomp(a, b, n, f);
    V(3, n) = simpcomp(a, b, n, f);
end

plot(N, V, '*-', N, VEx*ones(size(N)))
legend('Pto Medio', 'Trapezi', 'Simpson', 'Esatto')
grid on
close

% Punto 6

E = abs(V - VEx * ones(size(V)));
H = (b-a)./N;

loglog(H, E, 'o', H, H.^2, H, H.^4)
grid on
close

% Punto 7

toll = 1e-5;

d2f = matlabFunction(diff(str2sym(func2str(f)), 2));
d4f = matlabFunction(diff(str2sym(func2str(f)), 4));

xV = linspace(a, b, 1e3);

NPm = ceil((b-a) * sqrt((b-a)/(24*toll) * max(d2f(xV))));
NTr = ceil((b-a) * sqrt((b-a)/(12*toll) * max(d2f(xV))));
NSp = ceil((b-a) * nthroot((b-a)/(16*180*toll) * max(d4f(xV)), 4));

V1(1, 1) = pmedcomp(a, b, NPm, f);
V1(2, 1) = trapcomp(a, b, NTr, f);
V1(3, 1) = simpcomp(a, b, NSp, f);

E1 = abs(V1 - VEx*ones(size(V1))); % tutti dell'ordine 1e-6 OK

% Punto 8

% Funzione gausscomp

% Punto 9

N = 1:20;
VGs = zeros(size(N));

for n = N
    VGs(n) = gausscomp(a, b, n, f);
end

plot(N, VGs, N, VEx*ones(size(N)), N, V(2:end, :))
legend('Gauss-Legedre', 'Esatto', 'Trapezi', 'Simpson')
grid on
close

EGs = abs(VGs - VEx * ones(size(VGs)));
H = (b-a)./N;

figure
loglog(H, EGs, 'o', H, E(2:end, :), '*', H, H.^2, H, H.^4)
legend('Gauss-Legendre', 'Trapezi', 'Simpson', 'H^2', 'H^4')
grid on
close