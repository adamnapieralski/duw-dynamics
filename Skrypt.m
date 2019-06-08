% Skrypt rozwi¹zuj¹cy zadanie

% 1. Pusta struktura do przechowywania wiêzów w postaci ogónej
 Wiezy = struct('typ',{},... % dopisanych czy kinematyczny - k/d
   'klasa',{},... % para postepowa czy obrotowa p/o
   'bodyi',{},... % numer pierwszego ciala
   'bodyj',{},... % numer drugiego ciala
   'sA',{},... % wektor sA w itym ukladzie
   'sB',{},... % wektor sB w jotym ukladzie
   'phi0',{},... % kat phi0 (nie u¿ywane dla pary obrotowej)
   'pros',{},... % wersor prostopadly do osi ruchu w ukladzie jotym (nie u¿ywane dla pary obrotowej)
   'foc',{},... % funkcja od czasu dla wiezow dopisanych
   'dfoc',{},... % pochodna funkcji od czasu dla wiezow dopisanych
   'ddfoc',{}) % druga pochodna funkcji od czasu dla wiezow dopisanych

% 2. Pusta struktura do przechowywania mas i momentu bezwladnosci elementow
Bezwlad = struct('m',{},... % masa cz³onu 
    'Iz',{}) % moment bezw³adnoœci cz³onu wzglêdem osi z 

% 3. Pusta struktura do przechowywania informacji o elementach
% sprezysto-tlumiacych
Sprez_tlum = struct('k',{},... % sztywnosc sprezyny
    'c',{},... % tlumienie w sprezynie
    'bodyi',{},... % numer pierwszego ciala przylozenia sprezyny
    'bodyj',{},... % numer drugiego ciala przylozenia sprezyny
    'sA',{},... % punkt przylozenia sprezyny do ciala i w i-tym ukladzie lokalnym
    'sB',{},... % punkt przylozenia sprezyny do ciala j w j-tym ukladzie lokalnym
    'd0',{}) % dlugosc swobodna sprezyny

% 4. Pusta struktura do przechowywania sil zewnetrznych dzialajacych na
% mechanizm
Sily = struct('F',{},... % wektor przylozonej sily
    'bodyi',{},... % numer ciala, do ktorego przylozono sile
    'sA',{}) % punkt przylozenia sily do ciala i w i-tym ukladzie lokalnym

% Wczytanie danych dotyczn¹cych wiêzów odpowiednich dla danego mechanizmu
Dane;
% Inicjalizacja zmiennej do wyznaczania liczby równañ wiêzów 
rows = 0;

wspolrzedne;

lparko=0;

for k=1:length(Wiezy)
    if(lower(Wiezy(k).typ(1)) == 'd')
        if(lower(Wiezy(k).klasa(1)) == 'o')
            rows = rows + 1;
        elseif(lower(Wiezy(k).klasa(1)) == 'p')
            rows = rows + 1;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(k)]);
        end
    elseif(lower(Wiezy(k).typ(1)) == 'k')
        if(lower(Wiezy(k).klasa(1)) == 'o')
            rows = rows + 2;
            lparko=lparko+1;
        elseif(lower(Wiezy(k).klasa(1)) == 'p')
            rows = rows + 2;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(k)]);
        end
    else
        error(['Blad w danej "typ" dla wiezu nr ', num2str(k)]);
    end
end


%% Ca³kowanie przy pomocy metody Rungego-Kutty rzêdu 4-5
% Paramtery czasu ca³kowania
tstart = 0;
tstop = 5;
timestep = 0.01; 
timespan = tstart:timestep:tstop;

M = MacierzMasowa(Bezwlad, LE);

q0 = [c(:,1); c(:,2); c(:,3); c(:,4); c(:,5); c(:,6); c(:,7); c(:,8); c(:,9); c(:,10)]; %poczatkowe polozenia 
dq0 = zeros(size(q0)); % Pocz¹tkowe prêdkoœci
Y0 = [q0; dq0]; % Wektor do ca³kowania


OPTIONS = odeset('RelTol', 1e-6, 'AbsTol', 1e-9);
[T,Y]=ode45(@(t,Y) RHS(t, Y, Wiezy, rows, M, LE, Bezwlad, LST, Sprez_tlum,...
    LS, Sily), timespan, Y0, OPTIONS);
    % Poniewa¿ macierz bezw³adnoœci nie zmienia siê w czasie, wiêc aby nie
    % obliczaæ jej za ka¿dym razem od nowa, jest po prostu przekazywana
    % jako argument funkcji ca³kowanej

Y = Y';  % Y=[q, dq]  
    
timepoints = 1:( length(T) );
dY = zeros(size(Y));
for iter=timepoints
	dY(:,iter) = RHS( T(iter), Y(:,iter), Wiezy, rows, M, LE, Bezwlad,...
        LST, Sprez_tlum, LS, Sily );
end      % dY=[dq, ddq]

calc_done = 1;  %przekazuje informacje o tym, ze obliczenia zostaly wykonane
                %tak, by móc odpaliæ DowolnyPunkt


%% PAUSE
%Porz¹dkowanie danych wyjœciowych
%Wektor po³o¿eñ:
Q = [ Y( 1:3*LE , : )];
%Wektor predkosci
DQ = [ Y( 3*LE+1:6*LE , : )];
%Wektor przyspieszen
DDQ = [ dY( 3*LE+1:6*LE , : )];

%LVADowolnyPunkt( 1, 1, 4, [0;0], Q, DQ, DDQ, calc_done, T, timespan )%% Zadanie po³o¿enia punktu, którego po³o¿enie bêdzie obliczane

%DowolnyPunkt( plot_type, wspolrzedna, body, wektor, srodek, calc_done, Q, DQ, DDQ, ZakresCzasu )

%plot_type: 1-polozenie, 2-predkosc, 3-polozenie
%wspolrzedna: 1-x, 2-y
%body: numer ciala na ktorym lezy zadany punkt
%wektor: wektor wodzacy punktu w ukladzie globlnym (A,B,C itp)
%srodek: wspolrzedne srodka masy danego ciala  (c1, c2, c3 itp)

%%DowolnyPunkt( 1, 1, 4, [1.55, -0.35]', c4, calc_done, Q, DQ, DDQ, T, timespan)
 

%%RysujObrot( plot_type, body, Q, DQ, D2Q, calc_done, T, timespan )
    %body = 4; % Numer cz³onu

    % plot_type = 1 - po³o¿enia
    % plot_type = 2 - prêdkoœci
    % plot_type = 3 - przyœpieszenia
%RysujObrot( 2, 1, Q, DQ, DDQ, calc_done, T, timespan )