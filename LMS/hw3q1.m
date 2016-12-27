clear
load('training.mat')
load('validate.mat')
num=0;
kk=0;
for m=3:30
%m=3
    ntest=size(validate,1);
    Y=validate(m+1:ntest,:)
    X = zeros(ntest-m,m);
    for i=1:m
        X(:,i) = validate(i:ntest+i-m-1,:); %X(:,m-(i-1)
    end
    %X=flipud(X)
    R=transpose(X)*X;
    [V,D]=eig(R);
    %disp(D);
    A=max(D);
    lmax=max(A');
    umax=1/lmax;
    sz=umax/10;
    i=0;
    for itr=1:10
        i=sz*itr;
        
        num=num+1;
        kk=kk+1;
        for j=1:m
            w(j,num)=0;
        end
        stepsizes(num,:)=i;
        sumerr=0;
        for k=1:floor(1000-m-1)
           err(k)=Y(k,:)-X(k,:)*flipud(w(:,num)); %w(1:m,num)
           %errorfi(k)=abs(err(k)^2);
           sumerr=sumerr+(err(k)*err(k));
           msecurr=(1/k)*(sumerr);
           mseerrorfi(k,num)=msecurr;
           w(:,num)=flipud(w(:,num))+2*i*err(k)*transpose(X(k,:));
        end
        mseplot(num,:)=(sumerr/(1000-m));
        mm(num,:)=m;
    end
end
[po,pos]=min(mseplot);

%{
for i=1:28
    for j=1:10
        mm(i*j,:)=i+3;
    end
end
%}
tri=delaunay(mm,stepsizes);
trisurf(tri,mm,stepsizes,mseplot);
xlabel('Filter order: M');
ylabel('Step size: ita');
zlabel('Mean Square Error')
%plot(errorfi)
%{
num1=0;
mm=[3 8 13 19 25 30]
for lo=3:30
    m=lo;
    nvtest=size(validate,1);
    Yv=validate(m+1:nvtest,:)
    Xv = zeros(nvtest-m,m);
    for i=1:m
        Xv(:,i) = validate(i:nvtest+i-m-1,:);
    end
    for i=1:28
        num1=num1+1;
        sumerr=0;
        for k=1:floor(1000-m-1)
           err=Yv(k,:)-Xv(k,:)*w(1:m,num1);
           %errorfi(k,num)=abs(err^2);
           sumerr=sumerr+err^2;
           msecurr=1/k*(sumerr);
           mseerrorfiv(lo-2,i)=msecurr;
        end
    end
end
%surf([3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30],[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28],mseerrorfiv)
%}