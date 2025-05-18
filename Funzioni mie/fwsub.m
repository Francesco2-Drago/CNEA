function [x] = fwsub(L, f) % f termini noti
% commenti

% verifica degli input
n = length(f);
if size(L, 1) ~= n || size(L, 2) ~= n
    error('Dimensioni incompatibili')
end

if ~isequal(L, tril(L))
    error('L non e'' triangolare inf')
end

if prod(diag(L)) == 0 % prodotto degli elementi del vettore diagonale
    error('Matrice singolare')
end

% inizializzazione
x = zeros(n, 1);
x(1) = f(1)/L(1,1);

% algoritmo
for i = 2:n
    s=0;
    for j=1:i-1
        s = s + L(i,j) * x(j);
    end
    x(i) = (f(i)-s) / L(i,i);

    x(i) = (f(i) - L(i,1:i-1) * x(1:i-1)) / L(i,i);
end

end