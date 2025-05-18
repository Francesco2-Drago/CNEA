clear
close all
clc

t0 = 0;
tmax = 7;

y0 = 2;

h = 0.1;

f = @(t, y) - y * exp(t * y);

uVect(1) = y0;

tVect = t0:h:tmax;

for i = 1:length(tVect)-1
    uStar = uVect(i) + h/2 * f(tVect(i), uVect(i));
    q = f(tVect(i) + h/2, uStar);
    uVect(i + 1) = uVect(i) + h * q;
end

uVect(4)