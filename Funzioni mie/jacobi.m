function [x, k] = jacobi(A, b, x0, toll, nmax)

% Jacobi

n = length(b); % controllare dimensione di A
k = 0;

% P = D = diag(A)

DInv = diag(1./diag(A));
x = x0;
r = b-A*x;
err = norm(r) / norm(b);

while err>toll && k<nmax
    k = k + 1;
    % Pz = r
    z = DInv * r;
    x = x + z;
    r = b - A * x;
    err = norm(r) / norm(b);
end

end