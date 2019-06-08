function [ Q ] = SilyUogolnione( LE, Bezwlad, LST, Sprez_tlum, LS, Sily, q, dq )
%SILYUOGOLNIONE Funkcja zwracaj¹ca wektor si³ uogólnionych w zale¿noœci od
%aktualnej konfiguracji mechanizmu

% Czyszczenie wektora Q
    Q = zeros(3*LE,1);

% Si³y grawitacyjne

for i=1:LE
    Q(3*i-1, 1) = - Bezwlad(i).m * wspolgraw();
end

%Sily sprez-tlum

for iter=1:LST
    d = q_r(q, Sprez_tlum(iter).bodyj) - q_r(q, Sprez_tlum(iter).bodyi) + ...
        RotMat(q_phi(q, Sprez_tlum(iter).bodyj))*Sprez_tlum(iter).sB - ...
        RotMat(q_phi(q, Sprez_tlum(iter).bodyi))*Sprez_tlum(iter).sA;
    u = d/norm(d);
    
    Fk = Sprez_tlum(iter).k*(norm(d) - Sprez_tlum(iter).d0);
    Fc = Sprez_tlum(iter).c * u' * ( q_r(dq, Sprez_tlum(iter).bodyj) - q_r(dq, Sprez_tlum(iter).bodyi) + ...
        Omega() * RotMat(q_phi(q, Sprez_tlum(iter).bodyj)) * Sprez_tlum(iter).sB * q_phi(dq, Sprez_tlum(iter).bodyj) - ...
        Omega() * RotMat(q_phi(q, Sprez_tlum(iter).bodyi)) * Sprez_tlum(iter).sA * q_phi(dq, Sprez_tlum(iter).bodyi) );
    
    if(Sprez_tlum(iter).bodyi>0)
        Q((3*Sprez_tlum(iter).bodyi-2):(3*Sprez_tlum(iter).bodyi),1) = ...
            Q((3*Sprez_tlum(iter).bodyi-2):(3*Sprez_tlum(iter).bodyi),1) + ...
            [1, 0; 0, 1; ...
            (Omega() * RotMat(q_phi(q, Sprez_tlum(iter).bodyi)) * Sprez_tlum(iter).sA)'] * ...
            u * (Fc+Fk);
    end
    if(Sprez_tlum(iter).bodyj>0)
        Q((3*Sprez_tlum(iter).bodyj-2):(3*Sprez_tlum(iter).bodyj),1) = ...
            Q((3*Sprez_tlum(iter).bodyj-2):(3*Sprez_tlum(iter).bodyj),1) + ...
            [1, 0; 0, 1; ...
            (Omega() * RotMat(q_phi(q, Sprez_tlum(iter).bodyj)) * Sprez_tlum(iter).sB)'] * ...
            (-u) * (Fc+Fk);
    end
end


% Sily zewnetrzne

for i=1:LS
    if(Sily(i).bodyi>0)
        Q((3*Sily(i).bodyi-2):(3*Sily(i).bodyi), 1) = ...
            Q((3*Sily(i).bodyi-2):(3*Sily(i).bodyi), 1) + ...
            [1, 0; 0, 1; ...
            (Omega() * RotMat(q_phi(q, Sily(i).bodyi)) * Sily(i).sA)'] * ...
            Sily(i).F;
    end
end

end
