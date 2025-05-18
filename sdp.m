function flagSDP = sdp(A)

% Funzione controllo matrice A simmetrica definita positiva.
% Utilizza isequal(A, A') per controllare che sia simmetrica e eig(A)>0 per
% controllare che gli autovalori siano tutti positivi.
% In uscita booleano vero/falso se A e SDP o no.
% Stampa a video risultati durante analisi.
% 
% flagSDP = sdp(A)
% 

flagSDP = false;

if isequal(A, A')
    fprintf('A è simmetrica\n')
    if eig(A)>0
        fprintf('A è definita positiva\n')
        flagSDP = true;
    else
        fprintf('A non è definita positiva\n')
    end
else
    fprintf('A non è simmetrica\n')
end

end