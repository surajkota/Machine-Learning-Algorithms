mm = [3 8 13 19 25 30];
lambda = [.001 .002 .005 0.01 0.05 0.1]

err = zeros(1,6)
err1 = zeros (6,6)

load('training.mat')
load('validate.mat')
c = 1;
for p=1:6
    for q=1:6
        m = mm(p);
        l = lambda(q);
        ntest=size(training,1);
        X = zeros(ntest-m,m);
        for i=1:m
            X(:,i) = training(i:ntest+i-m-1,:);
        end
        R = transpose(X)*X;
        P = transpose(X)*training(m+1:ntest,:);
        Wt = inv(R + l*eye(m))*P;
%validation data
        nv=size(validate,1);
        Xv = zeros(nv-m,m);
        for i=1:m
            Xv(:,i) = validate(i:nv+i-m-1,:);
        end

        Yv1 = Xv * Wt
        %e = Yv1 - validate(m+1:nv,:)
        err1(p,q) = immse(Yv1,validate(m+1:nv,:));
        %err(c) = immse(Yv1,validate(m+1:nv,:));
        c=c+1;        
    end
end

%[ab,cd] = meshgrid(mm,lambda)
figure
surf(lambda,mm,err1)
%tri = delaunay(ab,cd);
%figure
%trisurf(tri,ab,cd,err);
%figure
%trisurf(tri,cd,ab,err);