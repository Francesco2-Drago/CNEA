function [x, k] = gs(A, b, x0, toll, nmax)

% Gauss - Seidel

n = length(b); % controllare dimensione di A
k = 0;

% P = D - E = tril(A)

P = tril(A);

x = x0;
r = b - A * x;
err = norm(r) / norm(b);

while err>toll && k<nmax
    k = k + 1;
    % Pz = r
    z = fwsub(P, r); % alternativamente, meglio, P \ r
    x = x + z;
    r = b - A * x;
    err = norm(r) / norm(b);
end

end