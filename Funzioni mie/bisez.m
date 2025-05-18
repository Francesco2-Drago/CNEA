function [xVect, iter] = bisez(a, b, toll, fun)

% Funzione del metodo di bisezione con in uscita vettore dei valori della
% radici di lunghezza nmax ovvero il numero di iterazioni necessarie per
% soddisfare la condizione di tolleranza e iter = nmax. In ingresso:
% estremi a, b dell'intervallo, tolleranza e funzione come anonymous
% [xVect, iter] = bisez(a, b, toll, fun)

nmax = ceil(log2(abs(b-a)/toll) - 1); % ceil per parte intera superiore
% floor per parte intera inferiore

xVect = [];
iter = 0;

while iter<=nmax % uguale perché devo fare anche iterazione numero nmax
    iter = iter + 1;
    xVect = [xVect (a + b) / 2];
    if (fun(xVect(iter))) == 0
        return
    elseif (fun(a) * fun(xVect(iter))) < 0
        b = xVect(iter);
    else
        a = xVect(iter);
    end
end

iter = iter - 1; % non considero ultima iterazione per uscire perché arrivo a nmax + 1

if iter + 1 == nmax % controllo superfluo, raggiungerò sempre
    fprintf('Massimo numero di iterazioni raggiunto.\nErrore sul residuo: %-6.4e\n', abs(fun(xVect(end))))
end

fprintf('Radice calcolata: %12.8f\n', xVect(end))

end