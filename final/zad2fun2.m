clear all;
close all;

x = 0;
i=1;
wejscie_trenujace = [];
wyjscie_trenujace = [];

%wWypełnianie macierzy danymi losowymi
while x<=1
   x1 = rand();
   wejscie_trenujace(i,1) = x1;
   wejscie_trenujace(i,2) = 1;
   i = i+1;
   x = x+0.01;
end;

wejscie_trenujace = sortrows(wejscie_trenujace, 1);
wyjscie_trenujace=n_fun2(wejscie_trenujace(:,1));

rozm_trenujacy = size(wejscie_trenujace,1);
rozm_iter = 1000;
small = 0.01;
%Zakres uczący
eta = 0.05;
%Ukryte jednostki
h = 50;

%Wagi początkowe (do warstwy ukrytej)
wagi_wejscia = (rand(2,h) - 0.5)/10;
wagi_wyjscia = (rand(1,h) - 0.5)/10;

alr = eta;
blr = eta/10;

for i=1:rozm_iter

    for patnum=1:rozm_trenujacy

        %Dane ze zbioru uczącego dla aktualnego wzorca
        this_pat = wejscie_trenujace(patnum,:);
        act = wyjscie_trenujace(patnum,1);
        
        %Błąd dla danych ze zbioru uczącego
        hval = (tanh(this_pat*wagi_wejscia))';
        pred = hval'*wagi_wyjscia';
	wejscie_trenujace(patnum,2) = pred;
        error = pred - act;

        %Ukryte wagi dla wyjścia
        delta_HO = error.*small .*hval;
        wagi_wyjscia = wagi_wyjscia - delta_HO';

        %Ukryte wagi dla wejścia
        delta_IH= eta.*error.*wagi_wyjscia'.*(1-(hval.^2))*this_pat;
        wagi_wejscia = wagi_wejscia - delta_IH';

    end

    %Suma błędów
    pred = wagi_wyjscia*tanh(wejscie_trenujace*wagi_wejscia)';
    wejscie_trenujace(:,2) = pred;
    error = pred' - wyjscie_trenujace;
    err(i) =  (sum(error.^2))^0.5;
    figure(1);
    plot(err);
end

figure(2); 
plot(err/length(wyjscie_trenujace));

figure(3);
plot(wejscie_trenujace(:,1));
plot(wejscie_trenujace(:,2));
plot(wyjscie_trenujace);

%Część dla zbioru testującego

i = 1;
wejscie_testowe = [];
x = 0;

for i = 1:length(wejscie_trenujace)
   x1 = rand(1);
   wejscie_testowe(i,1) = x1;
   wejscie_testowe(i,2) = 1;
   i = i+1;
end;

test_out = fun2(wejscie_testowe(:,1));

pred = wagi_wyjscia*tanh(wejscie_testowe*wagi_wejscia)';
for i=1:rozm_iter
    error = pred' - wejscie_testowe(:,1);
    err(i) = (sum(error.^2))^0.5;
end;

figure(4); 
plot(wejscie_testowe(:,1));

