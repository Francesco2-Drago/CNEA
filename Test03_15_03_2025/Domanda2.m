clear
close all
clc

gamma = sym("g");
assume(gamma>0)
assumeAlso(gamma, "real")

A = [2*gamma sqrt(3)/2 * gamma
    sqrt(3)/2 * gamma gamma]

if isequal(A, A')
    disp('A è simmetrica')
    if solve(eig(A)>0)
        disp('A è definita positiva')
    else
        disp('A non è definita positiva')
    end
else
    disp('A non è simmetrica')
end

% Calcolo il numero di condizionamento spettrale come autovalore max su min

Al = eig(A)

% solve(max(eig(A)) / min(eig(A)))

Al(2) / Al(1)