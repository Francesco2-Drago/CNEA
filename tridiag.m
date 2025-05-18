function A = tridiag(a, b, c, n)

% Funzione che costruisce matrice tridiagonale in ordine secondo valori e
% dimensione indicate.
% n: dimensione
% 
% A = tridiag(a, b, c, n)
% 

A = a*diag(ones(n-1, 1), -1) + b*diag(ones(n, 1)) + c*diag(ones(n-1, 1), 1);

end