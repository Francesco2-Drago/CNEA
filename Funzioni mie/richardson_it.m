function [x, k] = richardson_it(A, b, P, x0, toll, nmax, alpha)

% Richardson statico se passi alpha altrimenti dinamico

n = length(b); % controllare dimensione di A
k = 0;

x = [x0];
r = b - A * x;
err = norm(r) / norm(b);

while err>toll && k<nmax
    k = k + 1;
    % Pz = r
    z = P \ r;
    if nargin==6 % numero di argomenti di input
        alpha = (z' * r) / (z' * A * z); % alpha dinamico
    end
    x = [x, (x(k+1) + alpha * z)];
    r = b - A * x(:, k + 1);
    err = norm(r) / norm(b);
end

end