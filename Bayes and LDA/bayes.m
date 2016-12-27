clearvars;


run('hw4q1.m');
tic
term11=pinv(covar1);
term12=pinv(covar2);
term2=(d/2)*log(2*pi);
term31=(0.5)*log10(det(covar1));
term32=(0.5)*log10(det(covar2));
term41=log(pj(1));
term42=log(pj(2));
finalterm1=term41-term31-term2;
finalterm2=term42-term32-term2;
i=0;
class=zeros(1,200);
g1=zeros(1,200);
g2=zeros(1,200);
confusion200=zeros(2,2);


for samples=1:200
    i=samples;
    mt1=(M(samples,2:8)-mu(1,:));
    mt2=(M(samples,2:8)-mu(2,:));
    g1(i)=(-0.5)*mt1*term11*transpose(mt1);
    g1(i)=g1(i)+finalterm1;
    g2(i)=(-0.5)*mt2*term12*transpose(mt2);
    g2(i)=g2(i)+finalterm2;
    if g1(i)>g2(i)
        class(i)=1;
        if M(samples,1)==class(i)
            confusion200(1,1)=confusion200(1,1)+1;
        else
            confusion200(2,1)=confusion200(2,1)+1;
        end
    else
        class(i)=2;
        if M(samples,1)==class(i)
            confusion200(2,2)=confusion200(2,2)+1;
        else
            confusion200(1,2)=confusion200(1,2)+1;
        end
    end
end

toc
confusiontrain=zeros(2,2);
confusiontest=zeros(2,2);
for samples=1:140
    i=samples;
    if g1(i)>g2(i)
        %class(i)=1;
        if M(samples,1)==class(i)
            confusiontrain(1,1)=confusiontrain(1,1)+1;
        else
            confusiontrain(2,1)=confusiontrain(2,1)+1;
        end
    else
        %class(i)=2;
        if M(samples,1)==class(i)
            confusiontrain(2,2)=confusiontrain(2,2)+1;
        else
            confusiontrain(1,2)=confusiontrain(1,2)+1;
        end
    end
end

for samples=141:200
    i=samples;
    if g1(i)>g2(i)
        %class(i)=1;
        if M(samples,1)==class(i)
            confusiontest(1,1)=confusiontest(1,1)+1;
        else
            confusiontest(2,1)=confusiontest(2,1)+1;
        end
    else
        %class(i)=2;
        if M(samples,1)==class(i)
            confusiontest(2,2)=confusiontest(2,2)+1;
        else
            confusiontest(1,2)=confusiontest(1,2)+1;
        end
    end
end