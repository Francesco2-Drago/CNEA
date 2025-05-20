function [pol_Lagrange] = polinomi_caratteristici_Lagrange(xNodi)

    % [pol_Lagrange] = polinomi_caratteristici_Lagrange(xNodi)
    %
    % Funzione che calcola i polinomi caratteristici di Lagrange come simbolici
    %
    % Input:
    % xNodi: vettore riga contenente i nodi
    %
    % Output:
    % pol_Lagrange: matrice riga contenente i polinomi caratteristici di Lagrange come simbolici
    %
    % [pol_Lagrange] = polinomi_caratteristici_Lagrange(xNodi)

    pol_Lagrange = sym(zeros(1, length(xNodi)));

    syms x;

    for i = 1:length(xNodi)
        % Costruzione del polinomio di Lagrange L_i(x)
        L = 1;
        for j = 1:length(xNodi)
            if j ~= i
                L = L * (x - xNodi(j))/(xNodi(i) - xNodi(j));
            end
        end
        pol_Lagrange(i) = L;
    end

end