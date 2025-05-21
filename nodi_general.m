function [xNodi] = nodi_general(mode, n, a, b)

    % [xNodi] = nodi_general(mode, n, a, b)
    %
    % Funzione che calcola n + 1 nodi secondo la modalità specificata, in un dato intervallo [a, b] o simbolici
    %
    % Input:
    % mode: 'EQ' per nodi equispaziati, 'CGL' per Chebyshev-Gauss-Lobatto, 'GL' per Gauss-Legendre
    % n: ordine del polinomio, n + 1 nodi calcolati
    % a: estremo sinistro dell'intervallo, in mancanza risultato simbolico
    % b: estremo destro dell'intervallo, in mancanza risultato simbolico
    %
    % Output:
    % xNodi: vettore colonna contenente i nodi di Chebyshev-Gauss-Lobatto, equispaziati o Gauss-Legendre (secondo la modalità)
    %
    % [xNodi] = nodi_general(mode, n, a, b)

    if ~exist('mode', 'var') || isempty(mode)
        error('Nessun modo specificato. Utilizzare "CGL", "EQ" o "GL".');
    end

    if nargin < 2
        error('Numero insufficiente di argomenti. Specificare almeno mode e n.');
    end

    if ~exist('a', 'var') || ~exist('b', 'var')
        syms a b;
    end

    if strcmp(mode, 'CGL')
        % Calcolo dei nodi di Chebyshev-Gauss-Lobatto
        xNodi = nodi_CGL(n, a, b);
    elseif strcmp(mode, 'EQ')
        % Calcolo dei nodi equispaziati
        if n ~= 0
            h = (b - a) / n;
            xNodi = a + h * (0:n)';
        else
            xNodi = (a + b) / 2;
        end
    elseif strcmp(mode, 'GL')
        % Calcolo dei nodi di Gauss-Legendre
        xNodi = zplege(n, a, b);
    else
        error('Modo non riconosciuto. Utilizzare "CGL", "EQ" o "GL".');
    end