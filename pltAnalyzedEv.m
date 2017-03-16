function pltAnalyzedEv(Press,driftE,M,convAtoE,estEvA,estOutA,evRegZ,aEdges,skew,priVPeakIndex,priIPeakIndex,aThrs,bShaped)
    %Unwrap and assign local variables
    T = M(:,1);V = M(:,2);I = M(:,3);sI = M(:,4);sIA = M(:,5);
    pkFindIThr = aThrs(1);
    skewThr = aThrs(2);
    thrRMS = aThrs(3);
    mainLedge = aEdges(1,1:end);
    mainRedge = aEdges(2,1:end);
    halfDispWind = 300;
    peakT = T(priIPeakIndex(1));
    peakT = 0;
    
    %choose SF5^-
    threshold = 0.025*sI(priIPeakIndex(1));
    [indSecPk,dT] = findSF5Peak(threshold,T,sI,priIPeakIndex);
    
    %Shift Primary to Zero
    T = T-peakT;
    mainLedge = mainLedge - peakT;
    mainRedge = mainRedge - peakT;
    peakT = T(priIPeakIndex(1));
    
    bNormItoVmax = true;
    bPlotI = true;
    bPlotV = true;
    bPlotFFT = true;
    bPlotAsdEdZ = false;
    L=length(T);
    twind = (T(end)-T(1))*1E-6;
    Fs = L/twind;
    dVelmm = calcDriftVel(Press,driftE,true)/1000;
    figNum = 1;
    if bPlotV
        evEner = estEvA(1)*convAtoE;
        evEOut = estOutA*convAtoE;
        figTitle = sprintf('Unsh V, E=%0.2fkeV,Eout=%0.2fkeV, R1=%0.2fmm,\nPress=%dTorr,driftE=%iV/cm',evEner,evEOut,evRegZ(3),Press,int32(driftE));
        if bShaped
            figNum = 3;
            figTitle = sprintf('Sh V, E=%0.2fkeV,Eout=%0.2fkeV, R1=%0.2fmm,\nPress=%dTorr,driftE=%iV/cm',evEner,evEOut,evRegZ(3),Press,int32(driftE));;
        end
        figure(figNum);
        clf;
        hax = axes;
        if bShaped
            plot(T,V,'b',T,sIA,'r--');
            limitsY = get(hax,'Ylim');
            if sI(priIPeakIndex(1))>limitsY(2)
                ylim([limitsY(1),sI(priIPeakIndex(1))+0.5]);
            end
            line([T(priVPeakIndex) T(priVPeakIndex)],get(hax,'YLim'),'Color','r','LineStyle','--')
            line(get(hax,'XLim'),[0 0],'Color','k','LineStyle','-')
            line(get(hax,'XLim'),[skewThr skewThr],'Color','b','LineStyle','--')
            line(get(hax,'XLim'),[pkFindIThr pkFindIThr],'Color','m','LineStyle','--')
            line([peakT peakT],get(hax,'YLim'),'Color','r','LineStyle','--')
            for ledge = mainLedge
                line([ledge ledge],get(hax,'YLim'),'Color','k','LineStyle','--')
            end
            for redge = mainRedge
                line([redge redge],get(hax,'YLim'),'Color','k','LineStyle','--')
            end
        else
            plot(T,V,'b');
        end
        xlabel('Time (us)');
        ylabel('Voltage (V)');
        title(figTitle);
        xlim([-1000 1000]);
%         xlim([mainLedge(1)-halfDispWind mainRedge(1)+halfDispWind]);
    end
    if bPlotFFT && ~bShaped
        figure(figNum+3);
        clf;
        Lfour = 0.3*L;
        f = Fs*(0:(Lfour/2)-1)/Lfour;
        YV = fft(V,Lfour);
        P2 = abs(YV);
        P1V = P2(1:int32(Lfour/2));
        P1V(2:end-1) = 2*P1V(2:end-1);

        YfV = fft(sI,Lfour);
        P2 = abs(YfV);
        P1fV = P2(1:int32(Lfour/2));
        P1fV(2:end-1) = 2*P1fV(2:end-1);
        semilogy(f,P1fV,'g',f,P1V,'b');
        title('Single-Sided Amplitude Spectrum')
        xlabel('f (Hz)')
        ylabel('dB')
    end
    if ~bShaped && bPlotI
        pkdAdxPerL = max(sI(priIPeakIndex(1)))/evRegZ(3);
        evEner = estEvA(1)*convAtoE;
        evEOut = estOutA*convAtoE;
        figure(figNum+1);
        clf;
        hax = axes;
        if bPlotAsdEdZ
            multConvI = convAtoE/dVelmm;
            multConvT = dVelmm;
            sxlabel = 'Z (mm)';
            sylabel = 'dE/dZ (keV/mm)';
        else
            multConvI = 1;
            multConvT = 1;
            sxlabel = 'T (us)';
            sylabel = 'I (arb)';
        end
        plot(T*multConvT,sI*multConvI,'k',T*multConvT,sIA*multConvI,'r--');
        limitsY = get(hax,'Ylim');
        if sI(priIPeakIndex(1))*multConvI>limitsY(2)
            ylim([limitsY(1),sI(priIPeakIndex(1))*multConvI+1]);
        end
        line(get(hax,'XLim'),[0 0],'Color','k','LineStyle','-')
        line(get(hax,'XLim'),[skewThr*multConvI skewThr*multConvI],'Color','b','LineStyle','--')
        line(get(hax,'XLim'),[thrRMS*multConvI thrRMS*multConvI],'Color','c','LineStyle','--')
        line([peakT*multConvT peakT*multConvT],get(hax,'YLim'),'Color','r','LineStyle','--')
        line([T(indSecPk)*multConvT T(indSecPk)*multConvT],get(hax,'YLim'),'Color','g','LineStyle','--');
        for ledge = mainLedge
            line([ledge*multConvT ledge*multConvT],get(hax,'YLim'),'Color','k','LineStyle','--')
        end
        for redge = mainRedge
            line([redge*multConvT redge*multConvT],get(hax,'YLim'),'Color','k','LineStyle','--')
        end
        xlabel(sxlabel);
        ylabel(sylabel);
        ampRatio = 100*sI(indSecPk)/sI(priIPeakIndex(1));
        legend('Sm I','Sm I Area','Zero','Skew Thr','3 RMS','SF6^-','SF5^-');
        title(sprintf('E=%0.2fkeV, Eout=%0.2fkeV, R1=%0.2fmm, Skew=%0.2f,\nPress=%dTorr, driftE=%iV/cm',evEner,evEOut,evRegZ(3),skew,Press,int32(driftE)),'Interpreter','latex');
%         xlim([mainLedge(1)*multConvT-halfDispWind*multConvT mainRedge(1)*multConvT+halfDispWind*multConvT]);
        xlim([-1000 1000])
    end
    drawnow;
end
