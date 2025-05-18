%% 3.1

clear
close all
clc

% Punto 1

lambda1 = 5;
lambda2 = 10;

v1 = [4 3]' / 5;
v2 = [-3 4]' / 5;

b = [4 8]';

A1 = [v1 v2] * diag([lambda1 lambda2]) * [v1 v2]'; % OK
A2 = [v1 v2] * diag([1 lambda2]) * [v1 v2]';

Phi1 =  @(X,Y) 0.5* ( A1(1,1)*X.^2 + A1(2,2)*Y.^2 + 2*A1(1,2)*X.*Y ) - b(1)*X - b(2)*Y;
Phi2 =  @(X,Y) 0.5* ( A2(1,1)*X.^2 + A2(2,2)*Y.^2 + 2*A2(1,2)*X.*Y ) - b(1)*X - b(2)*Y;

% occhio a operazioni con mesh

x = linspace(-10, 10, 101);
y = linspace(-10, 10, 101);

[X, Y] = meshgrid(x, y); % creo mesh come spazio

surf(X, Y, Phi1(X, Y), 'lines', 'no') % cancello le linee, diventa superficie
hold on
contour (X, Y, Phi1(X, Y), 20) % crea linee di livello, no. 20

figure
surf(X, Y, Phi2(X, Y), 'lines', 'no')
hold on
contour (X, Y, Phi2(X, Y), 20) % crea linee di livello, no. 20

% Punto 2

alpha1 = 0.05;
alpha2 = 0.24;

toll = 1e-7;
nmax = 1e3;
x0 = [-9 -9]';

[x1, k1] = richardson_it(A2, b, eye(size(A2)), x0, toll, nmax, alpha1);

figure
contour(X, Y, Phi2(X, Y), 80)
hold on
plot(x1(1, :), x1(2, :), '-or', 'MarkerFaceColor', 'r')

[x2, k2] = richardson_it(A2, b, eye(size(A2)), x0, toll, nmax, alpha2);

figure
contour(X, Y, Phi2(X, Y), 80)
axis equal
hold on
plot(x2(1, 1:6), x2(2, 1:6), '-or', 'MarkerFaceColor', 'r') % esplode

% Punto 3

P = [1.0912 -0.8587; -0.8587 1.5921];

B = P \ A2;

PhiPrec =  @(X,Y) 0.5* ( B(1,1)*X.^2 + B(2,2)*Y.^2 + 2*B(1,2)*X.*Y ) - b(1)*X - b(2)*Y;

[xPrec, kPrec] = richardson_it(B, b, eye(size(B)), x0, toll, nmax); % metodo del gradiente precondizionato (alpha dinamico)

figure
contour(X, Y, PhiPrec(X, Y), 80)
hold on
plot(xPrec(1, :), xPrec(2, :), '-or', 'MarkerFaceColor', 'r')

% Punto 4

x = pcg(A2, b, toll, 0, [], [], x0)

figure
contour(X, Y, Phi2(X, Y), 80)
hold on
plot(x(1, :), x(2, :), '-or', 'MarkerFaceColor', 'r')

x = pcg(A2, b, toll, 1, [], [], x0)
plot(x(1, :), x(2, :), '-or', 'MarkerFaceColor', 'r')


x = pcg(A2, b, toll, 2, [], [], x0)
plot(x(1, :), x(2, :), '-or', 'MarkerFaceColor', 'r')

%% 3.2

clear
close all
clc

% Punto 1

nmax = 5e3;
toll = 1e-6;

for n=5:20
    A = 4*diag(ones(1, n)) + diag(ones(1, n-1), 1) + diag(ones(1, n-1), -1)...
        +2*diag(ones(1, n-2), 2) + 2*diag(ones(1, n-2), -2);

    b = ones(n, 1);

    x0 = zeros(n, 1);

    P = tril(A);

    [x, k] = richardson(A, b, P, x0, toll, nmax);

    % Punto 4

    [xPCG, ~, ~, kPCG] = pcg(A, b, toll, nmax, [], [], x0);

    % Punto 2, 5

    subplot(1, 2, 1)
    semilogy(n, k, 'o-', n, kPCG, '+-')
    hold on

    % Punto 3
    % A è SDP

    condA = max(abs(eig(A))) / min(abs(eig(A)));
    subplot(1, 2, 2)
    plot(n, condA, '*-')
    hold on
end
