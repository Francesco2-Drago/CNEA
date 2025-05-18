function [xk, it] = conjgrad_it(A, b, x0, nmax, toll)

% inizializzazione

x = x0;
r = b - A * x0;
p = r;
xk = x0;

it = 0;
resNorm = norm(r) / norm(b);

while it<nmax && resNorm>toll
    it = it + 1;

    alpha = (p' * r) / (p' * A * p);
    x = x + alpha * p;
    r = r - alpha * A * p;
    beta = (p' * A * r) / (p' * A * p);
    p = r - beta * p;

    resNorm = norm(r) / norm(b);
    xk = [xk x];
end

end