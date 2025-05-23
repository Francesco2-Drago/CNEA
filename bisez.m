function [xvect, it] = bisez(a, b, toll, fun)
%
% [xVect, iter] = bisez(a, b, toll, f)
%
% Metodo di bisezione per l'approssimazione dello zero (radice) alpha
% della funzione f(x) ( f(alpha) = 0 )
%
% Parametri di ingresso:
% a, b      Estremi intervallo di ricerca dello zero
% toll      Tolleranza sul criterio d'arresto
% f         Funzione definita come inline / anonymous
%
% Parametri di uscita:
% xVect     Vettore contenente tutte le iterate
%           calcolate (l'ultima componente e' la soluzione approssimata)
% iter      Numero di iterazioni effettuate
% 
%                                         Politecnico di Milano, 04/04/2024
% 
% [xVect, iter] = bisez(a, b, toll, f)
% 

it=-1; % in questo modo la prima iterazione del ciclo while calcola x0, la seconda iterazione di while calcola x1...
xvect=[];

err=toll+1; 

nmax=ceil(log2((b - a)/toll) -1 );

fprintf('Massimo numero di iterazioni ammissibili %-d \n',nmax);

% controllo sulla validita' degli estremi
if (fun (a) * fun (b) > 0)
    error ('La funzione deve avere segno diverso nei due estremi');
end

% il while deve arrivare a calcolare x_nmax, quindi il contatore it deve
% valere al massimo nmax-1 (occhio che parto da -1 quindi iterazione 0
% per fissare valore iniziale e poi inizio a contare)

while (it <= nmax-1 && err > toll) 
    
    it=it+1;
    x = (b+a)/2; % stima dello zero
    fc = fun(x);     
    
    if (fc == 0)
       err=0;
    else
       err=abs(fc); 
    end
    
    xvect=[xvect;x]; % aggiornamento soluzione
    
    % scelta del nuovo estremo per l'eventuale ciclo successivo       
    if (fc*fun(a) > 0)
          a=x; 
    else
          b=x; 
    end
    
end

if (it==nmax)
    fprintf(' ATTENZIONE ! Massimo numero di iterazioni raggiunte!  Errore sul residuo %-6.4e \n', err)
else
    fprintf('x_%-d soddisfa la tolleranza sul residuo \n', it)
end

fprintf(' Radice calcolata       : %-12.8f \n', xvect(end))