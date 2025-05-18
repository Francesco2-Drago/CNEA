%% 2

clear
clc

N = 0;

for S = 100:10000
    nthroot(S, 3)
    fix(nthroot(S, 3))
    if fix(nthroot(S, 3))==nthroot(S, 3)
        N = N + 1;
    end
end

%% 3

clear
close all
clc

% Uso thomas: 8*n-7

20*(8*60-7)

%% 4

clear
close all
clc

A = gallery('ris',10);
b = (1:10)';

[L, U, P] = lu(A);

y = fwsub(L, P*b);
x = bksub(U, y);

y(end)
spy(P)

%% 6

clear
close all
clc

% Raggio massimo = 7, basta sommare gli elementi della metrice per ogni
% colonna senza il valore sulla diagonale

A = [2 -5 4
    1 -6 1
    -1 2 -12];

gershcircles(A) % 1 autovalore in cerchio in (-12 0)'

%% 7

clear
close all
clc

A = [5 1 0
    -1 0 1
    0 -1 0];

toll = 1e-5;
nmax = 1e3;
x0 = [1 1 1]';

[lambda, x, iter] = eigpower(A, toll, nmax, x0)

%% 8

clear
close all
clc

syms x y

f1 = x.^2 - y.^2 - 1;
f2 = (x-1).^2 + (y-1).^2 - 2;

F = subs([f1; f2]);
F = matlabFunction(F);

[xVect, iter] = newtonSistemi(F, [2 2]', 5, 0)