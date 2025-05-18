function [tVect, uVect] = Runge_Kutta_4(f, t, y0, h)

% [tVect, uVect] = Runge_Kutta_4(f, [t0 tmax], y0, h)
%
% Risolve il problema di Cauchy 
%
% y' = f(t, y)
% y(0) = y0
%
% utilizzando il metodo di Runge-Kutta di ordine 4. 
%
% Input:
% f:    function che descrive il problema di Cauchy (dichiarata ad esempio
%       tramite inline o @) deve ricevere in ingresso due argomenti: f = f(t, y)
% t0:   istante iniziale dell'intervallo temporale di soluzione
% tmax: istante finale dell' intervallo temporale di soluzione 
% y0:   valore iniziale del problema di cauchy: y(t0) = y0
% h:    ampiezza del passo di discretizzazione temporale.
%
% Output:
% tVect: vettore contenente gli istanti in cui si calcola la soluzione discreta
% uVect: soluzione discreta calcolata nei nodi temporali tVect
%
% [tVect, uVect] = Runge_Kutta_4(f, [t0 tmax], y0, h)


% vettore degli istanti in cui risolvo la edo
t0 = t(1);
tmax = t(2);
tVect = t0:h:tmax;

% inizializzo il vettore che conterra' la soluzione discreta
Nh = length(tVect);
uVect = zeros(size(Nh));

uVect(1) = y0;

% ciclo iterativo per calcolare la soluzione
for i=1:Nh-1
    k1 = f (tVect(i), uVect(i));
    k2 = f (tVect(i) + 0.5 * h, uVect(i) + 0.5 * h * k1);
    k3 = f (tVect(i) + 0.5 * h, uVect(i) + 0.5 * h * k2);
    k4 = f (tVect(i) + h, uVect(i) + k3 * h);

    uVect(i + 1) = uVect(i) + 1/6 * (k1 + 2 * k2 + 2 * k3 + k4) * h;
end
