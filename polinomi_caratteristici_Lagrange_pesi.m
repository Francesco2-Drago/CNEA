function [pol_Lagrange, pesi] = polinomi_caratteristici_Lagrange_pesi(xNodi, a, b)

    % [pol_Lagrange, pesi] = polinomi_caratteristici_Lagrange_pesi(xNodi, a, b)
    %
    % Funzione che calcola simbolicamente e non i nodi, polinomi caratteristici di Lagrange e i loro pesi
    %
    % Input:
    % xNodi: vettore colonna contenente i nodi di cui calcolare i polinomi caratteristici di Lagrange e i pesi
    % a: estremo sinistro dell'intervallo, in mancanza risultato simbolico
    % b: estremo destro dell'intervallo, in mancanza risultato simbolico
    %
    % Output:
    % pol_Lagrange: vettore colonna contenente i polinomi caratteristici di Lagrange come simbolici
    % pesi: vettore colonna contenente i pesi associati ai polinomi di Lagrange come simbolici
    %
    % [pol_Lagrange, pesi] = polinomi_caratteristici_Lagrange_pesi(xNodi, a, b)

    if ~exist('xNodi', 'var') || isempty(xNodi)
        error('Nessun nodo specificato. Utilizzare un vettore di nodi.');
    end

    syms x;
    
    if ~exist('a', 'var') || ~exist('b', 'var')
        syms a b;
    end

    pol_Lagrange = sym(zeros(length(xNodi), 1));
    pesi = sym(zeros(length(xNodi), 1));

    for i = 1:length(xNodi)
        % Costruzione del polinomio di Lagrange L_i(x)
        L = 1;
        for j = 1:length(xNodi)
            if j ~= i
                L = L * (x - xNodi(j))/(xNodi(i) - xNodi(j));
            end
        end
        pol_Lagrange(i) = L;

        pesi(i) = int(pol_Lagrange(i), x, a, b);
    end

end