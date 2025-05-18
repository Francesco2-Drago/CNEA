%% Es. 2

clear
close all
clc

% g0(t) = 1
% g1(t) = t
% g2(t) = t^2

% t1 = -1
% t2 = alpha
% t3 = 1

% I2(g0) = w0 + w1 + w2 = integrale tra [-1; 1] di g0(t) * dt = 2
% I2(g1) = -w0 + alpha * w1 + w2 = integrale tra [-1; 1] di g1(t) * dt = 0
% I2(g2) = -w0 + alpha^2 * w1 + w2 = integrale tra [-1; 1] di g2(t) * dt = 2 / 3

% Sistema di equazioni:

% 1) w0 + w1 + w2 = 2
% 2) -w0 + alpha * w1 + w2 = 0
% 3) -w0 + alpha^2 * w1 + w2 = 2/3

% Risolvo come w0 = alpha * w1 + w2
% 1) alpha * w1 + w2 + w1 + w2 = 2
% 2) alpha * w1 + w2 + alpha * w1 + w2 = 2/3

% (1 + alpha) * w1 + 2 * w2 = 2
% (1 + alpha) * w1 + 2 * w2 = 2/3

% 1 - (1 + alpha) / 2 * w1 = 1/3 - alpha * (1 + alpha) / 2 * w1
% 1 - 1 / 3 = (1 + alpha) / 2 * w1 - alpha * (1 + alpha) / 2 * w1
% 2/3 = [(1 + alpha) * w1 - alpha * (1 + alpha) * w1] / 2
% (1 + alpha - alpha - alpha^2) * w1 = 4/3

% w0 = alpha * w1 + w2 = (alpha * 4/3 / (1 - alpha^2)) + (1 - 3 * alpha) / (3 * (1 - alpha)) = ... = (1 + 3 * alpha) / (3 * (1 - alpha))
% w1 = 4/3 / (1 - alpha^2)
% w2 = (1 - 3 * alpha) / (3 * (1 - alpha))

% I2(g2) = -w0 + alpha^3 * w1 + w2 = integrale tra [-1; 1] di g2(t) * dt = 0
% Risolvo in funzione di alpha:
% alpha = -1
% alpha = 0
% alpha = 1

% Itilde(f) = integrale tra [a, b] di f(x) * dx = integrale tra [-1, 1] di f(T(t)) * |T'(t)| * dt
% T(t) = 1/2 * [(a + b) + (b - a) * t]
% T'(t) = 1/2 * (b - a) (> 0)
% Itilde(f) = 1/2 * (b - a) * integrale tra [-1, 1] di g(t) * dt = (b - a) / 2 * I(g(t))
% Itilde2(f) = (b - a) / 2 * I2(g(t)) = (b - a) / 2 * [w0 * g(-1) + w1*g(0) + w2*g(1)] = (b - a) / 6 * [f(a) + 4 * f((a + b) / 2) + f(b)]

syms a
assume(a < 1)

A = [1, 1, 1;  -1, a, 1;  1, a^2, 1];
b = [2 0 2/3]';
x = A\b

a = 0;
subs(x, a)

%% Es. 3

clear
close all
clc

p1 = @(x) x.^4 - 2*x + 1;
p2 = @(x) 3*x.^9 - 5*x.^4 + 1;
g = @(x) 10 ./ (x + 2);
z = @(x) sqrt(x);

a = 0;
b = 1;

IExp1 = 1/5;
IExp2 = 3/10;
IExg = 10 * log(3/2);
IExz = 2/3;

N = 0:7;

Ep1 = [];
Ep2 = [];
Eg = [];
Ez = [];

for n = N
    [x, w] = zplege(n, a, b);

    Ip1 = sum(w .* p1(x));
    Ip2 = sum(w .* p2(x));
    Ig = sum(w .* g(x));
    Iz = sum(w .* z(x));

    Ep1 = [Ep1; abs(Ip1 - IExp1)];
    Ep2 = [Ep2; abs(Ip2 - IExp2)];
    Eg = [Eg; abs(Ig - IExg)];
    Ez = [Ez; abs(Iz - IExz)];
end

semilogy(N, Ep1, 'o-', 'DisplayName', 'p1', 'LineWidth', 2)
hold on
semilogy(N, Ep2, 'x-', 'DisplayName', 'p2', 'LineWidth', 2)
semilogy(N, Eg, '+-', 'DisplayName', 'g', 'LineWidth', 2)
semilogy(N, Ez, 's-', 'DisplayName', 'z', 'LineWidth', 2)
grid on
xlabel('N')
ylabel('Error')
legend('Location', 'best')
title('Error vs N')

Ipm = pmedcomp(a, b, 1, p1);
It = trapcomp(a, b, 1, p1);
Is = simpcomp(a, b, 1, p1);

Epm = abs(Ipm - IExp1);
Et = abs(It - IExp1);
Es = abs(Is - IExp1);

figure
semilogy(N, Epm * ones(size(N)), 'o-', 'DisplayName', 'Punto medio', 'LineWidth', 2)
hold on
semilogy(N, Et * ones(size(N)), 'x-', 'DisplayName', 'Trapezi', 'LineWidth', 2)
semilogy(N, Es * ones(size(N)), '+-', 'DisplayName', 'Simpson', 'LineWidth', 2)
semilogy(N, Ep1, 's-', 'DisplayName', 'Gauss-Legendre', 'LineWidth', 2)
grid on
legend('Location', 'best')
xlabel('N')
ylabel('Error')
title('Error vs N')

Ipm = pmedcomp(a, b, 1, g);
It = trapcomp(a, b, 1, g);
Is = simpcomp(a, b, 1, g);

Epm = abs(Ipm - IExg);
Et = abs(It - IExg);
Es = abs(Is - IExg);

figure
semilogy(N, Epm * ones(size(N)), 'o-', 'DisplayName', 'Punto medio', 'LineWidth', 2)
hold on
semilogy(N, Et * ones(size(N)), 'x-', 'DisplayName', 'Trapezi', 'LineWidth', 2)
semilogy(N, Es * ones(size(N)), '+-', 'DisplayName', 'Simpson', 'LineWidth', 2)
semilogy(N, Ep1, 's-', 'DisplayName', 'Gauss-Legendre', 'LineWidth', 2)
grid on
legend('Location', 'best')
xlabel('N')
ylabel('Error')
title('Error vs N')