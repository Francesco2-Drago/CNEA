function [t_h,u_h,vett_it_newton] = eulero_indietro_newton(f, df_du, t, valore_iniziale, delta_t, N_max, toll)

% [tVect, uVect, itNVect] = eulero_indietro_newton(f, df_du, [t0, tmax], y0, h, nmax, toll)
%
% Metodo di Eulero all'indietro per la soluzione di equazioni differenziali
% ordinarie con metodo di Newton per il calcolo della soluzione ad ogni
% step
%
% Parametri di ingresso:
%
% f                 funzione associata al problema di Cauchy, f(t, u)
% df_du             derivata di f rispetto a u (è funzione di t e u) (t, u)
% t0                estremo di integrazione iniziale
% tmax              estremo di integrazione finale
% y0                valore della soluzione al tempo iniziale t0 = 0
% h                 passo di integrazione
% nmax              Opzionale numero massimo di iterazioni per Newton
%                   (default: 1e3)
% toll              Opzionale tolleranza per punto fisso (default: 1e-5)
% 
%
% Parametri di uscita:
%
% tVect             vettore dei tempi in cui la soluzione viene calcolata
% uVect             vettore delle soluzioni calcolate in t_h
% itNVect           vettore delle iterazioni del metodo di Newton ad ogni
%                   passo
% 
% [tVect, uVect, itNVect] = eulero_indietro_newton(f, df_du, [t0, tmax], y0, h, nmax, toll)

t0 = t(1);
t_max = t(2);

t_h=t0:delta_t:t_max;

% inizializzo il vettore che conterra' la soluzione discreta

N_istanti=length(t_h);

u_h=zeros(1,N_istanti);

u_h(1)=valore_iniziale;

if nargin < 6
    toll = 1e-5;
    if nargin < 5
        N_max = 1e3;
    end
end

vett_it_newton=zeros(1,N_istanti);


for it=2:N_istanti
    
    % preparo le variabili per le sottoiterazioni
    
    u_old=u_h(it-1);
    t_newton=t_h(it);
        
    F=@(u) u_old + delta_t * f( t_newton, u) - u;
    dF = @(u) delta_t * df_du (t_newton, u) - 1;
    
    % sottoiterazioni
    
    [u_newton, it_newton] = newton (u_old, N_max, toll, F, dF);
    
    u_h(it)=u_newton(end);
    
    % tengo traccia dei valori di it_newton per valutare la convergenza 
    % delle iterazioni di punto fisso
    vett_it_newton(it)=it_newton;
    
end

