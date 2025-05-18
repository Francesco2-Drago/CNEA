clear
close all
clc

syms g real

A = [9 g 0
    g 1 0
    0 0 2]

abs(eig(A))

% for g=-5:0.1:5
%     abs(eig(double(subs(A))))
% end
% 
% for g=-1:1
%     gershcircles(double(subs(A)))
% end

for g=4:6
    gershcircles(double(subs(A)))
end

% g = 2;
% gershcircles(double(subs(A)))
% abs(eig(double(subs(A))))

% B