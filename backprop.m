%
% backpropagation with bipolar sigmoidal activation
%

function [V,W,e] = backprop(x, t, h, small, eta, maxiter);

fprintf('xxxx\n');
[m,n] = size(x);
V = small*(2*rand(n,h)-1);
W = small*(2*rand(h+1,1)-1);
ok=0;
iter = 0;
e = [];
fprintf('iter \t error\n');
while (ok == 0 && iter < maxiter)
   iter = iter+1;
   err = 0;
   for i = 1:length(x);
      %faza w przd
      z_in = (x(i,:)*V)';
      z = [2./(1+exp(-z_in)) - 1; 1];
      y_in = z'*W;
      y = 2/(1+exp(-y_in)) - 1;
      
      err = err + (t(i) - y)^2 / 2;
      %faza w ty
      delta = (t(i)-y)*(1-y^2)/2;
      
      W = W + eta*delta*z;
      
      h_delta = eta*delta*W.*(1-z.^2)/2;
      for j=1:h
         V(:,j) = V(:,j) + h_delta(j)*x(i,:)';
      end;      
   end;
   if mod(iter,100)==0
      fprintf('%d \t %12.10f\n', iter, err);
   end;
   %pause
   e = [e err];
   if err<1e-5;
      ok = 1;
   end;
end;

