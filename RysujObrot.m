function [] = RysujObrot( plot_type, body, Q, DQ, D2Q, T, timespan )%% Zadanie po�o�enia punktu, kt�rego po�o�enie b�dzie obliczane
    %body = 4; % Numer cz�onu

    % plot_type = 1 - po�o�enia
    % plot_type = 2 - pr�dko�ci
    % plot_type = 3 - przy�pieszenia


    %% Obliczenia
    for time=1:length(T)

    %IIrK(1:2,time) = [(3*body-2,time);Y(3*body-1,time)]+RotMat(Y(3*body,time))*rKloc;
    IIrK(1,time) = Q(3*body,time);

    IIrdotK(1,time) = DQ(3*body,time);

    IIrddotK(1,time) = D2Q(3*body,time);
    end

    %% Rysowanie wykres�w 
    if( plot_type == 3 )     
            plot( timespan, IIrddotK)
    elseif( plot_type == 2 )       
            plot( timespan, IIrdotK)
    elseif( plot_type == 1 )       
            plot( timespan, IIrK)
    else
        error('Prosz? poda? poprawne zmienne wej?ciowe!');
    end
end