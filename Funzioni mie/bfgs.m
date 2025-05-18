function [x, iter] = bfgs(F, x0, B0, toll, nmax)

x = x0;
iter = 0;
B = B0;
err = toll + 1;

while iter<nmax && err>toll
    iter = iter + 1;
    xold = x(:, end);
    d = B\(-F(xold));
    xnew = xold + d;
    x = [x xnew];
    y = F(xnew) - F(xold);
    B = B + (y * y') / (y' * d) - ((B * d) * (B * d)') / (d' * (B * d));
    err = norm(d); % ovvero differenza tra iterate successive
end

end