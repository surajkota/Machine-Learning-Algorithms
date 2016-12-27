L=[.001 .002 .005 0.01 0.05 0.1];
order=[3 8 13 19 25 30];
for i=1:length(order)
for j=1:length(L)
X=training(1:order(i),:).';

for k=2:(3000-order(i))
X=[X;training(k:k+order(i)-1,1).'];
end

Y=training(order(i)+1:3000,1);
I=eye(order(i));
W=inv((X'*X)+L(j)*I)*(X'*Y);

V_load=validate(order(i)+1:1000,:);
X_val=validate(1:order(i),:).';
for k=2:(1000-order(i))
    X_val=[X_val;validate(k:k+order(i)-1,1).'];
end
V_pred=X_val*W;
Error(i,j)=mean((V_pred-V_load).^2);

end
end

[ab,cd] = meshgrid(mm,lambda)
figure
surf(ab,cd,Error)