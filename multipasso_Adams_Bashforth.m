function [tVect, uVect] = multipasso_Adams_Bashforth(f, t, y0, u1, u2, h)

    % [tVect, uVect] = multipasso_Adams_Bashforth(f, [t0 tmax], y0, u1, u2, h)
    %
    % Metodo multipasso di Adams-Bashforth a 3 passi
    %
    % Input:
    % f:    Function handle del problema di Cauchy f(t, y)
    % t:    Intervallo temporale di integrazione [t0 tmax]
    % y0:   Condizione iniziale y(t0) = y0
    % u1:   Valore di y(t1) = u1 o u1 approssimato
    % u2:   Valore di y(t2) = u2 o u2 approssimato
    % h:    Passo di integrazione
    %
    % Output:
    % tVect: Vettore degli istanti in cui si calcola la soluzione discreta
    % uVect: Vettore delle soluzioni discrete y(t_n)
    %
    % [tVect, uVect] = multipasso_Adams_Bashforth(f, [t0 tmax], y0, u1, u2, h)

    t0 = t(1);
    tmax = t(2);

    tVect = t0:h:tmax; % Vettore degli istanti in cui si calcola la soluzione discreta

    uVect = zeros(size(tVect)); % Vettore delle soluzioni discrete y(t_n)

    uVect(1) = y0; % Condizione iniziale y(t0) = y0
    uVect(2) = u1; % Condizione iniziale y(t1) = u1
    uVect(3) = u2; % Condizione iniziale y(t2) = u2

    for i=3:length(tVect)-1
        uVect(i+1) = uVect(i) + h*(23/12*f(tVect(i), uVect(i)) - 4/3*f(tVect(i-1), uVect(i-1)) + 5/12*f(tVect(i-2), uVect(i-2))); % Calcolo della soluzione discreta y(t_n+1)
    end