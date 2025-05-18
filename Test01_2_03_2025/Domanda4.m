% Si consideri la matrice di Teoplitz... Si riportino i valori della somma
% s1 sull'ultima riga di A e della sommma s2 degli elementi
% sull'antidiagonale di A

clear
clc

n = 100;

c = zeros(1,n);

for i=0:n-1
    c(i+1) = 100-abs(i);
end

A = zeros(n);

for i=1:n
    for j=1:n
        A(i,j) = c(1+abs(i-j));
    end
end

s1 = sum(A(n,:))
s2 = sum(diag(flip(A)))

s2 = 0;

for i=n:-1:1
    s2 = s2 + A(i,1+n-i);
end

disp(s2)

B = toeplitz(c);