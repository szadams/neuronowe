%
% Zadanie 1 
%  Algortym generujący zbiór prostych reguł rozmytych
%	Funkcja 1
%	Interpretacja algorytmu od Nozaki
%/
clear all;
close all;

x = 0;
i=1;
dane_losowe = [];

%wWypełnianie macierzy danymi losowymi
while x<=1
   temp =  rand(1)*2*pi;
   dane_losowe(i,1) = temp;
   dane_losowe(i,2) = n_fun1(temp);
   i = i+1;
   x = x+0.01;
end;

dane_losowe = sortrows(dane_losowe, 1);

%Pobranie etykiet z zakresu dziedziny
%Identyfikacja prostych reguł rozmytych
K=10;
etykiety = load('labels5_2.txt');

figure,
x = 0:0.01:2*pi;
for i=1:length(etykiety)
   plot(x,mytrimf(x,etykiety(i,:)),'k-','LineWidth',2); hold on; grid on;
end;
axis([min(x), max(x), -0.1, 1.1]);

b = zeros(length(etykiety),1);

%Obliczanie numerycznej konkluzji
%Ważona suma obserwacji zmiennej zależnej
for i = 1:length(etykiety)
   licznik = 0;
   mianownik = 0;
   for j = 1:length(dane_losowe)
      w = (mytrimf(dane_losowe(j,1), etykiety(i,:)))^K;
      licznik = licznik + w * dane_losowe(j,2);
      mianownik = mianownik + w;
   end;
   b(i) = licznik/mianownik;
   if(isnan(b(i))) 
       b(i) = 0;   
   end;
end;

%Wskaźnik pokrycia danych wejsciowych
err = [];
for j = 1:length(dane_losowe)
   licznik = 0;
   mianownik = 0;
   for i = 1:length(etykiety)
      w = (mytrimf(dane_losowe(j,1), etykiety(i,:)));%^K;
      licznik = licznik + w * b(i);
      mianownik = mianownik + w;
   end;
   y(j) = licznik/mianownik;
   err = [err (y(j) - dane_losowe(j,2))^2];
end;
err = mean(err)

figure
z = 0:0.01:2*pi;
plot(z, n_fun1(z),'b-'); hold on;
plot(dane_losowe(:,1), dane_losowe(:,2), 'b*'); hold on;
plot(dane_losowe(:,1), y, 'r*-'); grid on;

%Wskaźnik pokrycia wartościami funkcji
err=[];
z = 0;
h = 0.01;
j = 1;
zz=[];
while z <= 2*pi
   licznik = 0;
   mianownik = 0;
   for i = 1:length(etykiety)
      w = (mytrimf(z, etykiety(i,:)));%^K;
      licznik = licznik + w*b(i);
      mianownik = mianownik + w;
   end;
   y(j) = licznik/mianownik;
   err = [err (y(j) - n_fun1(z))^2];
   j = j+1;
   z = z+h;
end;
err = mean(err)

figure
plot(x, n_fun1(x),'b-'); hold on;
plot(dane_losowe(:,1), dane_losowe(:,2), 'b*'); hold on;
z = 0:h:2*pi;
plot(z, y, 'r.-'); grid on;
