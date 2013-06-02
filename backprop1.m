clear all;
close all;

%prepare input data
x = 0;
i=1;
train_inp = [];

while x<=1
   x1 = rand(1)*2*pi;
   train_inp(i,1) = x1;
   train_inp(i,2) = 1;
   i = i+1;
   x = x+0.01;
end;

train_out=n_fun1(train_inp(:,1));

maxiter = 1000;%max. no. of iterations
small = 0.05;
eta = 0.95;		% learning rate
h = 2;			% #hidden units

%set initial random weights
weight_input_hidden = (randn(size(train_inp,2),h) - 0.1)/10;
weight_hidden_output = (randn(1,h) - 0.1)/10;

alr = eta;
blr = eta/10;

for i=1:maxiter

    for patnum=1:2

         %set the current pattern
        this_pat = train_inp(patnum,:);
        act = train_out(patnum,1);
        
        %calculate the current error for this pattern
        hval = (tanh(this_pat*weight_input_hidden))';
        pred = hval'*weight_hidden_output';
        error = pred - act;

        % adjust weight hidden - output
        delta_HO = error.*blr .*hval;
        weight_hidden_output = weight_hidden_output - delta_HO';

        % adjust the weights input - hidden
        delta_IH= alr.*error.*weight_hidden_output'.*(1-(hval.^2))*this_pat;
        weight_input_hidden = weight_input_hidden - delta_IH';

    end

    pred = weight_hidden_output*tanh(train_inp*weight_input_hidden)';
    error = pred' - train_out;
    err(i) =  (sum(error.^2))^0.5;
   
    figure(1);
    plot(err);
 
end

i = 1;
test_inp = [];
x = 0;

for i = 1:length(train_inp)
   x1 = rand(1)*2*pi;
   test_inp(i,1) = x1;
   test_inp(i,2) = 1;
   i = i+1;
end;

alr = eta;
blr = eta/10;

for i=1:maxiter
    pred = weight_hidden_output*tanh(test_inp*weight_input_hidden)';
    error = pred' - test_inp(:,1);
    err(i) =  (sum(error.^2))^0.5;
    figure(2);
    plot(pred);
end;

