function [tVect, uVect] = eulero_avanti_sistemi(f, t, y0, Nh)

% Metodo di Eulero Avanti per sitemi
% [tVect, uVect] = eulero_avanti_sistemi(f, [t0 tmax], y0, Nh)
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
% Nh        Numero di step di tempo, numero suddivisioni intervallo [t0, tmax]
% 
% [tVect, uVect] = eulero_avanti_sistemi(f, [t0 tmax], y0, Nh)

t0 = t(1);
tmax = t(2);

if ischar(f) || isstring(f)
    f = str2func(f);
end

h = (tmax - t0) / Nh;

tVect = linspace(t0, tmax, Nh + 1);

uVect = zeros(size(y0, 1), length(t));

uVect(:, 1) = y0;

for i=1:Nh
    uVect(:, i + 1) = uVect(:, i) + h*f(tVect(i), uVect(:, i));
end

end