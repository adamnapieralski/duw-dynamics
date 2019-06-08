function [T,Q,DQ,DDQ]=Mechanizm(Wiezy, rows)

% Rozwi�zanie zadania kinematyki o po�o�eniu, pr�dko�ci i przyspieszeniu 
%   dla mechanizmu opisanego w zadaniu
% Wyj�cie:
%   T   - tablica do zapisu kolejnych chwil.
%   Q   - tablica do zapisu rozwi�za� zadania o po�o�eniu w kolejnych chwilach.
%   DQ  - tablica do zapisu rozwi�za� zadania o pr�dko�ci w kolejnych chwilach.
%   DDQ - tablica do zapisu rozwi�za� zad. o przyspieszeniu w kolejnych chwilach.
% Przybli�enie startowe (gdy brak rozwi�zania z poprzedniej chwili)

wspolrzedne; % zaladowanie wspolrzednych charakterystycznych

q = [c1; c2; c3; c4; c5; c6; c7; c8; c9; c10];   
    
qdot=zeros(size(q));
qddot=zeros(size(q));

lroz=0; % Licznik rozwi�za� (s�u�y do numerowania kolumn w tablicach z wynikami)
dt=0.01; % Odstep czasowy miedzy mierzonymi punktami

ZakresCzasu = 0:dt:1.5;
Q = zeros(size(q,1), length(ZakresCzasu));
DQ = zeros(size(Q));
DDQ = zeros(size(Q));
T = zeros(size(Q));

% Rozwi�zywanie zada� kinematyki w kolejnych chwilach t
for t=ZakresCzasu
    % Zadanie o po�o�eniu. 
    %  rozwi�zanie z poprzedniej chwili jest przybli�eniem pocz�tkowym w chwili kolejnej, 
    % powi�kszone o sk�adniki wynikaj�ce z obliczonej pr�dko�ci i przyspieszenia (na podstawie szeregu Taylora?).
    q0=q+qdot*dt+0.5*qddot*dt*dt;
    q=NewRaph(q0,t,Wiezy,rows); 

    % Zadanie o predkosciach
    qdot=MacierzJacobiego(q,t,Wiezy,rows)\WektorPP(q,t,Wiezy,rows);  % Zadanie o pr�dko�ci

    % Zadanie o przyspieszeniach
    qddot=MacierzJacobiego(q,t,Wiezy,rows)\Gamma(q,qdot,t,Wiezy,rows);  % Zadanie o przyspieszeniu

    % Zapis do tablic gromadz�cych wyniki
    lroz; %Wyswietlana tylko do debugowania
    lroz=lroz+1;
    T(1,lroz)=t; 
    Q(:,lroz)=q;
    DQ(:,lroz)=qdot;
    DDQ(:,lroz)=qddot;
end