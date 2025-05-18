%% 4.1 mat_hilbert.m

clear
clc

n = 5;

Hilbert = zeros(n);

for i=1:n
    for j=1:n
        Hilbert(i,j) = 1 / (i+j-1);
    end
end

disp(Hilbert)

hilb(n)

%% 4.2 treuno.m

clear
clc

n = 7

while n~=1
    if ~mod(n, 2) % se il numero è pari la divisione ha resto zero
        n = n / 2
    else
        n = 3 * n + 1
    end
end

%% 4.3

n = 1e4;

rate = 0.02;

milion = 1e6;

conto = n;

anni = 0;

while conto < milion
    conto = conto * (1 + rate) + n;
    anni = anni + 1;
end

disp(conto)
disp(anni)

%% 4.4

clear
clc

numeri = 0;

n = 1e9;

for i=1:n
    coppia = [rand rand];

    if coppia(1,1) ^ 2 + coppia(1,2) ^ 2 <=1
        numeri = numeri + 1;
    end
end

disp(pi)
disp(4 * (numeri / n))

%% 4.5

clear
clc

valore = 88;
n = 1;
k = 1;

while k<valore
    n = n + 1;
    k = k + n;
end

disp(n)

% oppure

n = 1;

while sum(1:n)<88
    n = n + 1;
end

disp(n)

%% 4.6

clear
clc

n = 10;
a = zeros(n, 1);

for i=1:n
    if i==2 || i==6
        a(i) = 1 / i;
    else
        a(i) = 1 / ((i - 2) * (i - 6));
    end
end

disp(a)

%% 4.7

clear
clc

n = 8;
v = zeros(1, n + 1);

for i=0:n
    v(i+1) = (2 * i + 1)^2;
end

disp(v)

%% 4.8

function [v] = vettore(n)

v = zeros(1, n + 1);

for i=0:n
    v(i+1) = (2 * i + 1)^2;
end

end

%% 4.9

clear
clc

n = input('Numero di cui calcolare la radice: ');
toll = 1e-6;
r = [];

r(1) = n;
i = 2;

while r(i-1) - sqrt(n) > toll
    r(i) = (r(i - 1) + n / r(i - 1)) / 2;
    i = i + 1;
end

fprintf('La radice calcolata è: %d\nLa radice vera è: %d', r(i - 1), sqrt(n))

plot(1 : i - 1, r)
title('Grafico della radice')
legend('radice','Location','northeastoutside')

%% 4.10

clear
clc

n = 10;
a = [];
b = [];
p = [];
q = [];

a(1) = sqrt(2);
b(1) = 2;
p(1) = 2 * a(1);
q(1) = 2 * b(1);

for i=2:n
    a(i) = sqrt(2) * sqrt(1 - sqrt(1 - a(i - 1)^2 / 4));
    p(i) = 2^i * a(i);
    b(i) = a(i) / sqrt(1 - a(i - 1)^2 / 4);
    q(i) = 2^i * b(i);
end

plot(1:n, p, 'o-', 1:n, q, '*-')
grid on
yline(pi)

%% 4.11

clear
clc

% Grafico cerchio

r = 1;
xOrigin = 0;
yOrigin = 0;
theta = 0:0.01:2*pi;

x = r * cos(theta) + xOrigin;
y = r * sin(theta) + yOrigin;

figure(1)
plot(x, y)
title('Cerchio')
axis equal
legend('x^2+y^2=1', Location='northeastoutside')
grid on

% Grafico ellisse

a = 2;
b = 3;

x = a * cos(theta) + xOrigin;
y = b * sin(theta) + yOrigin;

figure(2)
plot(x, y)
title('Ellisse')
axis equal
legend('$\frac{x^2}{4}+\frac{y^2}{9}=1$', 'interpreter', 'latex', ...
    Location='northeastoutside')
grid on

% Quadrato di lato 5 centrato nell'origine

figure(3)
plot([-2.5 2.5 2.5 -2.5 -2.5], [-2.5 -2.5 2.5 2.5 -2.5])
title('Grafico quadrato')
grid on
axis equal

%% 4.12

clear
clc

f = @(x) - sqrt(x.^2 - x).*(x<0) + (-x.^2 + 2.*x).*exp(-x).*(x>=0); % funzione definita a tratti

x = -10:10;

plot(x, f(x))
legend('f', 'Location','northeastoutside')
grid on
axis equal

%% 4.13

clear
clc

K = 6; % 236767

n = 10;

A = zeros(n);

for i=1:n
    for j=1:n
        A(i, j) = 2 * i * j + K + 1;
    end
end

disp(A)
table(A)

%% 4.14

clear
clc

x = 3;
y = -2;

atan(y/x) - sin(x * sqrt(abs(y)))^2

%% 4.15

clear
clc

K = 6; % 236767
r = 2.5 + mod(K, 2);
n = 100;

a = zeros(n, 1);
a(1) = 0.5;

for i=2:n
    a(i) = r * a(i-1) * (1 - a(i - 1));
    if abs(a(i) - a(i - 1))<1e-3
        disp(a(i))
        disp(i)
    end
end

plot(1:n, a)
grid on

%% 4.16

clear
clc

K = 7; % 236767
n = mod(K, 4) + 3;
a = input('primo numero: ');
b = input('secondo numero: ');
risultato = 0;

for i=0:n
    risultato = risultato + factorial(n) / (factorial(i) * factorial(n - i)) * a^i * b^(n-i);
end

disp(risultato)

%% 4.17

clear
clc

v = [10 2 40 5 8];

for i=1:length(v)
    [massimo, index] = max(v(i:end));
    scambio = v(i);
    v(i) = v(index + i - 1); % alternativamente v(i) = max (valore)
    v(index + i - 1) = scambio;
end

disp(v)

%% 4.18

clear
clc

k = 0; % esempio
sommaPari = 0;
sommaDispari = 0;

for i=5*k+k:1000
    if mod(i, 2)==0
        sommaPari = sommaPari + i;
    else
        sommaDispari = sommaDispari + i;
    end
end

disp(sommaPari)
disp(sommaDispari)

%% 4.19

clear
clc

f = @(x) sin(x) .* (-pi<=x & x<=0) + (x.^2+x) / 6 .* (0<=x & x<=pi);

plot(-pi:0.01:0, f(-pi:0.01:0))
hold on
plot(0:0.01:pi, f(0:0.01:pi))
legend('-pi<=x<=0', '0<=x<=pi', 'Location','northeastoutside')

%% 4.20

clear
clc

n = input('Inserire un numero: ');

r = sqrt(n) - floor(sqrt(n));

if r==0
    disp('Il numero è un quadrato perfetto')
else
    disp('Il numero non è un quadrato perfetto')
end

%% 4.21

clear
clc

K = 7; % 236767

x = 0;

for i=0:1000
    if mod(i, K+2)~=0
        x = x + i;
    end
end

disp(x)

%% 4.22

clear
clc

a = 10;
b = 6;
c = 8;

sides = [a b c];
sides = sort(sides);

hypotenuse = max(sides);
cat1 = sides(1);
cat2 = sides(2);

if cat1^2 + cat2^2 == hypotenuse^2
    disp('Il triangolo è rettangolo')
else
    disp('Il triangolo non è rettangolo')
end

%% 4.23

clear
clc

n = 10; % dimensione matrice
T = zeros(n);
T(1:2:n, 1:2:n) = 1;
T(2:2:n, 2:2:n) = 1;

%% 4.24

clear
clc

K = 10; % per esempio
a = 1:10+K;
n = length(a);
aMedia = 0;

for i=1:n
    aMedia = aMedia + 1/a(i);
end

aMedia = n/aMedia;

disp(aMedia);

%% 4.25

clear
clc

K = 10; % per esempio
a = 1:10+K;
n = numel(a); % analogo a length
aMedia = a(1);

for i=2:n
    aMedia = aMedia * a(i);
end

aMedia = aMedia^(1/n);

%% 4.26

clear
clc

n = 10;
a = zeros(1, n);

a(1) = 1;

for i=2:n
    a(i) = (a(i-1)^2 + 2) / (2 * a(i-1));
end

plot(1:n, a)
grid on
yline(sqrt(2))
title('Convergenza a radice di due')
legend('\sqrt2 approx', '\sqrt2', 'interpreter', 'latex', 'Location','northeastoutside')
axis equal

%% 4.27

clear
clc

n = 10;

T = zeros(n);

for i=1:n
    T(i, i:n) = 1:n-i+1;
end

%% 4.28

clear
clc

x = -5:0.01:5;

f = @(x) (x.^2+3) ./ (x-1);

plot(x, f(x))
grid on
title('f(x)')
legend('f(x)', Location='northeastoutside')