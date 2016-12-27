

clear all;
% input for x1 and x2
input = [1 0; 0 1; -1 0; 0 -1; 0.5 0.5; -0.5 0.5; 0.5 -0.5; -0.5 -0.5];
% Desired output of NN
output = [1;1;1;1;0;0;0;0;];
% Initialize the bias
bias = [1 1 1 1 1];
% Learning coefficient
coeff = 0.7;
% Number of learning iterations
iterations = 20000;
% Calculate weights randomly using seed.
%rand('state',sum(100*clock));
units=[2 4 2 1];
w1=2*rand(units(2),units(1));
w2=2*rand(units(3),units(2));
w3=2*rand(units(4),units(3));
b1=zeros(units(2),1);
b2=zeros(units(3),1);
b3=1;
b1(:)=1;
b2(:)=1;

for i = 1:iterations
   out = zeros(8,1);
   numIn = length (input(:,1));
   for j = 1:numIn
      %feed forward
      % Hidden layer
      H1 = w1*transpose(input(j,:))+b1;%+b1;%bias(1,1)*weights(1,1)+ input(j,1)*weights(1,2)+ input(j,2)*weights(2,2);
      % Send data through sigmoid function 1/1+e^-x
      % Note that sigma is a different m file 
      % that I created to run this operation
      H1=sigma1(H1);
      % Output layer
      H2 = w2*transpose(H1)+b2;
      H2=sigma1(H2);
      out(j)=w3*transpose(H2)+b3;
      out(j)=sigma1(out(j));
      % Adjust delta values of weights
      % For output layer:
      % delta(wi) = xi*delta,
      % delta = (1-actual output)*(desired output - actual output) 
      delta4_1 = out(j)*(1-out(j))*(output(j)-out(j));
      
      % Propagate the delta backwards into hidden layers
%       delta2_1 = H1(1)*(1-H1(1))*w2(1)*delta3_1;
%       delta2_2 = H1(2)*(1-H1(2))*w2(2)*delta3_1;
%       delta2_3 = H1(3)*(1-H1(3))*w2(3)*delta3_1;
%       delta2_4 = H1(4)*(1-H1(4))*w2(4)*delta3_1;
      % Add weight changes to original weights 
      % And use the new weights to repeat process.
      % delta weight = coeff*x*delta
      w3=w3+coeff*delta4_1*H2;
      b3=b3+coeff*delta4_1*b3;
      for itr=1:units(3)
          delta3(itr) = H2(itr)*(1-H2(itr))*w3(itr)*delta4_1;
          w2(itr,:) = w2(itr,:)+coeff*delta3(itr)*H1;
          b2(itr)=b2(itr)+coeff*delta4_1*b2(itr);
      end
      for itr=1:units(2)
          delta2(itr) = H1(itr)*(1-H1(itr))*w2(itr)*delta3(ceil(itr/2));
          w1(itr,:) = w1(itr,:)+coeff*delta2(itr)*input(j,:);
          b1(itr)=b1(itr)+coeff*delta2(itr)*b1(itr);
      end
%       for k = 1:2
%          if k == 1 % Bias cases
%             weights(1,k) = weights(1,k) + coeff*bias(1,1)*delta2_1;
%             weights(2,k) = weights(2,k) + coeff*bias(1,2)*delta2_2;
%             weights(3,k) = weights(3,k) + coeff*bias(1,3)*delta3_1;
%          else % When k=2 or 3 input cases to neurons
%             weights(1,k) = weights(1,k) + coeff*input(j,1)*delta2_1;
%             weights(2,k) = weights(2,k) + coeff*input(j,2)*delta2_2;
%             weights(3,k) = weights(3,k) + coeff*H1(k-1)*delta3_1;
%          end
%       end
   end   
end