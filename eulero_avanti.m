function [t_h, u_h] = eulero_avanti(f, t, y0, h)

% Funzione Eulero in Avanti, metodo diretto/esplicito
%
% tVect vettore tempo da t0 a t_max con intervallo h, dove sono state
%       calcolate le derivate
% uVect vettore derivate approssimate
%
% f     anonymous function come f(t, y)
% t     vettore con istanti di tempo iniziale e finale
% y0    condizione iniziale della derivata = y'(t0)
% h     intervallo temporale (step)
%
% [tVect, uVect] = eulero_avanti(f, [t0, tmax], y0, h)

t0 = t(1);
t_max = t(2);
t_h = t0:h:t_max;

Nh = length(t_h);
u_h = zeros(size(t_h));

u_h(1) = y0;

for i=1:Nh-1
    u_h(i + 1) = u_h(i) + h*f(t_h(i), u_h(i));
end

end