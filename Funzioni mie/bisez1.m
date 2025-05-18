function [xvect,it] = bisez(a,b,toll,fun)
it=-1;
nmax=ceil(log2((b-a)/toll)-1);
xvect=[];
err=toll+1;

while( it<nmax && err>toll)
    it=it+1;
    x=(a+b)/2;
    fc=fun(x);

    if fc==0
        err=0;
    else 
        err=abs(fc);
    end

    xvect=[xvect;x];

    if fc*fun(a)<0
        b=x;
    else
        a=x;
    end
end
%-6.4e siggnifica che sto scrivendo in notazione scentifica con sei cifre
% decimale
if it==nmax
    fprintf('\nMassimo numero di iterazioni raggiunto! \nErrore sul residuo: %-6.4e',err);
end
%12.8f' significa che calcoli e restituisci la radici di float 
fprintf('\nRadice calcolata: %12.8f',xvect(end));
fprintf('\n');
end


  



