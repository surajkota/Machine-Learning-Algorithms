%This file contains the code for activation function
function y = sigma1( x )
len=size(x);
    %calculate the f(net) for the given layer
for ii=1:len
    %sigmoid activation function
    y(ii)=1.0/(1.0+exp(-x(ii)));
end
end