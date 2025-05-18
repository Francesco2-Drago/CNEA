clear
close all
clc

n = 3;

A = [6 -2 -2
    -2 8 -4
    -2 -4 10]

b = ones(n, 1);

P = [6 0 0
    -1 8 0
    -1 -2 10]

B = eye(n) - P \ A;
g = P \ b;

x = b;

for k=1:2
    x = B * x + g;
end

x