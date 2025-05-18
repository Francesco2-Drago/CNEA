function I = simpcomp(a, b, N, fun)

h = (b - a)/N;
xk = a : h : b;
xki = a + h/2 : h : b - h/2;

I = sum(h/6 * (fun(xk(1:end-1)) + 4*fun(xki(1:end)) + fun(xk(2:end))));

end