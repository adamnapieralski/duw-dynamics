function [] = Wykres(punkt, typ_wykresu, Q, DQ, DDQ, T, timespan)

    wspolrzedne;
    figure();
    Punkty = struct('punkt', {}, 'cialo', {}, 'wektor_lok', {});
    Punkty(1) = cell2struct({'O', 2, O - c(1:2,2)}', fieldnames(Punkty));
    Punkty(2) = cell2struct({'P', 2, P - c(1:2,2)}', fieldnames(Punkty));
    Punkty(3) = cell2struct({'N', 6, N - c(1:2,6)}', fieldnames(Punkty));
    Punkty(4) = cell2struct({'H', 8, H - c(1:2,8)}', fieldnames(Punkty));
    Punkty(5) = cell2struct({'F', 2, F - c(1:2,2)}', fieldnames(Punkty));
    Punkty(6) = cell2struct({'G', 2, G - c(1:2,2)}', fieldnames(Punkty));
    Punkty(7) = cell2struct({'M', 7, M - c(1:2,7)}', fieldnames(Punkty));
    Punkty(8) = cell2struct({'C', 1, C - c(1:2,1)}', fieldnames(Punkty));
    Punkty(9) = cell2struct({'E', 1, E - c(1:2,1)}', fieldnames(Punkty));
    Punkty(10) = cell2struct({'D', 10, D - c(1:2,10)}', fieldnames(Punkty));
    Punkty(11) = cell2struct({'B', 4, B - c(1:2,4)}', fieldnames(Punkty));
    Punkty(12) = cell2struct({'A', 4, A - c(1:2,4)}', fieldnames(Punkty));
    Punkty(13) = cell2struct({'K', 4, K - c(1:2,4)}', fieldnames(Punkty));

    
    if isnumeric(punkt)
        switch typ_wykresu
            case 'x'
                DowolnyPunkt(1, 1, punkt, [0,0]', Q, DQ, DDQ, T, timespan)
            case 'y'
                DowolnyPunkt(1, 2, punkt, [0,0]', Q, DQ, DDQ, T, timespan)
            case 'fi'
                RysujObrot(1, punkt,  Q, DQ, DDQ, T, timespan)
            case 'dx'
                DowolnyPunkt(2, 1, punkt, [0,0]', Q, DQ, DDQ, T, timespan)
            case 'dy'
                DowolnyPunkt(2, 2, punkt, [0,0]', Q, DQ, DDQ, T, timespan)
            case 'dfi'
                RysujObrot(2, punkt,  Q, DQ, DDQ, T, timespan)
            case 'ddx'
                DowolnyPunkt(3, 1, punkt, [0,0]', Q, DQ, DDQ, T, timespan)
            case 'ddy'
                DowolnyPunkt(3, 2, punkt, [0,0]', Q, DQ, DDQ, T, timespan)
            case 'ddfi'
                RysujObrot(3, punkt,  Q, DQ, DDQ, T, timespan)
        end
    else
        for i = 1:length(Punkty)
            if strcmp(Punkty(i).punkt, punkt)
                cialo = Punkty(i).cialo;
                wektor_lok = Punkty(i).wektor_lok;
                break
            end
        end
        
        switch typ_wykresu
            case 'x'
                DowolnyPunkt(1, 1, cialo, wektor_lok, Q, DQ, DDQ, T, timespan)
            case 'y'
                DowolnyPunkt(1, 2, cialo, wektor_lok, Q, DQ, DDQ, T, timespan)
            case 'dx'
                DowolnyPunkt(2, 1, cialo, wektor_lok, Q, DQ, DDQ, T, timespan)
            case 'dy'
                DowolnyPunkt(2, 2, cialo, wektor_lok, Q, DQ, DDQ, T, timespan)
            case 'ddx'
                DowolnyPunkt(3, 1, cialo, wektor_lok, Q, DQ, DDQ, T, timespan)
            case 'ddy'
                DowolnyPunkt(3, 2, cialo, wektor_lok, Q, DQ, DDQ, T, timespan)
        end
        
    end
                
end