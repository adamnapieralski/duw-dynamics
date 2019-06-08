function [] = DowolnyPunkt( plot_type, wspolrzedna, body, wektor, Q, DQ, DDQ, T, zakres )
%% Zadanie po³o¿enia punktu, którego po³o¿enie bêdzie obliczane

%plot_type: 0-nic, 1-polozenie, 2-predkosc, 3-polozenie
%wspolrzedna: 1-x, 2-y
%body: numer ciala na ktorym lezy zadany punkt
%wektor: wektor wodzacy punktu w ukladzie lokalnym dla body
%T: tablica z dyskretnym przedzia³em czasu

    
    %% Obliczenia

    for time=1:length(T)

    %IIrK(1:2,time) = [(3*body-2,time);Y(3*body-1,time)]+RotMat(Y(3*body,time))*wektor;
    IIrK(1:2,time) = [Q(3*body-2,time);Q(3*body-1,time)]+RotMat(Q(3*body,time))*wektor;

    IIrdotK(1:2,time) = [DQ(3*body-2,time);DQ(3*body-1,time)] + Omega()*RotMat(Q(3*body,time))*wektor*DQ(12,time);

    IIrddotK(1:2,time) = [DDQ(3*body-2,time);DDQ(3*body-1,time)] - RotMat(Q(3*body,time))*wektor*DQ(3*body,time)*DQ(3*body,time)...
        + Omega()*RotMat(Q(3*body,time))*wektor*DDQ(3*body,time);
    end

    %% Rysowanie wykresów 
    if( plot_type == 3 )
        if ( wspolrzedna == 1 )        
            plot( zakres, IIrddotK( 1 , : )  );
        elseif( wspolrzedna == 2 )
            plot( zakres, IIrddotK( 2 , : )  );
        else
            error('Prosz? poda? poprawne zmienne wej?ciowe!');
        end
    elseif( plot_type == 2 )
        if ( wspolrzedna == 1 )        
            plot( zakres, IIrdotK( 1 , : )  );
        elseif( wspolrzedna == 2 )
            plot( zakres, IIrdotK( 2 , : )  );
        else
            error('Prosz? poda? poprawne zmienne wej?ciowe!');
        end
    elseif( plot_type == 1 )
        if ( wspolrzedna == 1 )        
            plot( zakres, IIrK( 1 , : )  );
        elseif( wspolrzedna == 2 )
            plot( zakres, IIrK( 2 , : )  );
        else
            error('Prosz? poda? poprawne zmienne wej?ciowe!');
        end
    else
        error('Prosz? poda? poprawne zmienne wej?ciowe!');
    end
end