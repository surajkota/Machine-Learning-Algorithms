mm = [4 8 19 30];
lambda = [.001 .001 .001 .001]

err = zeros(1,4)
err1 = zeros (4,4)

load('training.mat')
load('test.mat')
hold on
figure
c = 1;
for p=1:4
    
        m = mm(p);
        l = 0.001;
        ntest=size(training,1);
        X = zeros(ntest-m,m);
        for i=1:m
            X(:,i) = training(i:ntest+i-m-1,:);
        end
        R = transpose(X)*X;
        P = transpose(X)*training(m+1:ntest,:);
        Wt = inv(R + l*eye(m))*P;
%validation data
        ntest=size(test,1);
        Xtest = zeros(ntest-m,m);
        for i=1:m
            Xtest(:,i) = test(i:ntest+i-m-1,:);
        end

        Ytest1 = Xtest * Wt
        if p==1
            figure
        plot(Ytest1 - test(m+1:ntest,:))
        elseif p==2
            figure
        plot(Ytest1 - test(m+1:ntest,:))
        elseif p==3
            figure
        plot(Ytest1 - test(m+1:ntest,:))
        else p==4
            figure
        plot(Ytest1 - test(m+1:ntest,:))
        end
        
        %e = Yv1 - validate(m+1:nv,:)
        %err1(p,q) = immse(Yv1,validate(m+1:nv,:));
    
end
figure
plot(test)