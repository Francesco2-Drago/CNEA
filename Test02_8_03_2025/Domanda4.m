clear
close
clc

for b=-10:10
    A = [1 b 0
         1 5 1
         1 0 1]

    for i=1:size(A, 1)
        if det(A(1:i, 1:i))==0
            b
            error('A non LU fattorizzabile')
        end
    end
end