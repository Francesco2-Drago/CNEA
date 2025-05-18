function [t_h, u_h, iter_pf] = eulero_indietro_punto_fisso(f, t, y0, h, nmax, toll)

% Funzione Eulero all'Indietro, metodo implicito con punto fisso
%
% tVect   vettore tempo da t0 a t_max con intervallo h, dove sono state
%           calcolate le derivate
% uVect   vettore derivate approssimate
% itPFVect  vettore iterazioni punto fisso ad ogni passo
%
% f     anonymous function come f(t, y)
% t     vettore con istanti di tempo iniziale e finale [t0, tmax]
% y0    condizione iniziale della derivata = y'(t0)
% h     intervallo temporale (step)
%
% nmax      Opzionale numero massimo di iterazioni per punto fisso
%           (default: 1e3)
% toll      Opzionale tolleranza per punto fisso (default: 1e-5)
%
% [tVect, uVect, itPFVect] = eulero_indietro_punto_fisso(f, [t0, tmax], y0, h, nmax, toll)

if nargin < 6
    toll = 1e-5;
    if nargin < 5
        nmax = 1e3;
    end
end

t0 = t(1);
t_max = t(2);
t_h = t0:h:t_max;

Nh = length(t_h);
u_h = zeros(size(t_h));

u_h(1) = y0;

iter_pf = zeros(size(t_h)); % iterate punto fisso

for i=1:Nh-1
    phi = @(y) u_h(i) + h * f(t_h(i + 1), y);
    [xVect, iter] = ptofis(u_h(i), phi, nmax, toll);
    u_h(i + 1) = xVect(end);
    iter_pf(i + 1) = iter;
end

end