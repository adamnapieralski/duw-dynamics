function [ phi ] = q_phi( q, k )
% Funkcja zwracajaca wspolrzedna polozenia katowego ciala i-tego

if(k==0)
    phi = 0;
else
    phi = q(3*k);
end
end
