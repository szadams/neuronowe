% dobra wersja z funkcj¹ sigmoidaln¹
%

clear all;
close all;
fprintf('Problem XOR\n');

%dane wejœciowe
x = [-1 -1 1
   -1 1 1
   1 -1 1
   1 1 1];
t = [-1; 1; 1; -1];

maxiter = 1000;%max. no. of iterations
small = 0.05;
eta = 0.95;		% learning rate
h = 2;			% hidden units

[V, W, e] = backprop(x, t, h, small, eta, maxiter);

semilogy(e, 'LineWidth',2); grid on;

%%% test
fprintf('\n');
fprintf('Verification:\n')
fprintf('x1 x2  t     y\n');
fprintf('----------------\n');
for i = 1:length(x);
   z_in = (x(i,:)*V)';
   z = [2./(1+exp(-z_in))-1; 1];
   y_in = z'*W;
   y = 2/(1+exp(-y_in))-1;
   %fprintf('%2.0f %2.0f \t %2.0f \t %7.4f\n', x(i,1), x(i,2), t(i), y);
   fprintf('%2.0f %2.0f %2.0f %7.4f\n', x(i,1), x(i,2), t(i), y);
end;

