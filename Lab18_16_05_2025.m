%% Es. 2.4

clear
close all
clc

% Crank-Nicolson e Heun

% Punto 1

% Funzione Crank-Nicolson

% Punto 2

y0 = 2;
lambda = -42;
t0 = 0;
tmax = 1;

tDis = 0:0.01:tmax;
yEx = @(t) y0 * exp(lambda*t);
f = @(t, y) lambda*y;

h = 0.02;
[tVect, uVect, itPFVect] = Crank_Nicolson(f, [t0 tmax], y0, h);

plot(tDis, yEx(tDis), tVect, uVect)
legend('Esatta', 'CN')

figure
plot(tVect, itPFVect, '*')

% Punto 3

[tVect, uVect] = Heun(f, [t0 tmax], y0, h);

figure
plot(tDis, yEx(tDis), tVect, uVect)
legend('Esatta', 'Heun')

% Punto 4

H = [0.02 0.01 0.005 0.0025 0.00125];

Err = zeros(4, length(H));

i = 1;

for h=H
    [tPFVect, uPFVect, itPFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h);
    Err(1, i) = max(abs(uPFVect - yEx(tPFVect)));

    [tVect, uVect, itPFVect] = Crank_Nicolson(f, [t0 tmax], y0, h);
    Err(2, i) = max(abs(uVect - yEx(tVect)));
    
    [tVect, uVect] = Heun(f, [t0 tmax], y0, h);
    Err(3, i) = max(abs(uVect - yEx(tVect)));
    
    [tVect, uVect] = Runge_Kutta_4(f, tmax, y0, h);
    Err(4, i) = max(abs(uVect - yEx(tVect)));

    i = i + 1;
end

loglog(H, Err, H, H, '--', H, H.^2, '--', H, H.^4, '--')
legend('EI', 'CN', 'Heun', 'RK', 'H', 'H^2', 'H^4')

%% Es. 3.1

clear
close all
clc

% Ode secondo ordine -> sistema ode primo ordine

% Punto 1

% Funzione problema mms

% Punto 2

[tVect, uVect] = ode45('mms', [0 100], [2 0]);
% U come vettore prima colonna con ordine 4, seconda con ordine 5

plot(tVect, uVect)

% Punto 3

[tVect, uVect] = ode45('mms_forz', [0 100], [2 0]);
figure
plot(tVect, uVect)

%% Es. 4.1

clear
close all
clc

% x'' + 2*x' + 10*x^2 = z , t (0, 10)
% x'(0) = 2
% x(0) = 0

% w(t) = x'(t)
% y(t) = (x(t), w(t))'

% w' = 2*w + 10*x^2 = z
% x' = w
% w(0) = 2
% x(0) = 0

% w' = -2*w + 10*x^2 + z
% x' = w

% y1' = y2
% y2' = -2*y2 + 10*y1^2 + z

% dy_dt = f(y) + g(t)
% y(0) = y0

% f(y) = [y2; -2*y2 + 10*y1^2]
% g(t) = [0; z(t)]

t0 = 0;
tmax = 10;

g = @(t) [0; exp(-t/2) .* (2*cos(t) - 7/2*sin(t)) + 40*exp(-t) .* sin(t).^2];
f = @(y) [y(2); -2*y(2) - 10*y(1).^2];

y0 = [0; 2];

% Punto 2

h = 1e-2;
Nh = round((tmax - t0) / h);
f = @(t, y) f(y) + g(t);

[tVect, uVect] = eulero_avanti_sistemi(f, [t0 tmax], y0, Nh);

plot(tVect, uVect(1, :), tVect, uVect(2, :))
legend('y', 'dy/dt')

figure
plot(tVect, abs(uVect(1, :)), tVect, 0.1*ones(size(tVect)))

tm = [];

for k=2:length(tVect)
    if abs(uVect(1, k-1)) >= 0.1 && abs(uVect(1, k)) < 0.1
        tm = [tm, tVect(k)];
    end
end

tm(end); % 5.6800

% Punto 3

xEx = @(t) 2*exp(-t/2).*sin(t);
hv = 1e-3 ./ 2.^(0:3);

Err = [];

for h=hv
    Nh = round((tmax - t0) / h);
    [tVect, uVect] = eulero_avanti_sistemi(f, [t0 tmax], y0, Nh);
    Err = [Err, max(abs(uVect(1, :) - xEx(tVect)))];
end

Err; % 0.0046 0.0023 0.0011 0.0006

%  E <= C*h^p
% Eh1 / Eh2 = (h1 / h2)^p
% p = log(Eh1 / Eh2) / log(h1 / h2)

p = log(Err(2:end) ./ Err(1:end - 1)) ./ log(hv(2:end) ./ hv(1:end - 1));
% 1.0141 1.0069 1.0034

% xEx(t) = 2*exp(-t/2)*sin(t) -> 0 per t -> +inf
% lim t -> +inf g(t) = 0
% F(t, y(t)) ~ f(y) t -> +inf ~df/dy * y
% Jf(y) ) [0 1; -20*y1 -2]
% J(t) = [0 1; -20*xEx(t) -2]
% (lambda, h) appartiene ad A
% Se Re{lambda_i} < 0 => EA assolutamente stambile
% 0 < h < -2 * Re{lambda_max} / abs(lambda_max)^2
% hmaxf = min(hmax(t))

J = @(t) [0, 1; -20*xEx(t), -2];
t = linspace(t0, tmax, 1e3);

ht = [];

for tk=t
    lambdak = eig(J(tk))';
    hmax = -2*real(lambdak) / abs(lambdak).^2;
    ht = [ht, hmax];
end

hmax = min(ht)