function [tVect, uVect] = Runge_Kutta(f, t, y0, h, c, b, A)

    % [tVect, uVect] = Runge_Kutta(f, [t0 tmax], y0, h, c, b, A)
    %
    % Metodo di Runge-Kutta generale (ipotesi A solo triangolare inferiore (no diagonale) => metodo esplicito)
    %
    % c | A
    % -----
    %   | b^t
    %
    % Input:
    % f:    Function handle del problema di Cauchy f(t, y)
    % t:    Intervallo temporale di integrazione [t0 tmax]
    % y0:   Condizione iniziale y(t0) = y0
    % h:    Passo di integrazione
    % c:    Vettore dei coefficienti c
    % b:    Vettore dei pesi b
    % A:    Matrice dei coefficienti A
    %
    % Output:
    % tVect: Vettore degli istanti in cui si calcola la soluzione discreta
    % uVect: Vettore delle soluzioni discrete y(t_n)
    %
    % [tVect, uVect] = Runge_Kutta(f, [t0 tmax], y0, h, c, b, A)

    if ~isequal(triu(A), zeros(size(A))) % Controllo che A sia triangolare inferiore
        error('La matrice A deve essere triangolare inferiore, metodo esplicito');
    end

    t0 = t(1);
    tmax = t(2);

    tVect = t0:h:tmax; % Vettore degli istanti in cui si calcola la soluzione discreta

    uVect = zeros(size(tVect)); % Vettore delle soluzioni discrete y(t_n)

    uVect(1) = y0; % Condizione iniziale y(t0) = y0

    K = zeros(1, size(A, 2)); % Inizializzazione del vettore dei K_j con dimensione corretta

    for i=1:length(tVect)-1
        for j=1:size(A, 2)
            K(j) = f(tVect(i) + c(j)*h, uVect(i) + h*(dot(A(j, :), K))); % Calcolo dei K_j
        end

        uVect(i+1) = uVect(i) + h*(dot(b, K)); % Calcolo della soluzione discreta y(t_n+1)
    end