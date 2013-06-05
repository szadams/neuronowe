%
% funkcja z pracy Nozaki, et al. (1997)

function y = n_fun2(x)

y = exp(-2*log2((x-0.08/0.854).^2))*(sin(5*pi*(3.^(3/4)-0.05)).^6);
