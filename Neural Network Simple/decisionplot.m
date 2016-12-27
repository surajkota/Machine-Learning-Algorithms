%This file contains the code to plot the decision boundary

%Train the NN
run('hw6trainNN.m');
[x1,x2] = meshgrid(-1:0.1:1); %get inputs for a square of length 2 values range from -1 to 1
p1 = x1(:);
p2 = x2(:);
p = [p1';p2'];
p = transpose(p);   %prepare input for the network
op=[];          %store output
color=[];       %color according to classified class
hold on;
for ai=1:size(p,1)
      %feed forward same as previous code, no backpropogation now
      H1 = w1*transpose(p(ai,:))+b1;
      H1=sigma1(H1);
      % Output layer
      op(ai) = w2*transpose(H1)+b2;
      op(ai)=sigma1(op(ai));
      %threshold for output
        
      if op(ai)<0.5
          plot(p(ai,1),p(ai,2),'.r', 'markersize', 10)
          color(ai)=0;  %class with 0 desired output
      else
          plot(p(ai,1),p(ai,2),'.y', 'markersize', 10)
          color(ai)=1;  %class with 1 desired output
      end
end
figure();
sz=25;
scatter(p2,p1,sz,color,'filled');
title('Results with 1 hidden layer of 6 units and training 12000 iterations');