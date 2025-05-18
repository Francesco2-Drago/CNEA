function [w_vect, it] = gauss_newton(x, y, r_fun, J_fun, w0, toll, maxit)

% [wVect, it] = gauss_newton(x, y, r, J, w0, toll, nmax)
% Algoritmo di Gauss-Newton per la risoluzione 
% di problemi di minimi quadrati non lineari.
%
% INPUT 
%   x : (double, vettore) Dati in input
%   y : (double, vettore) Dati in output
%   r : (handle function) Residuo
%   J : (handle function) Jacobiano del residuo
%   w0 : (double, vettore) Guess iniziale
%   toll : (double) Tolleranza
%   nmax : (int) Numero massimo di iterazioni
%
% OUTPUT 
%   wVect : (double, matrice) matrice che, su ogni colonna, contiene la soluzione a ogni iterazione
%   it : (int) numero di iterazioni
% 
% [wVect, it] = gauss_newton(x, y, r, J, w0, toll, nmax)

% Inizializzo variabili per ciclo iterativo
it  = 0;

% Inizializzo la matrice soluzione
w_vect = w0;

% Calcolo la direzione iniziale di discesa
J = J_fun(x,y,w0);
r = r_fun(x,y,w0);
d = - (J' * J) \ (J' * r);

err = norm(d);

% Ciclo while per calcolo w^{it+1} (it = 0, 1, ...)
while it < maxit && err > toll
    
    % Calcolo il nuovo valore di x
    w_new = w0 + d;
    
    % Aggiorno la direzione di discesa
    J = J_fun(x,y,w_new);
    r = r_fun(x,y,w_new);
    d = - (J' * J) \ (J' * r);

    % Aggiorno quantità per metodo iterativo
    it    = it+1;
    err   = norm(d);
    w0 = w_new;
    w_vect = [w_vect, w_new];

end

if err <= toll
     fprintf('Il metodo di Gauss-Newton converge in %d iterazioni\n', it);
else
     fprintf('Il metodo di Newton non converge in %d iterazioni\n', it)
end

end