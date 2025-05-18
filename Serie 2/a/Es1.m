%% 1.1

clear
clc

A = [50 1 3; 1 6 0; 3 0 1];
B = [50 1 10; 3 20 1; 10 4 70];
C = [7 8 9; 5 4 3; 1 2 6];

% Verifico che A sia SDP

na = size(A, 1);

if isequal(A, A')
    for i=1:na
        if det(A(1:i, 1:i))>0
            if i==na
                disp('A e'' SDP')
            end
        else
            error('A non è DP')
        end
    end
end

% Verifico che B sia a dominanza diagonale per righe

diagB = diag(B);
if  diagB > sum(B, 2) - diagB % sum 1 somma colonne, 2 somma righe
    disp('B è a dominanza diagonale per righe')
end

% Verifico che C sia LU fattorizzabile con definizione

nc = size(C, 1);

for i=1:nc
    if det(C(1:i, 1:i))~=0
        if i==nc
            disp('C è LU fattorizzabile')
        end
    else
        error('C non è LU fattorizzabile')
    end
end

% Punto 2

[LA, UA, PA] = lu(A);
[LB, UB, PB] = lu(B);
[LC, UC, PC] = lu(C);

% Punto 3 funzioni fwsub e bksub

% Punto 4

xEx = [1 1 1]';
b = A * xEx;

y = fwsub(LA, PA * b);
x = bksub(UA, y);

% Punto 5

errRel = norm(xEx - x) / norm(xEx);
resNorm = norm(b - A * x) / norm(b);

%% 1.2

clear
clc

A = [50 1 3; 1 6 0; 3 0 1];

[LA, UA, PA] = lu(A);

na = size(A, 1);
I = eye(na);
AInv = [];

for i=1:na
    e = I(:, i); % prendo solo una colonna alla volta di I
    y = fwsub(LA, PA * e);
    x = bksub(UA, y);
    AInv = [AInv x];
end

inv(A)
AInv;

%% 1.3

clear
clc

% Punto 1

n = 20;
I0 = 2;

A = - eye(n) + diag(ones(n-1, 1), -1) + [1; zeros(n-1, 1)] * ones(1, n);
A(1, 1) = 1;

b = zeros(n, 1);
b(1) = I0;

% Punto 2

[LA, UA, PA] = lu(A);

% Punto 3

y = fwsub(LA, PA * b);
x = bksub(UA, y);

% Punto 4

xEx = I0 / n * ones(n, 1);

errRel = norm(xEx - x) / norm(xEx);
resNorm = norm(b - A * x) / norm(b);
cond(A)

% Punto 5

A(2, 1) = 1e3;

[LA, UA, PA] = lu(A);

y = fwsub(LA, PA * b);
x = bksub(UA, y);

xEx = I0 / n * ones(n, 1);

errRel = norm(xEx - x) / norm(xEx);
resNorm = norm(b - A * x) / norm(b);
cond(A)