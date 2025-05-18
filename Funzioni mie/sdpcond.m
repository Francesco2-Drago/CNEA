function K = sdpcond(A, toll, nmax)
% Funzione che deve ricevere in inresso una matrice simmetrica definita
% positiva. Fai controllo...

x0 = rand(size(A, 1), 1);
[lMax, ~, ~] = eigpower(A, toll, nmax, x0);
[lMin, ~, ~] = invpower(A, toll, nmax, x0); % meglio usare quello modificato però...

K = lMax / lMin;

end