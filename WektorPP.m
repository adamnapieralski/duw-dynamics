function [ Prawe ] = WektorPP( q, t, Wiezy, rows )
% Funkcja do wyznaczania prawych stron w rownaniu liniowym na predkosci qdot
% czyli minus (sic!) pochodna wektora wiezow po czasie

Prawe = zeros(rows, 1);
wspolrzedne;
m=1;

for l=1:length(Wiezy)
    % wiezy dopisane
    if(lower(Wiezy(l).typ(1)) == 'd')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            Prawe(m) = eval(Wiezy(l).dfoc);
            m=m+1;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            Prawe(m) = eval(Wiezy(l).dfoc);
            m=m+1;
        end
    end
    % wiezy kienmatyczne
    if(lower(Wiezy(l).typ(1)) == 'k')
        if(lower(Wiezy(l).klasa(1)) == 'o')
            m=m+2;
        elseif(lower(Wiezy(l).klasa(1)) == 'p')
            m=m+2;
        end
    end
end

end

