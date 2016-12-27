%This file contains the code to train the neural network
clear all;
% input for network
input = [1 0; 0 1; -1 0; 0 -1; 0.5 0.5; -0.5 0.5; 0.5 -0.5; -0.5 -0.5; ];
% Desired output of NN
output = [1;1;1;1;0;0;0;0];
% Learning coefficient
coeff = 0.7;
% Number of learning iterations
iterations = 12000; %50k random seed with, and 25k without random seed sometimes problem
%number of units in input..hidden..output layer
units=[2 6 1]; 
% assign weights randomly
w1=-1+2*rand(units(2),units(1));
w2=-1+2*rand(units(3),units(2));
%bias for hidden layer 
b1=zeros(units(2),1);
% Initialize the bias
b1(:)=1;
%bias for output layer
b2=1;

for i = 1:iterations
   out = zeros(8,1);    %neural network output
   numIn = length (input(:,1));
   for j = 1:numIn
      %feed forward
      % net for Hidden layer
      H1 = w1*transpose(input(j,:))+b1;
      % Send data through sigmoid function 1/1+e^-x
      % Note that sigma1 is the activation function that is in sigma1.m
      % f(net) at hidden layer
      H1=sigma1(H1);
      % net for output layer
      out(j) = w2*transpose(H1)+b2;
      % f(net) at output layer
      out(j)=sigma1(out(j));
      
      %back propogation
      % Adjust delta values of weights
      
      % For output layer:
      % delta = (1-actual output)*(desired output - actual output) 
      delta3_1 = out(j)*(1-out(j))*(output(j)-out(j));
      
      % Propagate the delta backwards into hidden layers
      % delta weight = coeff*x*delta
      % Add weight changes to original weights 
      w2=w2+coeff*delta3_1*H1;
      b2=b2+coeff*delta3_1*b2;

      for itr=1:units(2)
          delta2(itr) = H1(itr)*(1-H1(itr))*w2(itr)*delta3_1;
          w1(itr,:) = w1(itr,:)+coeff*delta2(itr)*input(j,:);
          b1(itr)=b1(itr)+coeff*delta2(itr)*b1(itr);
      end
      % And use the new weights to repeat process.
   end   
end