function [T,Q,DQ,DDQ]=Mechanizm(Wiezy, rows)

% Rozwiązanie zadania kinematyki o położeniu, prędkości i przyspieszeniu 
%   dla mechanizmu opisanego w zadaniu
% Wyjście:
%   T   - tablica do zapisu kolejnych chwil.
%   Q   - tablica do zapisu rozwiązań zadania o położeniu w kolejnych chwilach.
%   DQ  - tablica do zapisu rozwiązań zadania o prędkości w kolejnych chwilach.
%   DDQ - tablica do zapisu rozwiązań zad. o przyspieszeniu w kolejnych chwilach.
% Przybliżenie startowe (gdy brak rozwiązania z poprzedniej chwili)

wspolrzedne; % zaladowanie wspolrzednych charakterystycznych

q = [c1; c2; c3; c4; c5; c6; c7; c8; c9; c10];   
    
qdot=zeros(size(q));
qddot=zeros(size(q));

lroz=0; % Licznik rozwiązań (służy do numerowania kolumn w tablicach z wynikami)
dt=0.01; % Odstep czasowy miedzy mierzonymi punktami

ZakresCzasu = 0:dt:1.5;
Q = zeros(size(q,1), length(ZakresCzasu));
DQ = zeros(size(Q));
DDQ = zeros(size(Q));
T = zeros(size(Q));

% Rozwiązywanie zadań kinematyki w kolejnych chwilach t
for t=ZakresCzasu
    % Zadanie o położeniu. 
    %  rozwiązanie z poprzedniej chwili jest przybliżeniem początkowym w chwili kolejnej, 
    % powiększone o składniki wynikające z obliczonej prędkości i przyspieszenia (na podstawie szeregu Taylora?).
    q0=q+qdot*dt+0.5*qddot*dt*dt;
    q=NewRaph(q0,t,Wiezy,rows); 

    % Zadanie o predkosciach
    qdot=MacierzJacobiego(q,t,Wiezy,rows)\WektorPP(q,t,Wiezy,rows);  % Zadanie o prędkości

    % Zadanie o przyspieszeniach
    qddot=MacierzJacobiego(q,t,Wiezy,rows)\Gamma(q,qdot,t,Wiezy,rows);  % Zadanie o przyspieszeniu

    % Zapis do tablic gromadzących wyniki
    lroz; %Wyswietlana tylko do debugowania
    lroz=lroz+1;
    T(1,lroz)=t; 
    Q(:,lroz)=q;
    DQ(:,lroz)=qdot;
    DDQ(:,lroz)=qddot;
end