function [x] = bksub(U, y)

n = size(U, 1);

x = zeros(n, 1);

x(n) = y(n) / U(n, n);

for i = n-1:-1:1
    x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
end

end