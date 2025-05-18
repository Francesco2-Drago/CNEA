function [xvect, it] = newton(x0, nmax, toll, fun, dfun, mol)

% [xVect, iter] = newton(x0, nmax, toll, f, df, mol)
%
% Metodo di Newton e Newton modificato per l'approssimazione di uno zero
% (radice) della funzione f. Se la molteplicità (mol) dello zero da
% approssimare è specificata, allora viene applicato il metodo di Newton
% modificato. 
% Criterio d'arresto basato sulla differenza tra due iterate successive.
%
% Parametri di ingresso:
% x0          Iterata iniziale
% nmax        Numero massimo di iterazioni
% toll        Tolleranza sul criterio d'arresto (diff. iter. succ.)
% f, df       Anonymous functions contenenti la funzione e la sua derivata
% mol         Molteplicità assegnata allo zero. Se assegnato, permette di 
%             applicare il metodo di Newton modificato. Default: mol = 1
%
% Parametri di uscita:
% xVect      Vettore contenente tutte le iterate calcolate (l'ultima 
%            componente e' lo zero approssimato)
% iter       Numero di iterazioni effettuate
%
%                                         Politecnico di Milano, 04/04/2024
%
% [xVect, iter] = newton(x0, nmax, toll, f, df, mol)
% 

if (nargin == 5)
    mol = 1;
end

err = toll + 1;
it = 0;
xvect = x0;
xv = x0;

while (it< nmax && err> toll)
   dfx = dfun(xv);
   if dfx == 0
      error('Arresto per azzeramento di dfun\n')
   else
      xn = xv - mol*fun(xv)/dfx;
      err = abs(xn-xv);
      xvect = [xvect; xn];
      it = it+1;
      xv = xn;
   end
end

if (it < nmax)
    fprintf('Convergenza al passo k: %d\n', it)
else
    fprintf('È stato raggiunto il numero massimo di passi k: %d\n', it)
end

fprintf('Radice calcolata: %-12.8f\n', xvect(end))