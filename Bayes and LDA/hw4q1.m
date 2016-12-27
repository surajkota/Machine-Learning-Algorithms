%A = importdata('HW4.txt'); M=A.data; save('hw4.mat','M');
% M = dlmread('HW4.txt','m',1,0); %Use a better name that M
% save('somefile.mat', 'M');

load('hw4.mat');
mu=zeros(2,7);
sum1=zeros(2,7);
nj=[0,0];

for i=1:200
    M(i,1)=M(i,1)+1;
end

for i=1:140
    sum1(M(i,1),:)=sum1(M(i,1),:)+M(i,2:8);
    nj(M(i,1))=nj(M(i,1))+1;
end

for i=1:2
    for j=1:7
        mu(i,j)=sum1(i,j)/nj(i);
    end
end

cov1=zeros(nj(1),7);
cov2=zeros(nj(2),7);
covar1=zeros(7);
covar2=zeros(7);
n1=1;
n2=1;
for i=1:140
        if M(i,1)==1
            cov1(n1,:)=M(i,2:8)-mu(M(i,1),:);
            covar1=covar1+(transpose(cov1(n1,:)))*(cov1(n1,:));
            n1=n1+1;
        elseif M(i,1)==2
            cov2(n2,:)=M(i,2:8)-mu(M(i,1),:);
            covar2=covar2+(transpose(cov2(n2,:)))*(cov2(n2,:));
            n2=n2+1;
        end
end

covar1=(1/nj(1))*covar1;
covar2=(1/nj(2))*covar2;
pj(1)=nj(1)/140;
pj(2)=nj(2)/140;
d=7;