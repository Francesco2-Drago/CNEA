function [tVect, uVect] = Heun(f, t, y0, h)

% Metodo di Heun
% [tVect, uVect] = Heun(f, [t0 tmax], y0, h)
% 
% Output:
% tVect     Vettore degli istanti di tempo dove è stata valutata la
%           derivata
% uVect     Vettore con i valori della derivata per ogni istante di tempo
% 
% Input:
% f         Function handle della funzione come f(t, y)
% t         Vettore istante di tempo come [t0 tmax]
% y0        Condizioine iniziale y(t0)
% h         Step di tempo
% 
% [tVect, uVect] = Heun(f, [t0 tmax], y0, h)

t0 = t(1);
tmax = t(2);

tVect = t0:h:tmax;

N = length(tVect);

uVect = zeros(size(tVect));

uVect(1) = y0;

for i=1:N-1
    [~, uStar] = eulero_avanti(f, [tVect(i), tVect(i+1)], uVect(i), h);
    uVect(i + 1) = uVect(i) + h/2 * (f(tVect(i), uVect(i)) + f(tVect(i + 1), uStar(end)));
end

end