function [L] = costante_di_Lebesgue(xNodi, a, b)

    % [L] = costante_di_Lebesgue(xNodi, a, b)
    %
    % Funzione che calcola la costante di Lebesgue per i polinomi di Lagrange, in un intervallo [a, b]
    %
    % Input:
    % xNodi:    vettore contenente i nodi di interpolazione per polinomi di Lagrange
    % a:        estremo sinistro del dominio di x
    % b:        estremo destro del dominio di x
    %
    % Output:
    % L:        costante di Lebesgue
    %
    % [L] = costante_di_Lebesgue(xNodi, a, b)

    xDisp = linspace(a, b, 1e3);

    % Calcolo dei polinomi di Lagrange
    pol_Lagrange = polinomi_caratteristici_Lagrange(xNodi);

    % Calcolo della costante di Lebesgue
    for i = 1:length(xDisp)
        temp = subs(sum(abs(pol_Lagrange)), 'x', xDisp(i));

        if ~exist('L', 'var') || temp > L
            L = temp;
        end 
    end