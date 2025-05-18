function I = gausscomp(a, b, N, fun)

% Gauss-Legendre composita a due punti " = n + 1 => n = 1
% Due nodi di quadratura per ogni sotto intervallo, N intervalli

h = (b-a)/N;
xm = a+h/2:h:b-h/2;

% Nodi di quadratura
y0 = xm + h/2 * (-1/sqrt(3));
y1 = xm + h/2 * (1/sqrt(3));

% Pesi
w0 = h/2;
w1 = h/2;

I = w0 * sum(fun(y0)) + w1*sum(fun(y1));

end