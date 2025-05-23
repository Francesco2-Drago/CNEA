function [alpha_k, it] = backtracking(Phi, GradPhi, x_k, d_k, c1, rho, nmax )
% function [alpha_k, it] = backtracking(Phi, GradPhi, x, d, c1, rho, nmax )
% Algoritmo di backtracking per il calcolo di alpha_k (ste-size metodi di
% discesa per ottimizzazione)
%
% INPUT Phi    : (handle function) Funzionale
%       GradPhi: (handle function) Gradiente del funzionale
%       x_k    : (double, vettore) punto corrente
%       d_k    : (double, vettore) direzione corrente
%       c1     : (double) parametro metodo, c1 \in (0,1)
%       rho    : (double) parametro metodo, rho \in [1/10, 1/2]
%       nmax   : (int) numero massimo di iterazioni
%
% OUTPUT alpha_k : (double) valore step-size
%        it      : (int) numero di iterazioni

% Inizializzo alpha_k
alpha_k = 1;

% Inizializzo parametri metodo iterativo
it = 0;
cond_wolfe = 0;

% a1 = cond_wolfe==0
% a2 =it<nmax
% a3 = cond_wolfe==0 && it<nmax

while cond_wolfe==0 && it<nmax
    
    % Aggiorno alpha_k (riduco di un fattore rho)
    alpha_k = rho*alpha_k;
    
    % Aggiorno numero di iterazioni
    it = it + 1
    
    % Aggiorno condizione di uscita
    cond_wolfe = Phi(x_k(1) + alpha_k*d_k(1), x_k(2) + alpha_k*d_k(2)) ...
        <= Phi(x_k(1),x_k(2)) + c1*alpha_k*d_k'*GradPhi(x_k(1), x_k(2));
    cond_wolfe

end

end