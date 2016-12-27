load('validate.mat');
m=3
 ntest=size(validate,1);
    %Y=(m+1:ntest,:)
    X = zeros(ntest-m,m);
    for i=1:m
        X(:,i) = validate(i:ntest+i-m-1,:);
    end
    R=transpose(X)*X;
    [V,D]=eig(R);
    %disp(D);
    A=max(D);
    lmax=max(A');
    mu=(1/lmax)/10;
    W=zeros(m,1);
for i=m:1000-m
    X=(validate(i:-1:i-m+1));
    D=validate(i+1);
    Y=transpose(X)*W;
    Ei(i)=D-Y;
    J(i)=1/i*(sum(Ei(i)^2));
    W=W+2*(mu)*(D-Y)*X;
end
plot(J);