clear
close all
clc

x = linspace(0, 1, 150);
rng(1)
y = @(x) 3*x.^2 + 0.3*sin(100*pi*x) + 0.3*randn(1, 150);

p = polyfit(x, y(x), 2);
polyval(p, 1.5)