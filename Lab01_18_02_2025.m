%{ ";" sopprime la stampa dell'operazione
% ","
% layout per tornare al leyout di default/modificare layout attuale
% clear solo cancella tutte variabili, clear variabile, cancella variabile
% "help" mio miglior amico
% non ho e ma posso scrivere come exp(1), occhio a variabili predefinite,
% sovrascrivibili come pi e i
% format long o long e per vedere maggiore precisione e maggiore precisione
% con forma scientifica
%}

% come scrivere vettori riga / colonna
a=[3 5 2 9] % come riga, al più a=[3, 5, 2, 9]
a=[3; 5; 2; 9] % come colonna
a=[3 5 2 9]' % come riga che  viene trasposto in colonna con apice '

% posso scrivere vettore equispaziato come a=[inizio : passo: fine] dove le
% parentesi quadre sono superflue
a=0 : 0.1 : 1
% lo standard è passo 1, se scrivo solo inizio e fine ho passo 1, posso
% anche andare all'indietro
a=0 : 5
a=0 : -1 : -5

% se non so passo posso usare "linspace" con sintassi linspace(punto
% iniziale, punto finale, numero totale di punti)
a=linspace(0, 1, 5)

% in matlab matrice definita per riga come:
A=[1 2 3; 4 5 6; 7 8 9]
% funziona uguale trasposizione con apice '

% tutte operazioni come si può pensare intuitivamente ma occhio a
% compatibilità dimensione oggetti
% prodotto vettoriale indicato con "cross" es. cross(a, b)

% operazioni elemento per elemento con punto "." prima dell'operatore
% (moltiplicazione, elevazione a potenza, divisione, etc)
a=[1 2 3];
b=[4 5 6];
a .* b

% size per avere dimensione matrice con numero di righe e poi di colonne,
% se voglio solo numero di righe o colonne posso chiamarli rispettivamente
% con 1 e 2
size(A)
size(A,1) % numero righe
size(A,2) % numero colonne

% Per lunghezza vettore esiste comando "length"
length(a)

% max mi tira fuori un vettore con i valori massimi di tutte le colonne di
% una matrice, chiamando max(max(A)) trovo valore massimo di tutta la
% matrice
max(a)
max(A)
max(max(A))
% se scrivo M=max(a) ho salvato in M il valore massimo presente in a
% (vettore riga), se voglio anche l'indice della posizione posso scrivere
% [M, I]=max(a) allora in M salva il massimo, in I la posizione

% N.B. l'indicizzazione di matlab inizia da 1

% diag per avere la diagonale o sottodiagonali usando un altro numero
% (positivo sopra, negativo sotto)
diag(A) % =diag(A, 0)
diag(A, k)
% se invece uso comando diag su vettore, mi si crea matrice QUADRATA con
% vettore su diagonale o sottodiagonale a seconda dell'indice k
diag(a) % =diag(a, 0)
diag(a, k)
% se scrivo diag(diag(A)) scrivo matrice diagonale con la diagonale
% principale in questo caso di A

% tril e triu di una matrice per avere la matrice triangolare inferiore o
% superiore da una matrice di partenza

% posso chiamare e modificare cella singola di matrice con A(no. riga, no.
% colonna)

% per chiedere stampa intera riga di matrice posso scrivere A(2, 1 : 3)
% così stampa seconda riga e tre colonne, selezionate come un vettore da
% uno a tre con passo uno di default usando operatore :
% volendo stamparle tutte posso usare operatore end A(2, 1 : end) oppure
% più semplicemente solo i due punti A(2, :)
% per stampare solo alcuune righe e alcune colonne posso scrivere A([2 3]
% , [1 2])

% comando norma con norm dove numero accanto descrive tipo di norma, di
% base segna niente ho norma euclidea quindi 2
norm(a) % = norm(a, 2)
norm(a, inf) % per norma infinito e quindi massimo

% comando ones per matrice di uni, di base quadrata di dimensione tra
% parentesi, se specifico altro paramentro ottengo dimensione strana come
% righe e colonne
ones(3) % = ones(3, 3)
ones(2, 3)

% comando eye per matrice identità e nella parentesi dimensione

% comando rand con dimensione matrice nelle parentesi per matrice quadrata
% con numeri random tra 0 e 1

% funzioni come anonymous functions definite con nome = @(x) e funzione di
% x a seguire (x come qualsiasi altra cosa. Per chiamarla posso usare
% nome(variabile)
cubica=@(x) x.^3-1
% posso anche costruire funzioni di più variabili o funzioni da R a R2, il
% risultato nel caso sarà come vettore colonna

% posso vedere il risultato di queste funzioni come grafico con il comando
% plot e definendo un insieme di punti da valutare. Modo più semplice è
% passare insieme di punti di x e insieme di punti di y come plot(x, f(x))
% dove devo aver definito x come un insieme. Vedi funzionalità cosmesi
% grafico