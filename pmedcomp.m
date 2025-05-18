function I = pmedcomp(a, b, N, fun)

h = (b - a)/N;
xk = a + h/2 : h : b - h/2;
I = h * sum(fun(xk));

% In alternativa
% I = 0;
% for x=xk
%     I = I + h * fun(x);
% end

end