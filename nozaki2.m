%
% Example 1 from Nozaki et al. (1997)
% "A simple but powerful heuristic method for generating
%  fuzzy rules from numerical data"
% Fuzzy Sets and Systems 86 (1997) 251-270
%/
clear all;
close all;

%prepare input data
x = 0;
i=1;
data = [];
while x<=1
   data(i,1) = x;
   data(i,2) = n_fun2(x);
   i = i+1;
   x = x+0.1;
end;

rand_data = [];  
        for i = 1:100  
            rand_data(i) =rand(1)*2*pi;  
        end;
disp(rand_data);      

% identify rules
K=10;
%load fuzzy premises
labels = load('labels5_2.txt');

figure,
x = 0:0.01:1;
for i=1:length(labels)
   plot(x,mytrimf(x,labels(i,:)),'k-','LineWidth',2); hold on; grid on;
end;
axis([min(x), max(x), -0.1, 1.1]);

% identify consequents
b = zeros(length(labels),1);
for i = 1:length(labels)
   numerator = 0;
   denumerator = 0;
   for j = 1:length(data)
      w = (mytrimf(data(j,1), labels(i,:)))^K;
      numerator = numerator + w * data(j,2);
      denumerator = denumerator + w;
   end;
   b(i) = numerator/denumerator;
end;

% error of approximmation to input data
err = [];
for j = 1:length(data)
   numerator = 0;
   denumerator = 0;
   for i = 1:length(labels)
      w = (mytrimf(data(j,1), labels(i,:)));%^K;
      numerator = numerator + w * b(i);
      denumerator = denumerator + w;
   end;
   y(j) = numerator/denumerator;
   err = [err (y(j) - data(j,2))^2];
end;
err = mean(err)

figure
z = 0:0.01:1;
plot(z, n_fun2(z),'b-'); hold on;
plot(data(:,1), data(:,2), 'b*'); hold on;
plot(data(:,1), y, 'r*-'); grid on;

% error of approximmation to complete data
err=[];
z = 0;
h = 0.01;
j = 1;
zz=[];
while z <= 1
   numerator = 0;
   denumerator = 0;
   for i = 1:length(labels)
      w = (mytrimf(z, labels(i,:)));%^K;
      numerator = numerator + w*b(i);
      denumerator = denumerator + w;
   end;
   y(j) = numerator/denumerator;
   err = [err (y(j) - n_fun2(z))^2];
   j = j+1;
   z = z+h;
end;
err = mean(err)

figure
plot(x, n_fun2(x),'b-'); hold on;
plot(data(:,1), data(:,2), 'b*'); hold on;
z = 0:h:(1-h);
plot(z, y, 'r.-'); grid on;

