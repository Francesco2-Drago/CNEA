function A = pentadiag(a, b, c, d, e, n)

% Funzione che costruisce matrice pentadiagonale in ordine secondo valori e
% dimensione indicate.
% n: dimensione
% 
% A = pentadiag(a, b, c, d, e, n)
% 

A = a*diag(ones(n-2, 1), -2) + b*diag(ones(n-1, 1), -1) + c*diag(ones(n, 1))...
    + d*diag(ones(n-1, 1), 1) + e*diag(ones(n-2, 1), 2);

end