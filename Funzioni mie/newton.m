function [xVect, iter] = newton(x0, nmax, toll, fun, dfun, mol)

% Funzione metodo di Newton e metodo di Newton modificato con molteplicità
% per convergenza quadratica anche per radici non semplici. In uscsita il
% vettore delle radici e il numero di iterazioni totali. In ingresso il
% valore x0 di inizio, il numero  di iterazioni massime (nel caso in cui il
% metodo non converga), la tolleranza (controllo fatto come modulo della
% differenza tra due iterate successive che deve essere minore della
% tolleranza), funzione come anonymous e sua derivata come anonymous. Per
% ultimo il valore mol della molteplicità della radice.
% Il vettore delle iterate è lungo iter + 1 perché riporta come primo
% elemento il valore di x0 da cui parte il metodo.
% [xVect, iter] = newton(x0, nmax, toll, fun, dfun, mol)

if nargin==5
    mol = 1;
end

err = toll + 1;
iter = 0;
xVect = x0;

while iter<nmax && err>toll
    iter = iter + 1;
    if dfun(xVect(iter))~=0
        xVect = [xVect, xVect(iter) - mol * fun(xVect(iter))./dfun(xVect(iter))];
        err = abs(xVect(iter) - xVect(iter + 1));
    else
        error('Derivata uguale a zero')
    end
end

end