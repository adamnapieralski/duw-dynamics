function [ r ] = q_r( q, k )
% Funkcja zwracajaca wektor r dla ciala i-tego 

if(k==0)
    r = [0;0];
else
    r = [q(3*k-2); 
    q(3*k-1)];
end

end