function [xvect, it] = gradiente_coniugato_opt(Phi, GradPhi, flag_metodo, x0, toll, nmax)
% function [xvect, it] = gradiente_coniugato(Phi, GradPhi, flag_metodo, x0, toll, nmax)
% Algoritmo gradiente (gradiente coniugato) per la risoluzione di problemi 
% di ottimizzazione per funzionali in 2-dimensioni. Tramite il terzo input
% (flag_metodo) è possibile scegliere se usare il metodo del gradiente
% o il metodo del gradiente coniugato (con \beta_k di Fletcher-Reeves)
%
% INPUT Phi         : (handle function) Funzionale
%       GradPhi     : (handle function) Gradiente del funzionale
%       flag_metodo : (string) flag per scegliere tra gradiente e gradiente
%                     coniugato 
%       x0          : (double, vettore) Guess iniziale
%       toll        : (double) tolleranza
%       nmax        : (int) numero massimo di iterazioni
%
% OUTPUT xvect : (double, matrice) matrice che, su ogni colonna, contiene 
%                la soluzione a ogni iterazione
%        it    : (int) numero di iterazioni

% Inizializzo variabili per ciclo iterativo
it  = 0;
err = toll+1;

% Inizializzo la matrice soluzione
xvect = x0;

% Calcolo la direzione iniziale di discesa
d = - GradPhi(x0(1), x0(2));

% Parametri backtracking
c1_bt   = 1e-4;
rho_bt  = 0.3;
nmax_bt = 10;

% x0 si aggiorna come penultimo valore

% Ciclo while per calcolo x^{it+1} (it = 0, 1, ...)
while it < nmax && err > toll
    
    % Calcolo il nuovo valore di alpha_k
    [alphak, ~] = backtracking(Phi, GradPhi, x0, d, c1_bt, rho_bt, nmax_bt);
     
    % Calcolo il nuovo valore di x
    x_new = x0 + alphak * d;

    % Swtich per scelta metodo gradiente o gradiente coniugato
    switch flag_metodo
        case 'G' % gradiente
            betak = 0;
        case 'FR' % gradiente coniugato (Fletcher-Reeves)
            betak = norm(GradPhi(x_new(1), x_new(2)))^2 / norm(GradPhi(x0(1), x0(2)))^2;
        otherwise
            error('metodo CG non definito');
    end

    % Aggiorno la direzione di discesa (se beta_k = 0 -> gradiente)
    d = - GradPhi(x_new(1), x_new(2)) + betak * d;  

    % Aggiorno quantità per metodo iterativo (it, err, x0, xvect)
    it = it + 1;
    err = norm(GradPhi(x_new(1), x_new(2)));
    x0 = x_new;
    xvect = [xvect x_new];
    
end

switch flag_metodo
    case 'G' % gradiente
        if err <= toll
             fprintf(['\n Il metodo del gradiente converge in %d iterazioni \n' ...
                 'al punto di minimo x = (%f,%f)^T \n '], it, xvect(1,end), xvect(2,end));
        else
             fprintf('\n Il metodo del gradiente non converge in %d iterazioni. \n', it)
        end
        
    case 'FR' % gradiente coniugato (Fletcher-Reeves)
        if err <= toll
             fprintf(['\n Il metodo del gradiente coniugato (Fletcher-Reeves) converge in %d iterazioni \n' ...
                 'al punto di minimo x = (%f,%f)^T \n '], it, xvect(1,end), xvect(2,end));
        else
             fprintf('\n Il metodo del gradiente coniugato (Fletcher-Reeves) non converge in %d iterazioni. \n',  it)
        end    
end

end