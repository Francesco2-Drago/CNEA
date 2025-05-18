function [tVect, uVect, itPFVect] = Crank_Nicolson(f, t, y0, h, nmax, toll)

% Metodo di Crank-Nicolson con metodo del punto fisso
% [tVect, uVect, itPFVect] = Crank_Nicolson(f, [t0 tmax], y0, h, nmax, toll)
% 
% Output:
% tVect     Vettore degli istanti di tempo dove è stata valutata la
%           derivata
% uVect     Vettore con i valori della derivata per ogni istante di tempo
% itPFVect  Vettore con iterazioni del punto fisso
% 
% Input:
% f         Function handle della funzione come f(t, y)
% t         Vettore istante di tempo come [t0 tmax]
% y0        Condizioine iniziale y(t0)
% h         Step di tempo
% nmax      Opzionale numero massimo di iterazioni per punto fisso
%           (default: 1e3)
% toll      Opzionale tolleranza per punto fisso (default: 1e-5)
% 
% [tVect, uVect, itPFVect] = Crank_Nicolson(f, [t0 tmax], y0, h, nmax, toll)

t0 = t(1);
tmax = t(2);

tVect = t0:h:tmax;

N = length(tVect);

if nargin < 6
    toll = 1e-5;
    if nargin < 5
        nmax = 1e3;
    end
end

itPFVect = zeros(size(tVect));

uVect = zeros(size(tVect));

uVect(1) = y0;

for i=1:N-1
    phi = @(y) uVect(i) + h/2 * (f(tVect(i), uVect(i)) + f(tVect(i + 1), y));
    [xVect, iter] = ptofis(uVect(i), phi, nmax, toll);
    uVect(i + 1) = xVect(end);
    itPFVect(i + 1) = iter(end);
end

end