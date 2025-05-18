%% Serie 4
%% 1

clear
close all
clc

f = @(x) x.^3 - (2 + exp(1)) * x.^2 + (2 * exp(1) + 1) * x + (1 - exp(1)) - cosh(x - 1);

a = 0.5;
b = 6.5;

% Punto 1

x = linspace(a, b, 100);
figure
plot(x, f(x),'*-')
hold on
plot(x, 0 * x, 'w--')
grid on

% Punto 2

if f(0.5) * f(1.5) <= 0 % uguale per caso uguale nella funzione
    disp('Bisezione applicabile per alpha1')
end

if f(3) * f(4) <= 0
    disp('Bisezione applicabile per alpha2')
end

if f(6) * f(6.5) <= 0
    disp('Bisezione applicabile per alpha3')
end

% Punto 3 funzione bisez

% Punto 4

toll = 1e-12;

[xVect, iter] = bisez(3, 4, toll, f);
fprintf('%16.14f\n', xVect(end))
fprintf('%16.14f\n', iter)

[xVect, iter] = bisez(6, 6.5, toll, f);

% v. funzione bisezione caricata soluzioni
% Da funzione simbolica a funzione anonima con matlabFunction

%% 2

clear
close all
clc

f = @(x) x.^3 - (2 + exp(1)) * x.^2 + (2 * exp(1) + 1) * x + (1 - exp(1)) - cosh(x - 1);

df = @(x) 3 * x.^2 - 2 * (2 + exp(1)) * x + (2 * exp(1) + 1) - sinh(x - 1);

a = 0.5;
b = 6.5;

x = linspace(a, b, 100);

figure
plot(x, f(x), x, df(x), x, 0*x, 'w--')
grid on
legend('f(x)', 'df(x)', 'y=0')

alpha1Ex = 1;
df(alpha1Ex)

d2f = @(x) 6 * x - 2 * (2 + exp(1)) - cosh(x - 1);
d2f(alpha1Ex)

% Radice con molteplicità 2, potrei usare metodo di Newton modificato
% premoltiplicando il rapporto con derivata per m ovvero la molteplicità
% per recuperare la convergenza quadratica alla soluzione

% Punto 3

mol = 2;
x0 = 0.5;
nmax = 1000;
toll = 1e-6;

[xVect1, iter1] = newton(x0, nmax, toll, f, df)

[xVect1M, iter1M] = newton(x0, nmax, toll, f, df, mol)

x0 = 3;
[xVect, iter] = newton(x0, nmax, toll, f, df)

x0 = 6;
[xVect, iter] = newton(x0, nmax, toll, f, df)

solEx1 = alpha1Ex * ones(size(xVect1)); % vettore con ogni elemento uguale alla soluzione esatta
err1 = abs(xVect1 - solEx1); % vettore che per orgni iterazione riporta errore tra soluzione esatta e calcolata

solEx1M = alpha1Ex * ones(size(xVect1M));
err1M = abs(xVect1M - solEx1M);

figure
semilogy(0:iter1, err1, 0:iter1M, err1M)
grid on
legend('Newton', 'Newton modificato')

% v. funzione newton loro