function [ M ] = MacierzMasowa( Bezwlad, LE )

M = zeros(3*LE);

for i=1:LE
    M(3*i-2, 3*i-2) = Bezwlad(i).m;
    M(3*i-1, 3*i-1) = Bezwlad(i).m;
    M(3*i, 3*i) = Bezwlad(i).Iz;
end

end

