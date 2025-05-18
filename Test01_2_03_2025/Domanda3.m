% Si determini l'errore relativo percentuale commesso valutando le due
% funzioni in x=1.01. Si riporti il valore di |fl1(x)-fl2(x)|/|fl1(x)|

clear
clc

f1 = @(x) (x-1)^7;
f2 = @(x) x^7 - 7*x^6 + 21*x^5 - 35*x^4 + 35*x^3 - 21*x^2 + 7*x - 1;

x = 1.01;

err_rel_perc = abs(f1(x)-f2(x)) / abs(f1(x)) * 100