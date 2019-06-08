function [ Phi ] = WektorPhi( q, t, Wiezy, rows )
% Wektor rownan wiezow

m = 1; % aktualny numer wiersza macierzy Jacobiego, ktory uzupelniamy 

wspolrzedne; 
Phi = zeros(rows, 1);
    
for k=1:length(Wiezy)
    % wiezy dopisane
    if(lower(Wiezy(k).typ(1)) == 'd')
        if(lower(Wiezy(k).klasa(1)) == 'o')
            Phi(m, 1) = q_phi(q, Wiezy(k).bodyi) - q_phi(q, Wiezy(k).bodyj) - ...
                eval(Wiezy(k).foc);
            m = m+1;
        elseif(lower(Wiezy(k).klasa(1)) == 'p')
            Phi(m,1) = (RotMat(q_phi(q, Wiezy(k).bodyj)) * Wiezy(k).pros)' *...
                ( q_r(q, Wiezy(k).bodyj) - q_r(q, Wiezy(k).bodyi) - ...
                RotMat(q_phi(q, Wiezy(k).bodyi)) * Wiezy(k).sA ) + ...
                (Wiezy(k).pros)'*Wiezy(k).sB - eval(Wiezy(k).foc);
            m = m+1;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(k)]);
        end
        % wiezy kienmatyczne
    elseif(lower(Wiezy(k).typ(1)) == 'k')
        if(lower(Wiezy(k).klasa(1)) == 'o')
            Phi(m:(m+1), 1) = q_r(q, Wiezy(k).bodyi) - q_r(q, Wiezy(k).bodyj) + ...
                RotMat(q_phi(q, Wiezy(k).bodyi)) * Wiezy(k).sA - ...
                RotMat(q_phi(q, Wiezy(k).bodyj)) * Wiezy(k).sB;
            m = m+2;
        elseif(lower(Wiezy(k).klasa(1)) == 'p')
            Phi(m, 1) = q_phi(q, Wiezy(k).bodyi) - q_phi(q, Wiezy(k).bodyj) - ...
                Wiezy(k).phi0;
            m = m+1;
            Phi(m,1) = (RotMat(q_phi(q, Wiezy(k).bodyj)) * Wiezy(k).pros)'*...
                ( q_r(q, Wiezy(k).bodyj) - q_r(q, Wiezy(k).bodyi) - ...
                RotMat(q_phi(q, Wiezy(k).bodyi)) * Wiezy(k).sA ) + ...
                (Wiezy(k).pros)' * Wiezy(k).sB;
            m = m+1;
        else
            error(['Blad w danej "klasa" dla wiezu nr ', num2str(k)]);
        end
    else
        error(['Blad w danej "typ" dla wiezu nr ', num2str(k)]);
    end
end


end

