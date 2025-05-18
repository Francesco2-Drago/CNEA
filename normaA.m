function risultato = normaA(x, A)

% Funzione calcola norma A di un vettore come
% ||x||A = sqrt( x' * A * x )
% x vettore di cui calcolare norma, A matrice
% 
% risultato = normaA(x, A)
% 

risultato = sqrt(x' * A * x);

end