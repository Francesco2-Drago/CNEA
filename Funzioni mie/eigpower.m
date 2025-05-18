function [lambda, x, iter] = eigpower(A, toll, nmax, x0)

% funzione metodo delle potenze con in uscita lambda max, x, iter
% [lambda, x, iter] = eigpower(A, toll, nmax, x0)

iter = 0;

y = x0 / norm(x0);
lambda0 = y' * A * y; % autovalore iniziale e poi autovalore ciclo precedente
err = toll + 1; % condizione iniziale per essere sicuri di entrare nel ciclo

while err>toll && iter<nmax && abs(lambda0)~=0
    iter = iter + 1;
    x = A * y;
    y = x / norm(x);
    lambda = y' * A * y; % NB ' fa trasposta coniugata
    err = abs(lambda - lambda0) / abs(lambda0); % altrimenti a denominatore abs(lambda) ma non so dire se è zero
    lambda0 = lambda;
end

end