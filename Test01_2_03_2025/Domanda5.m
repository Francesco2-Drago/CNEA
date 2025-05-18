% Si consideri il metodo babilonese per approssimare radice di S. ... si
% usi la successione ...

clear
clc

S = 10^5;
n = 10;

x = zeros(1, n);
x(1) = S;

for i=1:n
    x(i+1) = 1/2 * (x(i) + S/x(i));
end

disp(x(n+1)) % decima iterazione, occhio a come chiami indici: lo zero non
% c'è, inizia da 1!!