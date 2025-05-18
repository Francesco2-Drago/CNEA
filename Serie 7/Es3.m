clear
close all
clc

p1 = @(x) x.^4 - 2*x + 1;
p2 = @(x) 3*x.^9 - 5*x.^4 + 1;
g = @(x) 10./(x + 2);
z = @(x) sqrt(x);

a = 0;
b = 1;

% Punto 1

N = 0:7;
I = zeros(4, length(N));

for n = N
    [xNodi, wNodi] = zplege(n, a, b);
    I(1, n + 1) = dot(wNodi, p1(xNodi));
    I(2, n + 1) = dot(wNodi, p2(xNodi));
    I(3, n + 1) = dot(wNodi, g(xNodi));
    I(4, n + 1) = dot(wNodi, z(xNodi));
end

% Punto 2

IEx = zeros(size(I));
IEx(1, :) = 1/5;
IEx(2, :) = 3/10;
IEx(3, :) = 10*log(3/2);
IEx(4, :) = 2/3;

Err = abs(I-IEx);

semilogy(N, Err)
legend('p1', 'p2', 'g', 'z')

% Punto 3

Ip1 = zeros(3, length(N));
Ip2 = zeros(3, length(N));
Ig = zeros(3, length(N));
Iz = zeros(3, length(N));

for n = N
    Ip1(1, n + 1) = pmedcomp(a, b, n, p1);
    Ip1(2, n + 1) = trapcomp(a, b, n, p1);
    Ip1(3, n + 1) = gausscomp(a, b, n, p1);

    Ip2(1, n + 1) = pmedcomp(a, b, n, p2);
    Ip2(2, n + 1) = trapcomp(a, b, n, p2);
    Ip2(3, n + 1) = gausscomp(a, b, n, p2);
    
    Ig(1, n + 1) = pmedcomp(a, b, n, g);
    Ig(2, n + 1) = trapcomp(a, b, n, g);
    Ig(3, n + 1) = gausscomp(a, b, n, g);
    
    Iz(1, n + 1) = pmedcomp(a, b, n, z);
    Iz(2, n + 1) = trapcomp(a, b, n, z);
    Iz(3, n + 1) = gausscomp(a, b, n, z);
end

Errp1 = abs(IEx(1, 1)*ones(size(Ip1)) - Ip1);
Errp2 = abs(IEx(2, 1)*ones(size(Ip2)) - Ip2);
Errg = abs(IEx(3, 1)*ones(size(Ig)) - Ig);
Errz = abs(IEx(4, 1)*ones(size(Iz)) - Iz);

figure
semilogy(N, Errp1, N, Errp2, N, Errg, N, Errz, N, Err)
legend('p1pme', 'p1trap', 'p1gauss', 'p2pme', 'p2trap', 'p2gauss', 'gpme', 'gtrap', 'ggauss', 'zpme', 'ztrap', 'zguass', 'p1GL', 'p2GL', 'gGL', 'zGL')