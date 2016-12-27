clearvars;
tic
run('hw4q1.m');
%1
T=-19;
LHSterm1=(pinv((covar1+covar2)/2))*transpose(mu(2,:)-mu(1,:));
RHSterm1=(mu(1,:)*pinv(covar1)*transpose(mu(1,:)))-(mu(2,:)*pinv(covar2)*transpose(mu(2,:)));
RHSterm1=0.5*(RHSterm1+T);
i=0;
ldaclass=zeros(1,200);
ldalhs=zeros(1,200);
ldarhs=zeros(1,200);
ldaconfusion200=zeros(2,2);


for samples=1:200
    i=samples;
    ldalhs(i)=transpose(LHSterm1)*transpose(M(samples,2:8));
    if ldalhs(i)>RHSterm1
        ldaclass(i)=2;
        if M(samples,1)==ldaclass(i)
            ldaconfusion200(2,2)=ldaconfusion200(2,2)+1;
        else
            ldaconfusion200(1,2)=ldaconfusion200(1,2)+1;
        end
    else
        ldaclass(i)=1;
        if M(samples,1)==ldaclass(i)
            ldaconfusion200(1,1)=ldaconfusion200(1,1)+1;
        else
            ldaconfusion200(2,1)=ldaconfusion200(2,1)+1;
        end
    end
end
toc
ldaconfusiontrain=zeros(2,2);
ldaconfusiontest=zeros(2,2);
for samples=1:140
    i=samples;
    if ldalhs(i)>RHSterm1
        %class(i)=1;
        if M(samples,1)==ldaclass(i)
            ldaconfusiontrain(2,2)=ldaconfusiontrain(2,2)+1;
        else
            ldaconfusiontrain(1,2)=ldaconfusiontrain(1,2)+1;
        end
    else
        %ldaclass(i)=1;
        if M(samples,1)==ldaclass(i)
            ldaconfusiontrain(1,1)=ldaconfusiontrain(1,1)+1;
        else
            ldaconfusiontrain(2,1)=ldaconfusiontrain(2,1)+1;
        end
    end
end

for samples=141:200
    i=samples;
    if ldalhs(i)>RHSterm1
        %class(i)=1;
        if M(samples,1)==ldaclass(i)
            ldaconfusiontest(2,2)=ldaconfusiontest(2,2)+1;
        else
            ldaconfusiontest(1,2)=ldaconfusiontest(1,2)+1;
        end
    else
        %ldaclass(i)=1;
        if M(samples,1)==ldaclass(i)
            ldaconfusiontest(1,1)=ldaconfusiontest(1,1)+1;
        else
            ldaconfusiontest(2,1)=ldaconfusiontest(2,1)+1;
        end
    end
end