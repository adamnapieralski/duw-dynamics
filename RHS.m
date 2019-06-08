function [dY] = RHS(t, Y, Wiezy, rows, M, LE, Bezwlad, LST, Sprez_tlum, LS, Sily)
%RHS Wektor prawych stron w równaniu liniowym dynamiki

alpha = 10;
beta = 10;

% Pierwsza po³owa wektora Y to po³o¿enia, druga po³owa to prêdkoœci
middle = uint16(length(Y)/2);

q = Y(1:middle,1);
dq = Y((middle+1):(2*middle),1);

% Odpowiednie macierze s¹ wyznaczane przez funkcje:
% Macierz masowa -> [ M ] = MacierzMasowa(Bezwlad, LE)
% Macierz Jacobiego -> [ Jacob ] = MacierzJacobiego(q, t, Wiezy, rows)
% Wektor si³ uogólnionych -> [ Q ] = SilyUogolnione(LE, Bezwlad, LST, Sprez_tlum, LS, Sily, q, dq)
% Wektor Gamma -> [ Gamma ] = Gamma(q, dq, t, Wiezy, rows)
% Wektor równan wiêzów -> [ Phi ] = WektorPhi(q, t, Wiezy, rows)

Fi = WektorPhi(q, t, Wiezy, rows);
dFi = MacierzJacobiego(q, t, Wiezy, rows)*dq;

Jacob = MacierzJacobiego(q, t, Wiezy, rows);
A = [M, Jacob'; Jacob, zeros(rows)];
b = [SilyUogolnione( LE, Bezwlad, LST, Sprez_tlum, LS, Sily, q, dq );...
    Gamma( q, dq, t, Wiezy, rows ) - 2*alpha*dFi - beta*beta*Fi]; 

x = A\b;

dY(1:middle,1) = dq;
dY((middle+1):(2*middle),1) = x(1:middle,1);

end

