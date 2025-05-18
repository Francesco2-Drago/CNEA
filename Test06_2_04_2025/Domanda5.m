clear
close all
clc

A = [15 1 -2
    0 3 1
    1 -1 9];

for i=1:5
    [Q,R] = qr(A);
    A = R*Q;
end

err = max(max(abs(tril(A, -1))))