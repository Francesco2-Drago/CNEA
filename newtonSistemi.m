function [xVect, iter] = newtonSistemi(F, x0, nmax, toll)

% Metodo di Newton per sistemi
% F         Sistema di equazioni di cui si vuole trovare lo zero (tutte
%           funzioni uguali a zero). Funzione inline / anonymous di due
%           variabili: @(x1, x2) !!!
% x0        Valore iniziale
% nmax      Numero massimo di iterazioni
% toll      Tolleranza su errore
% 
% Errore definito come la norma di delta: ||delta||
% 
% La funzione calcola la Jacobiana di F e ad ogni iterazione risolve
% l'equazione:
% JF(x_{k}) * delta_{k} = - F(x_{k})
% e calcola:
% x_{k+1} = x_{k} + delta_{k}
% err = norm(delta_{k})
% 
% In uscita:
% xVect     Vettore delle iterate inclusa la guess iniziale x0
% iter      Numero di iterazioni effettuate
% 
% Presente stampa finale di valore iterata finale e numero di iterazioni
% 
% [xVect, iter] = newtonSistemi(F, x0, nmax, toll)

JF = matlabFunction(jacobian(str2sym(func2str(F)))); % per calcolare Jacobiana

iter = 0;
xVect = x0;
err = toll + 1;

while iter<nmax && err>toll
    iter = iter + 1;
    xOld = xVect(:, end);
    x1 = xOld(1);
    x2 = xOld(2);

    if det(JF(x1, x2))==0
        error('Determinante uguale a zero\n')
    end

    delta = - JF(x1, x2) \ F(x1, x2);
    xVect = [xVect, xVect(:, end) + delta];
    err = norm(delta);
end

fprintf('Numero di iterazioni: %d\n', iter)
fprintf('Radice calcolata: %13.12f\n', xVect(:, end))

end