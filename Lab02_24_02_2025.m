% Esempio di script fatto bene

clear
clc

f = @(x) sin(x);
g = @(x) cos(x);
x = 0 : 0.01 : pi;
y = f(x);
z = g(x);

% plot(x,y,'m:',x,z, 'b-', 'linewidth', 2)

% Il doppio commento divide in sezioni il codice "%%"
% comando legend per avere la legenta della funzione

% legend('Grafico di f', 'Grafico di g')

%% altro modo per fare grafico

% figure(1)
plot(x,y,'m:', 'LineWidth',2);
hold on
% figure(2)
plot(x,z,'b-', LineWidth=2);
grid on
legend('Grafico di f', 'Grafico di g')
title('Questo è un grafico')
xlabel('Asse X')
ylabel('Asse y')
axis([0,pi/2,0,1])
hold off

%% grafici in scala logaritmica (loglog doppia, semilogx/y solo un asse)

h=@(x) x.^2;
p=@(x) x.^3;

loglog(x,h(x),x,p(x), 'LineWidth',2)
% legend('x^2','x^3')
legend('$\frac{Dio}{buono}$', 'interpreter', 'latex')

%% cicli for

N=[2 4 6 8 10];
for n=N
    n
end

for n=10:-2:2
    n
end

%% cicli while

n=0;
while n<5
    n=n+1
end

%% blocco if

a=2;
b=3;

if a>3
    disp('a>3')
elseif b==5
        disp('b==5')
else
    disp('nessuna delle due')
end

if a~=b
    disp('diversi')
else
    disp('uguali')
end

% comandi and e or per condizioni come in c: && , ||

%%

A=ones(3);
B=2*A;

% doppio click su variabile nel workspace per visionarla in formato tabella

B>A

% matrice elemento per elemento!! per fare confronto matrici usare funzione
% isequal

isequal(A, B)

spy(A)
% rappresentazione grafica di componenti non nulli nella matrice

%% funzioni con più input/output, posso usare comando help con funzione
% che creo io e stampa il commento subito sotto il nome della funizone nel
% file della funzione

function[outuputarg1, outputarg2] = prova(inputarg1, inputarg2)
outuputarg1=inputarg1;
outuputarg2=inputarg2;
end

nargin
% da numero di variabili in ingresso alla fuunzione

nargout
% da numero di variabili in uscita dalla funzione
% se lasciato da solo restituisce solo il numero di variabili della
% funzione in uscita, indipendentemente dalla richiesta della funzione

% se voglio solo primo output scrivo
[out1]=prova(in1,in2)

% se voglio solo secondo output scrivo
[~, out2]=prova(in1,in2)

%% Autovalori e autovettori

% funzione eig che restituisce, data solo matrice, gli autovalori, se
% richiedo due output mi dà anche gli autovalori prima matrice autovalori
% poi autovettori

% vedi help

%% error

% error('Testo') permette di scrivere qualcosa e di bloccare il codice con
% un errore

%% fprintf

fprintf('Pi greco vale %f\n', pi)

%% breakpoint

% puoi inserire selezionando riga a sx

%% tre puntini e a capo si continua, non ri duplica segno