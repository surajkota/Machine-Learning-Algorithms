clear
load('training.mat')
load('validate.mat')
num=0;
for m=3:30
    ntest=size(training,1);
    Y=training(m+1:ntest,:)
    X = zeros(ntest-m,m);
    for i=1:m
        X(:,i) = training(i:ntest+i-m-1,:);
    end
    R=transpose(X)*X;
    [V,D]=eig(R);
    %disp(D);
    A=max(D);
    lmax=max(A');
    umax=1/lmax;
    sz=umax/28;
    kk=0;
    i=0;
    for i=sz:sz:umax
        num=num+1;
        kk=kk+1;
        for j=1:m
            w(j,num)=0;
        end
        stepsizes(kk)=i;
        sumerr=0;
        for k=1:floor(3000-m-1)
           err=Y(k,:)-X(k,:)*w(1:m,num);
           w(:,num)=w(:,num)+2*i*err*transpose(X(k,:));
           errorfi(k,num)=abs(err^2);
           sumerr=sumerr+err^2;
           msecurr=(1/k)*(sumerr);
           mseerrorfi(k,num)=msecurr;
        end
    end
end
%plot(errorfi)

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
