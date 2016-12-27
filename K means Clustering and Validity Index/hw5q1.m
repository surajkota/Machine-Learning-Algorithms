%A = importdata('HW5-data.txt'); 
%M=A.data; save('hw5.mat','M');
%clearvars;
load('hw5.mat');
%k=3;
Uprev=zeros(k,150);
Ucurr=zeros(k,150);
v=zeros(k,4);
r = randi([1 100],1,k)
%r=[99,53,48,81,23,50,91,58,85,74];
for m=1:k
    v(m,:)=M(r(m),:);
end
%55    96    97
% if ii==1
% v(1,:)=M(1,:);
% v(2,:)=M(71,:);
% v(3,:)=M(145,:);
% end
%v(4,:)=M(3,:);
%v(5,:)=M(50,:);

%tried 1,71,141, wored very well; 141,101, 145 itr more and some wrongs
%at
converge = false;
itr=0;
distance=zeros(k,150);
debug=0;
while 1
    itr=itr+1;
    
    for i=1:150
        %clusterindex=0;
        for j=1:k
            distance(j,i)=0;
            %prevdistance=0;
            for p=1:4
                temp=(M(i,p)-v(j,p));
                distance(j,i)=distance(j,i)+(temp*temp);
            end
            distance(j,i)=sqrt(distance(j,i));
%             if j==1
%                 prevdistance=distance(j,i);
%                 clusterindex=j;
%             elseif distance(j,i)<prevdistance
%                 prevdistance=distance(j,i);
%                 clusterindex=j;
%                 debug=debug+1;
%             end
        end
        [indvalue,clusterindex]=min(distance(:,i));
        for lo=1:k
            if clusterindex==lo
                Ucurr(lo,i)=1;
            else
                Ucurr(lo,i)=0;
            end
        end
    end
    J(itr)=0;
    for j=1:k
        for i=1:150
            jdistance=0;
            if Ucurr(j,i)==1
                for p=1:4
                    temp=(M(i,p)-v(j,p));
                    jdistance=jdistance+(temp*temp);
                end
                %distance=sqrt(distance);
            end
            J(itr)=J(itr)+(Ucurr(j,i)*(jdistance));
        end
    end
    %change the mean
    for j=1:k
        npts=0;
        sum=zeros(1,4);
        for i=1:150
           if Ucurr(j,i)==1
               npts=npts+1;
               sum(1,:)=sum(1,:)+M(i,:);
           end
        end
        if npts~=0
        v(j,:)=(sum(1,:)/npts);
        end
    end
    converge=isequal(Uprev,Ucurr);
    if converge>0
        break;
    end
    Uprev=Ucurr;
end
%figure();
