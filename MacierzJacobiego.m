function [ MJacob ] = MacierzJacobiego( q, t, Wiezy, rows )
% Funkcja generujaca macierz Jacobiego mechanizmu

% Jako argumenty wejsciowe do funkcji przyjmujemy 
% aktualny wektor q oraz strukture Wiezy;
% zmienna row nalezy obliczyc jednorazowo wczesniej - na jej podstawie
% wyznaczamy liczbe wierszy macierzy Jacobiego, wynikajaca z rownan wiezow


m = 1; % aktualny numer wiersza macierzy Jacobiego, ktory uzupelniamy -
     

MJacob = zeros(rows, size(q,1));

for l=1:length(Wiezy)
    % Wiezy dopisane
    if(lower(Wiezy(l).typ(1)) == 'd')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            if(Wiezy(l).bodyi>0)
                MJacob(m, 3*Wiezy(l).bodyi) = 1;
            end
            if(Wiezy(l).bodyj>0)
                MJacob(m, 3*Wiezy(l).bodyj) = - 1;
            end
            m = m+1;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            tmp = (RotMat(q_phi(q, Wiezy(l).bodyj)) * Wiezy(l).pros )';
            if(Wiezy(l).bodyi>0)
                MJacob(m, (3*Wiezy(l).bodyi - 2):(3*Wiezy(l).bodyi - 1)) = - tmp;
                MJacob(m, 3*Wiezy(l).bodyi) = -tmp * Omega() * ...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA;
            end
            if(Wiezy(l).bodyj>0)
                MJacob(m, (3*Wiezy(l).bodyj - 2):(3*Wiezy(l).bodyj - 1)) = tmp;
                MJacob(m, 3*Wiezy(l).bodyj) = -tmp * Omega() * ...
                    (q_r(q, Wiezy(l).bodyj) - q_r(q, Wiezy(l).bodyi) - ...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA);
            end
            m = m+1;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(l)]);
        end
    % Wiezy kinematyczne
    elseif(lower(Wiezy(l).typ(1)) == 'k')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            if(Wiezy(l).bodyi>0)
                MJacob(m:(m+1), (3*Wiezy(l).bodyi - 2):(3*Wiezy(l).bodyi - 1)) = eye(2);
                MJacob(m:m+1, 3*Wiezy(l).bodyi) = Omega()*...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA;
            end
            if(Wiezy(l).bodyj>0)
                MJacob(m:m+1, (3*Wiezy(l).bodyj - 2):(3*Wiezy(l).bodyj - 1)) = -eye(2);
                MJacob(m:m+1, 3*Wiezy(l).bodyj) = - Omega()*...
                    RotMat(q_phi(q, Wiezy(l).bodyj))*Wiezy(l).sB;
            end
            m = m+2;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            if(Wiezy(l).bodyi>0)
              MJacob(m, 3*Wiezy(l).bodyi) = 1;
            end
            if(Wiezy(l).bodyj>0)
                MJacob(m, 3*Wiezy(l).bodyj) = - 1;
            end
            m = m+1;
            
            tmp = (RotMat(q_phi(q, Wiezy(l).bodyj)) * Wiezy(l).pros )';
            if(Wiezy(l).bodyi>0)
                MJacob(m, (3*Wiezy(l).bodyi - 2):(3*Wiezy(l).bodyi - 1)) = - tmp;
                MJacob(m, 3*Wiezy(l).bodyi) = -tmp * Omega() * ...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA;
            end
            if(Wiezy(l).bodyj>0)
                MJacob(m, (3*Wiezy(l).bodyj - 2):(3*Wiezy(l).bodyj - 1)) = tmp;
                MJacob(m, 3*Wiezy(l).bodyj) = -tmp * Omega() * ...
                    (q_r(q, Wiezy(l).bodyj) - q_r(q, Wiezy(l).bodyi) - ...
                    RotMat(q_phi(q, Wiezy(l).bodyi))*Wiezy(l).sA);
            end
            m = m+1;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(l)]);
        end
    else
        error(['Blad w danej "klasa" dla wiezu nr ', num2str(l)]);
    end
end

% Sprawdzenie osobliwosci macierzy Jacobiego
WspolczynnikUwarunkowania = cond(MJacob);
if (WspolczynnikUwarunkowania > (1/(1e-10)))
    error('Macierz Jacobiego osobliwa');
end


end
