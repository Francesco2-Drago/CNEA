function [R] =c_holesky(A)
% [R] =cholesky(A) ricorda poi di dover fare y=fwsub(R',b);
% x=bksub(R,y);
n=size(A,1);
R=zeros(n);
 R(1,1)=sqrt(A(1,1));
 t=0;
 s=0;
 if A==A'
     t=1;
 end
 if dp(A)==1
     s=1;
 end
 if s==1 && t==1
 for i=2:n
     for j=1:i-1
         R(j,i)=(1/R(j,j))*(A(i,j)-sum(R(1:j-1,i).*R(1:j-1,j)));
     end
     R(i,i)=sqrt(A(i,i)-sum(R(1:i-1,i).^2));
 end
 else
     disp('La matrice non è simmetrica o definita positiva');
 end


end