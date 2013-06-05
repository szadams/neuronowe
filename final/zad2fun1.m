clear all;
close all;

x = 0;
i=1;
wejscie_trenujace = [];

%wWypełnianie macierzy danymi losowymi
while x<=1
   x1 = rand(1)*2*pi;
   wejscie_trenujace(i,1) = x1;
   wejscie_trenujace(i,2) = 1;
   i = i+1;
   x = x+0.01;
end;

wyjscie_trenujace=n_fun1(wejscie_trenujace(:,1));

rozm_iter = 1000;
small = 0.05;
%Zakres uczący
eta = 0.95;
%Ukryte jednostki
h = 2;	

%Wagi początkowe (do warstwy ukrytej)
wagi_wejscia = (randn(size(wejscie_trenujace,2),h) - 0.1)/10;
wagi_wyjscia = (randn(1,h) - 0.1)/10;

alr = eta;
blr = eta/10;

for i=1:rozm_iter

    for patnum=1:2

        %Dane ze zbioru uczącego dla aktualnego wzorca
        this_pat = wejscie_trenujace(patnum,:);
        act = wyjscie_trenujace(patnum,1);
        
        %Błąd dla danych ze zbioru uczącego
        hval = (tanh(this_pat*wagi_wejscia))';
        pred = hval'*wagi_wyjscia';
        error = pred - act;

        %Ukryte wagi dla wyjścia
        delta_HO = error.*blr .*hval;
        wagi_wyjscia = wagi_wyjscia - delta_HO';

        %Ukryte wagi dla wejścia
        delta_IH= alr.*error.*wagi_wyjscia'.*(1-(hval.^2))*this_pat;
        wagi_wejscia = wagi_wejscia - delta_IH';

    end

    %Suma błędów
    pred = wagi_wyjscia*tanh(wejscie_trenujace*wagi_wejscia)';
    error = pred' - wyjscie_trenujace;
    err(i) =  (sum(error.^2))^0.5;
   
    figure(1);
    plot(err);
 
end

%Część dla zbioru testującego

i = 1;
wejscie_testowe = [];
x = 0;

for i = 1:length(wejscie_trenujace)
   x1 = rand(1)*2*pi;
   wejscie_testowe(i,1) = x1;
   wejscie_testowe(i,2) = 1;
   i = i+1;
end;

pred = wagi_wyjscia*tanh(wejscie_testowe*wagi_wejscia)';
for i=1:rozm_iter
    error = pred' - wejscie_testowe(:,1);
    err(i) = (sum(error.^2))^0.5;
end;

figure(2);
plot(pred);
