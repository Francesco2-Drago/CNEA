function I = trapcomp(a,b,N,fun)

h = (b - a)/N;
xk = a : h : b;

I = sum(h/2 * (fun(xk(1:end-1)) + fun(xk(2:end))));

end