function [w_vect, it] = gauss_newton(x, y, r_fun, J_fun, w0, toll, nmax)


% Funzione metodo di Gauss-Newton
% [w_vect, it] = gauss_newton(x, y, r_fun, J_fun, w0, toll, nmax)

it = 0;
w_vect = w0;
J = J_fun(x, y, w0);
r = r_fun(x, y, w0);
d = (J' * J) \ (- J' * r);
err = toll + 1;

while it<nmax && err>toll
    it = it + 1;
    w_new = w_vect(:, end) + d;
    J = J_fun(x, y, w_new);
    r = r_fun(x, y, w_new);
    d = (J' * J) \ (- J' * r);
    err = norm(d);
    w_vect = [w_vect w_new];
end

if err<toll
    fprintf('Il metodo di Gauss-Newton converge in %d iterationi\n', it)
else
    fprintf('Il medoto di Gauss-Newton non converge in %d iterationi\n', it)
end

end