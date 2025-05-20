function [tVect, uVect, vVect] = Leap_Frog(f, t, y0, v0, h)

    % [tVect, uVect, vVect] = Leap_Frog(f, [t0 tmax], y0, v0, h)
    %
    % Metodo di Leap Frog per EDO del secondo ordine
    % Risoluzione del problema di zero non lineare con fzero (bisezione + ...)
    %
    % Problema di Cauchy:
    % y'' = f(t, y, y')
    % y(t0) = y0
    % y'(t0) = v0
    %
    % Input:
    % f:    Function handle del problema di Cauchy f(t, y, y')
    % t:    Intervallo temporale di integrazione [t0 tmax]
    % y0:   Condizione iniziale y(t0) = y0
    % v0:   Condizione iniziale y'(t0) = v0
    % h:    Passo di integrazione
    %
    % Output:
    % tVect: Vettore degli istanti in cui si calcola la soluzione discreta
    % uVect: Vettore delle soluzioni discrete y(t_n)
    % vVect: Vettore delle soluzioni discrete y'(t_n)
    %
    % [tVect, uVect, vVect] = Leap_Frog(f, [t0 tmax], y0, v0, h)

    t0 = t(1);
    tmax = t(2);

    tVect = t0:h:tmax; % Vettore degli istanti in cui si calcola la soluzione discreta

    uVect = zeros(size(tVect)); % Vettore delle soluzioni discrete y(t_n)
    vVect = zeros(size(tVect)); % Vettore delle soluzioni discrete y'(t_n)

    uVect(1) = y0; % Condizione iniziale y(t0) = y0
    vVect(1) = v0; % Condizione iniziale y'(t0) = v0

    for i=1:length(tVect)-1
        uVect(i+1) = uVect(i) + h*vVect(i) + (h^2/2)*f(tVect(i), uVect(i), vVect(i)); % Calcolo della soluzione discreta y(t_n+1)

        phi = @(v) vVect(i) + (h/2)*( f(tVect(i), uVect(i), vVect(i)) + f(tVect(i+1), uVect(i+1), v) ) - v; % -v perché fzero cerca lo zero NO punto fisso
        vVect(i+1) = fzero(phi, vVect(i)); % Risoluzione del problema di zero non lineare con fzero (bisezione + ...)
    end