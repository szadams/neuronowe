function y = mytrimf(x, parms)
%MYTRIMF Triangular membership function. "x" = support of fuzzy sets, and "parms" 
%   are parameter, i.e. parms = [a b c]. We require that a <= b <= c.
%   If a = -inf represents left opened interval, and
%      c =  inf represents right opened interval
%   For example:
%
%       x = (0:0.2:10)';
%       y = mytrimf(x, [2 4 9]);
%       plot(x,y,'k-'); axis([min(x), max(x), -0.1, 1.1]);
%

if length(parms)<3
   error('Three parameters are requested');
end;

a = parms(1); b = parms(2); c = parms(3);

if a > b,
    error('Illegal parameter condition: a > b');
elseif b > c,
    error('Illegal parameter condition: b > c');
elseif a > c,
    error('Illegal parameter condition: a > c');
end

y = zeros(size(x));

% Left slope
if (a==-inf)
   index = find(x<=b);
   y(index) = 1;
elseif (a ~= b)
    index = find(a < x & x <= b);
    y(index) = (x(index)-a)/(b-a);
end

% right slope
if (c==inf)
   index = find(x>=b);
   y(index) = 1;
elseif (b ~= c)
    index = find(b < x & x < c);
    y(index) = (c-x(index))/(c-b);
end

% Center (y = 1)
index = find(x == b);
y(index) = ones(size(index));
