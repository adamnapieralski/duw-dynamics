function [T,Q,DQ,DDQ]=Mechanizm(Wiezy, rows)

% Rozwi¹zanie zadania kinematyki o po³o¿eniu, prêdkoœci i przyspieszeniu 
%   dla mechanizmu opisanego w zadaniu
% Wyjœcie:
%   T   - tablica do zapisu kolejnych chwil.
%   Q   - tablica do zapisu rozwi¹zañ zadania o po³o¿eniu w kolejnych chwilach.
%   DQ  - tablica do zapisu rozwi¹zañ zadania o prêdkoœci w kolejnych chwilach.
%   DDQ - tablica do zapisu rozwi¹zañ zad. o przyspieszeniu w kolejnych chwilach.
% Przybli¿enie startowe (gdy brak rozwi¹zania z poprzedniej chwili)

wspolrzedne; % zaladowanie wspolrzednych charakterystycznych

q = [c1; c2; c3; c4; c5; c6; c7; c8; c9; c10];   
    
qdot=zeros(size(q));
qddot=zeros(size(q));

lroz=0; % Licznik rozwi¹zañ (s³u¿y do numerowania kolumn w tablicach z wynikami)
dt=0.01; % Odstep czasowy miedzy mierzonymi punktami

ZakresCzasu = 0:dt:1.5;
Q = zeros(size(q,1), length(ZakresCzasu));
DQ = zeros(size(Q));
DDQ = zeros(size(Q));
T = zeros(size(Q));

% Rozwi¹zywanie zadañ kinematyki w kolejnych chwilach t
for t=ZakresCzasu
    % Zadanie o po³o¿eniu. 
    %  rozwi¹zanie z poprzedniej chwili jest przybli¿eniem pocz¹tkowym w chwili kolejnej, 
    % powiêkszone o sk³adniki wynikaj¹ce z obliczonej prêdkoœci i przyspieszenia (na podstawie szeregu Taylora?).
    q0=q+qdot*dt+0.5*qddot*dt*dt;
    q=NewRaph(q0,t,Wiezy,rows); 

    % Zadanie o predkosciach
    qdot=MacierzJacobiego(q,t,Wiezy,rows)\WektorPP(q,t,Wiezy,rows);  % Zadanie o prêdkoœci

    % Zadanie o przyspieszeniach
    qddot=MacierzJacobiego(q,t,Wiezy,rows)\Gamma(q,qdot,t,Wiezy,rows);  % Zadanie o przyspieszeniu

    % Zapis do tablic gromadz¹cych wyniki
    lroz; %Wyswietlana tylko do debugowania
    lroz=lroz+1;
    T(1,lroz)=t; 
    Q(:,lroz)=q;
    DQ(:,lroz)=qdot;
    DDQ(:,lroz)=qddot;
end