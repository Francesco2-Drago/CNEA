function [xNodi] = nodi_CGL(n, a, b)

    % [xNodi] = nodi_CGL(n, a, b)
    %
    % Funzione che calcola i nodi di Chebyshev-Gauss-Lobatto (simbolici e non) per un polinomio di ordine n => n + 1 nodi
    %
    % Input:
    % n: ordine del polinomio, n + 1 nodi calcolati
    % a: estremo sinistro dell'intervallo
    % b: estremo destro dell'intervallo
    %
    % Output:
    % xNodi: vettore contenente i nodi di Chebyshev-Gauss-Lobatto
    %
    % [xNodi] = nodi_CGL(n, a, b)

    if n == 0
        xNodi = (a + b) / 2;
        return
    end

    % Calcolo dei nodi di Chebyshev-Gauss-Lobatto
    xNodi = - cos(pi * (0:n) / n)';
    xNodi = (b - a) / 2 * xNodi + (a + b) / 2;

end