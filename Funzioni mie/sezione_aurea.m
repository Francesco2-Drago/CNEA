function [xv, k, errv] = sezione_aurea(f, a, b, toll, nmax)

% Funzione serzione aurea, metodo di discesa con in uscita il vettore delle
% iterare, il numero di iterazioni e l'errore come vettore come dimensione
% intervallo.
% In ingresso f: la funzione, a e b come gli estremi dell'intervallo, toll
% come la tolleranza da controllare sull'errore, nmax come il numero
% massimo di iterazioni
% [xv, k, errv] = sezione_aurea(f, a, b, toll, nmax)

k = 0;
phi = (1 + sqrt(5))/2;
x = (a + b)/2;
xv = x;
err = abs(b - a)/2;
errv = err;

while err>toll && k<nmax
    k = k + 1;
    c = a + (b - a)/(phi + 1);
    d = a + (b - a)/(phi);

    if f(c)>f(d)
        a = c;
    else
        b = d;
    end

    x = (a + b)/2;
    xv = [xv x];
    err = (b - a)/2;
    errv = [errv err];
end

end