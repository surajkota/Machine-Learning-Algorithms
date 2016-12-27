m = [4 8 30];
lambda = 0.001
 
err = zeros(3,1);
 
load('training.mat')
%load('validate.mat')
load('test.mat')
load('testnoisy.mat')
%c = 1;
%figure;
%hold on
for p=1:3    
        ntrain=size(training,1);
        X = zeros(ntrain-m(p),m(p));
        for i=1:m(p)
            X(:,i) = training(i:ntrain+i-m(p)-1,:);
        end
        R = transpose(X)*X;
        P = transpose(X)*training(m(p)+1:ntrain,:);
        Wtrain = inv(R + lambda*eye(m(p)))*P;
        
     %------------test data--------------------
        ntestn=size(testnoisy,1);
        Xtestn = zeros(ntestn-m(p),m(p));
        for i=1:m(p)
            Xtestn(:,i) = testnoisy(i:ntestn+i-m(p)-1,:);

        end
 
        Yhat = Xtestn * Wtrain;
        %e = Yv1 - validate(m+1:nv,:)
        err(p,1) = mean(Yhat - (test(m(p)+1:ntestn,:))).^2;
        %c=c+1;
        
        plot(err);
        
end
%figure;
%plot(X);
%[x,y] = meshgrid(m,lambda);
plot(m,err)
%tri = delaunay(x,y);
%trisurf(tri,m,err);