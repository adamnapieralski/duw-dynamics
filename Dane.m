% Wiezy = struct(typ, klasa, cialoi, cialoj, sA, sB, phi0, pros, foc, dfoc, ddfoc)
%     'typ',{},... % dopisanych czy kinematyczny - k/d
%     'klasa',{},... % para postepowa czy obrotowa p/o
%      numery cia³ - 1 fiolet, 2 pomarancz, 3 szary, 4 niebieski, 5
%      ³¹cznik, 6 si³ownik N, 7 si³ownk M, 8 si³ownik H, 9 si³ownik G
%     'bodyi',{},... % numer pierwszego ciala
%     'bodyj',{},... % numer drugiego ciala
%     'sA',{},... % wektor sA w i-tym ukladzie
%     'sB',{},... % wektor sB w j-tym ukladzie
%     'phi0',{},... % kat phi0 (nie dla pary obrotowej)
%     'pros',{},... % wersor prostopadly do osi ruchu w ukladzie jtym (nie dla pary obrotowej)
%     'foc',{},... % funkcja od czasu dla wiezow dopisanych
%     'dfoc',{},... % pochodna funkcji od czasu dla wiezow dopisanych
%     'ddfoc',{}) % druga pochodna funkcji od czasu dla wiezow dopisanych

wspolrzedne; 

% Wektory sA i sB wyliczone na podstawie powyzszych punktow

sA0O=[O(1);O(2)]; sB2O=[O(1)-c(1,2);O(2)-c(2,2)];  % Para obrotowa 0-2 ziel-pom
sA2P=[P(1)-c(1,2);P(2)-c(2,2)]; sB1P=[P(1)-c(1,1);P(2)-c(2,1)];  % Para obrotowa 1-2 fiol-pom
sA2F=[F(1)-c(1,2);F(2)-c(2,2)]; sB3F=[F(1)-c(1,3);F(2)-c(2,3)];  % Para obrotowa 2-3 pom-szar
sA2G=[G(1)-c(1,2);G(2)-c(2,2)]; sB9G=[G(1)-c(1,9);G(2)-c(2,9)];  % Para obrotowa 2-9 pom-silownik_2G
sA3E=[E(1)-c(1,3);E(2)-c(2,3)]; sB10E=[E(1)-c(1,10);E(2)-c(2,10)];  % Para obrotowa 3-10 bia³o-szare
sA3C=[C(1)-c(1,3);C(2)-c(2,3)]; sB5C=[C(1)-c(1,5);C(2)-c(2,5)];  % Para obrotowa 3-5 szary z desk¹
sA1D=[D(1)-c(1,1);D(2)-c(2,1)]; sB10D=[D(1)-c(1,10);D(2)-c(2,10)];  % Para obrotowa 1-10 fiol-bial
sA10M=[M(1)-c(1,10);M(2)-c(2,10)]; sB7M=[M(1)-c(1,7);M(2)-c(2,7)];  % Para obrotowa 10-7 bial-silownik_1M
sA0N=[N(1)-0.0;N(2)-0.0]; sB6N=[N(1)-c(1,6);N(2)-c(2,6)];  % Para obrotowa 0-6 ziel-silownik_1N
sA0H=[H(1)-0.0;H(2)-0.0]; sB8H=[H(1)-c(1,8);H(2)-c(2,8)];  % Para obrotowa 0-8 ziel-silownik_2H
sA1A=[A(1)-c(1,1);A(2)-c(2,1)]; sB4A=[A(1)-c(1,4);A(2)-c(2,4)];  % Para obrotowa 1-4 fiol-nieb
sA4B=[B(1)-c(1,4);B(2)-c(2,4)]; sB5B=[B(1)-c(1,5);B(2)-c(2,5)];  % Para obrotowa 5-4 niebieski-deska

%daneobrot=[sA0O' sB2O';sA2P' sB1P';sA2F' sB3F';sA2G' sB9G';sA3E' sB10E';sA3C' sB5C';sA1D' sB10D'; sA10M' sB7M'; sA0N' sB6N'; sA0H' sB8H';
 %   sA1A' sB4A';sA4B' sB5B'];

Wiezy(1) = cell2struct(...
    {'kinematyczny', 'obrotowy', 0, 2,  sA0O, sB2O, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt O
Wiezy(2) = cell2struct(...
    {'kinematyczny', 'obrotowy', 2, 1,  sA2P, sB1P, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt P
Wiezy(3) = cell2struct(...
    {'kinematyczny', 'obrotowy', 2, 3,  sA2F, sB3F, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt F
Wiezy(4) = cell2struct(...
    {'kinematyczny', 'obrotowy', 2, 9,  sA2G, sB9G, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt G
Wiezy(5) = cell2struct(...
    {'kinematyczny', 'obrotowy', 3, 10,  sA3E, sB10E, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt E
Wiezy(6) = cell2struct(...
    {'kinematyczny', 'obrotowy', 3, 5,  sA3C, sB5C, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt C
Wiezy(7) = cell2struct(...
    {'kinematyczny', 'obrotowy', 1, 10,  sA1D, sB10D, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt D
Wiezy(8) = cell2struct(...
    {'kinematyczny', 'obrotowy', 10, 7,  sA10M, sB7M, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt M
Wiezy(9) = cell2struct(...
    {'kinematyczny', 'obrotowy', 0, 6,  sA0N, sB6N, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt N
Wiezy(10) = cell2struct(...
    {'kinematyczny', 'obrotowy', 0, 8,  sA0H, sB8H, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt H
Wiezy(11) = cell2struct(...
    {'kinematyczny', 'obrotowy', 1, 4,  sA1A, sB4A, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt A
Wiezy(12) = cell2struct(...
    {'kinematyczny', 'obrotowy', 4, 5,  sA4B, sB5B, [], [], [], [], []}', ...
    fieldnames(Wiezy)); % Punkt B
Wiezy(13) = cell2struct(...
    {'kinematyczny', 'postepowy', 6, 7,  [-0.2; -0.05], [0.2; 0.05], 0, [-1;4]/sqrt(17), [], [], []}', ...
    fieldnames(Wiezy)); % Silownik 1 - MN
Wiezy(14) = cell2struct(...
    {'kinematyczny', 'postepowy', 8, 9,  [-0.05; -0.25], [0.05; 0.25], 0, [-5;1]/sqrt(26), [], [], []}', ...
    fieldnames(Wiezy)); % Silownik 2 - GH


theta = 315;
P1 = 500;

%% Szablony struktur
% Bezwlad = struct('m',{},... % masa cz³onu 
%     'Iz',{}); % moment bezw³adnoœci cz³onu wzglêdem osi z 

% Sprez_tlum = struct('k',{},... % sztywnosc sprezyny
%     'c',{},... % tlumienie w sprezynie
%     'bodyi',{},... % numer pierwszego ciala przylozenia sprezyny
%     'bodyj',{},... % numer drugiego ciala przylozenia sprezyny
%     'sA',{},... % punkt przylozenia sprezyny do ciala i w i-tym ukladzie lokalnym
%     'sB',{},... % punkt przylozenia sprezyny do ciala j w j-tym ukladzie lokalnym
%     'd0',{}) % dlugosc swobodna sprezyny

% Sily = struct('F',{},... % wektor przylozonej sily
%     'bodyi',{},... % numer ciala, do ktorego przylozono sile
%     'sA',{}) % punkt przylozenia sily do ciala i w i-tym ukladzie lokalnym

%% Masy i momenty bezw³adnoœci elementow mechanizmu

LE = 10; % Liczba elementow mechanizmu

Bezwlad(1) = cell2struct({36, 8}', fieldnames(Bezwlad)); % cz³on 1
Bezwlad(2) = cell2struct({14.5, 0.5}', fieldnames(Bezwlad)); % cz³on 2
Bezwlad(3) = cell2struct({14, 0.9}', fieldnames(Bezwlad)); % cz³on 3
Bezwlad(4) = cell2struct({18, 1}', fieldnames(Bezwlad)); % cz³on 4
Bezwlad(5) = cell2struct({2.7, 0.2}', fieldnames(Bezwlad)); % cz³on 5
Bezwlad(6) = cell2struct({0.3, 0.1}', fieldnames(Bezwlad)); % cz³on 6
Bezwlad(7) = cell2struct({0.3, 0.1}', fieldnames(Bezwlad)); % cz³on 7
Bezwlad(8) = cell2struct({0.6, 0.1}', fieldnames(Bezwlad)); % cz³on 8
Bezwlad(9) = cell2struct({0.6, 0.1}', fieldnames(Bezwlad)); % cz³on 9
Bezwlad(10) = cell2struct({7, 0.2}', fieldnames(Bezwlad)); % cz³on 10


%% Elementy sprezysto-tlumiace

LST = 2; % Liczba elementow sprezysto-tlumiacych

Sprez_tlum(1) = cell2struct({3e5, 3e3, 6, 7, [0.6; 0.15], [-0.6; -0.15], sqrt(0.68)}', fieldnames(Sprez_tlum)); % element 1
Sprez_tlum(2) = cell2struct({1e5, 1e3, 8, 9, [0.15; 0.75], [-0.15; -0.75], sqrt(1.04)}', fieldnames(Sprez_tlum)); % element 2


%% Si³y zewnetrzne dzialajace na mechanizm

LS = 1; % Liczba sil

Sily(1) = cell2struct({[500*cosd(theta); 500*sind(theta)], 4, [0.35; -0.15]}', fieldnames(Sily)); % jedyna sila
