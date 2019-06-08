function q=NewRaph(q0,t, Wiezy, rows)

%   Rozwi¹zanie uk³adu równañ metod¹ Newtona-Raphsona.

q=q0;

F=WektorPhi(q,t, Wiezy, rows);
iter=1; % Licznik iteracji
while ( (norm(F)>(1e-10)) && (iter < 200) )
    F=WektorPhi(q,t, Wiezy, rows);
    Fq=MacierzJacobiego(q,t,Wiezy,rows);
    q=q-Fq\F;  % Fq\F jest równowa¿ne inv(Fq)*F, ale mniej kosztowne numerycznie
    iter=iter+1;
end
if iter >= 200
    disp('B£¥D: Po 200 iteracjach Newtona-Raphsona nie uzyskano zbie¿noœci ');
    norm(F)
    q=q0;
end

