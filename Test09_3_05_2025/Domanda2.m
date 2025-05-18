clear
close all
clc

syms x H n real

f = exp(-x);
d2f = matlabFunction(diff(f, 2));

a = -1;
b = 1;

x = linspace(a, b, 1e3);

toll = 1e-2;

H = double(solve(max(d2f(x)) * (b-a)/24 * H^2 == toll, H>0))

ceil(double(solve((b-a)/n == H, n)))

H = sqrt(toll*24 / (max(d2f(x)) * (b-a)))

ceil(double(solve((b-a)/n == H, n)))