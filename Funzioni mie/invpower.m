function [mu, x, iter] = invpower(A, toll, nmax, x0)

% funzione metodo delle potenze inverse con in uscita lambda min e x
% autovettore associato ad autovalore minore lambda, iter numeroe di
% iterazioni

iter = 0;

y = x0 / norm(x0);
mu0 = y' * A * y; % autovalore iniziale e poi autovalore ciclo precedente
err = toll + 1; % condizione iniziale per essere sicuri di entrare nel ciclo
[L, U, P, Q] = lu(sparse(A));

while err>toll && iter<nmax && abs(mu0)~=0
    iter = iter + 1;
    yStar = fwsub(L, P * y);
    xStar = bksub(U, yStar);
    x = Q * xStar;
    y = x / norm(x);
    mu = y' * A * y; % usando A convergo direttamente ad autovalore minimo (no suo reciproco)
    err = abs(mu - mu0) / abs(mu0); % altrimenti a denominatore abs di lambda ma non so dire se è zero
    mu0 = mu;
end

end