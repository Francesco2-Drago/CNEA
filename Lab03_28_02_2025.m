clear
clc

%% Sistemi lineari metodi diretti

%% Es 1.1.1 Le seguenti matrici sono LU fattorizzabili?

clear
clc

A=[50 1 3; 1 6 0; 3 0 1];
B=[50 1 10; 3 20 1; 10 4 70];
C=[7 8 9; 5 4 3; 1 2 6];

% matrice A, A è SDP?

if isequal(A,A')
    disp('A e'' simmetrica');
    na = size(A,1);

    % Calcolo determinante sottomatrici, criterio di sylvester

    for i = 1:na
        if det(A(1:i,1:i))>0
            if i==na
                disp('A e'' DP')
            end
        else
            error('A non e'' DP')
        end
    end
   
else
    disp('A non e'' simmetrica');

end

% matrice B, B è palesemente a dominanza diagonale, verifichiamo

db = diag(B); % db vettore colonna
nb = size(B,1);

r = zeros(1,nb);

for j = 1:nb
    r(j) = sum(abs(B([1:j-1, j+1:nb], j)));
end

if db-r>0 % trasposta non serve, entrambi definiti come vettori colonna
    disp('B e'' a dominanza diagonale per colonne')
else
    disp('B non e'' a dominanza diagonale per colonne')
end

% matrice C, criterio proposizione 1 (minori)

i = 1;
nc = size(C,1);
dc = 1;

while i<nc && dc~=0
    dc = det(C(1:i,1:i));
    i = i + 1;
end

if dc ~=0
    disp('LU applicabile')
else
    disp('LU non applicabile')
end

%% Es 1.1.2

[LA, UA, PA] = lu(A);
norm(LA*UA-A)

isequal(PA,eye(size(A)))

LA*UA
A

[LB, UB, PB] = lu(B);
[LC, UC, PC] = lu(C);

%% Es 1.1.4

x_ex = ones(na,1); % soluzione nota
b = A * x_ex; % termine noto

y = fwsub(LA, PA*b);

PA*b
LA*y

x = bksub(UA,y);

x
x_ex

%% Es 1.1.5 errore relativo e residuo normalizzato

err_rel = norm(x-x_ex) / norm(x_ex)
res_norm = norm(b - A*x) / norm(b)

cond(A)

%% Comando backlash
% Risolve sistema lineare scegliendo metodo più adatto

%% Es 1.2

clear
clc

A = [50 1 3; 1 6 0; 3 0 1];
n = size(A,1);

[LA, UA, PA] = lu(A);

I = eye(n);

Ainv = []; % definisco matrice vuota

for i = 1:n
    e = I(:,i);
    y = fwsub(LA,PA*e);
    x = bksub(UA, y);
    Ainv = [Ainv x]; % Ainv = [Ainv | x]
    % risolvere A*v_i = e_i
    % Assemblare A^-1
end

A*Ainv

norm(A*Ainv-eye(n))

%% Es 1.3

n = 20;
I0 = 2;
b = zeros(n,1);
b(1) = I0;

R = ones(n,1);
A = -diag(R) + diag(R(1:n-1),-1);
A(1,:) = 1; % = ones(1,n);

[LA, UA, PA] = lu(A);
y = fwsub(LA, PA*b);
x = bksub(UA, y);

% no pivoting, sono contento :)

x_ex = (I0/n) * ones(n,1);
err_rel = norm(x - x_ex) / norm(x_ex)
res_norm = norm(b - A*x) / norm(b)
cond(A)

% se sostituisco A(2,1) = 10^3 = 1e3 che succede?

A(2,1) = 1e3;

[LA, UA, PA] = lu(A);
y = fwsub(LA, PA*b);
x = bksub(UA, y);

res_norm = norm(b - A*x) / norm(b)
cond(A)

% occhio che la matrice di permutazioni a questo giro ha lavorato, è
% fondamentale