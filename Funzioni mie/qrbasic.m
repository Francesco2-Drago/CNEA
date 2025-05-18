function D = qrbasic(A, toll, nmax)

% funzione che restituisce la matrice diagonalizzata (vettore), quindi
% tutti gli autovalori della matrice di partenza con certa approssimazione,
% definita da toll, usando il metodo QR e facendo uso della fattorizzazione
% QR già implementata in Matlab. Il metodo converge se A ha autovalori
% distinti in modulo e positivi
% 
% D = qrbasic(A, toll, nmax)

iter = 0;

while iter<nmax && max(max(abs(tril(A, -1))))>toll
    iter = iter + 1;
    [Q, R] = qr(A);
    A = R * Q;
end

D = diag(A);

fprintf('Numero di iterazioni effettuate: %d\n', iter)

end