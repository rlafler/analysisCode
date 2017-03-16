function [M,aVmaxIndex, VOffSet, aPriIPeakIndex,matPkEdges,aEvRegZ,aEstEvA,estOutA,aAvgdAdx,aRMSnoise,aSkew,aNumEvPks,aThrs] = analyzeEvent(fName,Press,driftE,points,bShaped,type,date)
    M = [];aThrs = [];aVmaxIndex = [1, 1];
    aPriIPeakIndex = [1,1];aEvRegZ = [0,0,0];aEstEvA = [0,0,0,0,0];estOutA = 0;aAvgdAdx = 0;aRMSnoise = [0,0,0];
    VOffSet = 0.0;aSkew = [0,0];aNumEvPks = [0,0];aThrs = [0, 0, 0];
    tau=100e-6;
    redFac=1E3;
    gausFun = @(x,x0,sig) (1.0/(sig*sqrt(2*pi)))*exp(-((x-x0).^2)/(2*sig.^2));
%     skewnDist = @(x) (sum((x-mean(x)).^3)./length(x)) ./ (var(x,1).^1.5);
%     skewns = @(x,y) (sum(((x-sum(x.*y)/sum(y)).^3).*y)./sum(y))./((sum(((x-sum(x.*y)/sum(y)).^2).*y)./(sum(y)-1)).^1.5);

%     smoothTImm = 0.75/sqrt(2); %total diffusion measured by Nguyen at 30Torr, 60cm
%     smoothTImmA = 1; %mm
    smoothTImmZ = 0.3; %mm
%     smoothTImmZ = 0.3; %mm
    smoothTImmA = 3; %mm

%     Vsat = 2.2;
    Vsat = 1.30199;    
    bRmOffset = true;
    
%     [meanVOffSet,meanRMSnoiseV,meanRMSnoiseI] = chooseOffAndRMS(bShaped,type,date);
%     [meanVOffSet,meanRMSnoiseV,meanRMSnoiseI] = chooseOffAndRMS_filt(bShaped,type,date);
    [meanVOffSet,meanRMSnoiseV,meanRMSnoiseI] = chooseOffAndRMS_143mV(bShaped,type,date);

    %     thrholds = [0 meanRMSnoiseI 3*meanRMSnoiseI];
    thrholds = [0 3*meanRMSnoiseI];
    matPkEdges = ones(2,length(thrholds));
    pkFindVThr = -0.04;
    if bRmOffset
        thrRMS = 3*meanRMSnoiseI;
        pkFindIThr = 0.0;
    else
        thrRMS = 0.0;
        pkFindIThr = -0.4;
        skewThr = 0.01;
    end
   
    fName
    evNum = str2num(fName(strfind(fName,'__')+2:strfind(fName,'.txt')-1));
    M = dlmread(fName,'\t',1,0);
    T = M(:,1);
    V = M(:,2);
    L = length(T);
    V = double(V+0.0);
    
    if bRmOffset
        V = V-meanVOffSet*ones(size(V)); %Remove Constant Offset
    else 
        pkFindVThr = pkFindVThr + meanVOffSet;
    end
    T = T((L-points)/2+1:(L+points)/2)*1E6;
    V = V((L-points)/2+1:(L+points)/2);
    
    L = length(T);            % Length of signal
    twind = (T(end)-T(1))*1E-6;
    Fs = L/twind;
    M = zeros(length(T),5);
    
    [VmaxVal,vMaxInd] = max(V);
    %quick and temp removal of saturated events
    if VmaxVal>=Vsat & ~bShaped
        fprintf('Event %d Saturated!\n',evNum);
        return;
    end
    
    smoothTIV = 1E-6*5;
    sbinV = round(smoothTIV*Fs);
    ygausV = gausFun(-6*sbinV:1:6*sbinV,0,sbinV);
    Vraw = V;
    V = conv(Vraw,ygausV,'same');
    Vsm = V;
    %Remove 72kHz noise peak
    V = applyFilter(V,Fs);
    V = applyNotchFilter(V,Fs,[71.68E3],[10E2],[-3]);
    V = applyNotchFilter(V,Fs,[25E3],[1],[-32]);
    
    M(:,1)=T;M(:,2)=V;
%     [pksV,locsV] = findpeaks(V,'Threshold',1e-5,'MinPeakHeight',0.5,'MinPeakDistance',10E-6*Fs);
    [pksV,locsV] = findpeaks(V,'Threshold',1e-5);
    aVmaxIndex = locsV;
    [VmaxVal,vMaxInd] = max(V);
    if isempty(aVmaxIndex)
        aVmaxIndex = vMaxInd;
    end 
    
    VOffSet = mean(V(100:1100));
    aRMSnoise(1) = std(V(100:1100));
    
    dVelmm = calcDriftVel(Press,driftE,true)/1000;
    smoothTImmV = smoothTIV*dVelmm/1E-6;
    if ~bShaped
        fV = V;
        %Calculate I
        smoothTIZ = 1E-6*smoothTImmZ/dVelmm;
        sbinZ = round(smoothTIZ*Fs);
        ygausZ = gausFun(-6*sbinZ:1:6*sbinZ,0,sbinZ);
        smoothTIA = 1E-6*smoothTImmA/dVelmm;
        sbinA = round(smoothTIA*Fs);
        ygausA = gausFun(-6*sbinA:1:6*sbinA,0,sbinA);
        
        dVdt = double(centralDiff(fV,Fs));
        I = zeros(L,1);
        for i=1:L
            value = dVdt(i)+double(V(i)/tau);
            I(i) = value/redFac;
        end
        sI=I;
        sIA = I;
        sIA = conv(sI,ygausA,'same');        
        sI = conv(sI,ygausZ,'same');

        rmVmaxIndex = [];
        b = 1;
        for i = 1:length(aVmaxIndex)
            if aVmaxIndex(i)>L
                rmVmaxIndex(b) = i;
                b = b+1;
            end
        end
        aVmaxIndex(rmVmaxIndex) = [];
        aVmaxIndex(aVmaxIndex==0) = [];
    else
        skewThr = 3*meanRMSnoiseV;
        thrRMS = 0.0;
        %Area
        x = smoothTImmA^2;
        y = (3*dVelmm)^2;
        if (x-y)<0
            smoothTImmA = 0;
        else
            smoothTImmA = sqrt(x-y);
        end
        smoothTIA = 1E-6*smoothTImmA/dVelmm;
        sbinA = round(smoothTIA*Fs);
        ygausA = gausFun(-6*sbinA:1:6*sbinA,0,sbinA);
        sIA = V;
        if (sbinA>0)
            sIA = conv(V,ygausA,'same');
        end
        %Ev reg (dZ)
        x = smoothTImmZ^2;
        y = (3*dVelmm)^2;
        if (x-y)<0
            smoothTImmZ = 0;
        else
            smoothTImmZ = sqrt(x-y);
        end
        smoothTIZ = 1E-6*smoothTImmZ/dVelmm;
        sbinZ = round(smoothTIZ*Fs);
        ygausZ = gausFun(-6*sbinZ:1:6*sbinZ,0,sbinZ);
        if (sbinZ>0)
            V = conv(V,ygausZ,'same');
        end
        I = V;
        sI = I;
    end
    
    %Now find everything else  
    % Find Edges of primary
    [priPeakH,maxLoc] = max(sI);
    tempPkInd = maxLoc;
    [lPriEdgeInd,rPriEdgeInd] = findPeakEdges2(sI,tempPkInd,thrholds);
    try
        if rPriEdgeInd(3) == 1 || lPriEdgeInd(3) == 1 || lPriEdgeInd(3)>=rPriEdgeInd(3)
            return;
        end
    catch
        return; 
    end
    ledge = T(lPriEdgeInd);
    redge = T(rPriEdgeInd);
    
    %Edge Primary
    
    priPkInd = tempPkInd;
    mainLedge = ledge;
    mainRedge = redge;

    %Calculate assymetry of primary
    if bRmOffset
        [aSkew(1),aSkew(2),skewThr] = calcSkewness(sI',priPkInd);
    end
    aEvRegZ(1:length(redge)) = (redge-ledge)*dVelmm;
    aPriIPeakIndex(1) = priPkInd;
    
    %Find Total Event Area
    [ledgeAInd,redgeAInd] = findPeakEdges(sIA,priPkInd,0.0);
    if ledgeAInd>=redgeAInd
        aEstEvA(1) = trapz(T,sIA);
    else
        aEstEvA(1) = trapz(T(ledgeAInd:redgeAInd),sIA(ledgeAInd:redgeAInd));
    end
    if aEstEvA(1)<0
        aEstEvA(1) = 0;
        return;
    end
    aEstEvA(2) = trapz(T(lPriEdgeInd(3):rPriEdgeInd(3)),sIA(lPriEdgeInd(3):rPriEdgeInd(3)));
    estOutA = trapz(T(1000:end-1000),sIA(1000:end-1000))-aEstEvA(1);
    aAvgdAdx = aEstEvA(2)./aEvRegZ(1:length(redge));
    
    %Find Secondary Peaks and edges to get area of each
    indOffset = 2000;
    tempIA = sI(indOffset:lPriEdgeInd(3));
    if length(tempIA)<3
        tempIA = sI(indOffset:end-indOffset);
    end
    [pksI,locsI] = findpeaks(tempIA,'MinPeakProminence',0,'MinPeakWidth',0);
    locsI = locsI+indOffset;
    tempPksI = pksI;
    tempInd = locsI;
    
    [sortPksI, sortInd] = sort(tempPksI,'descend');
    sortPksInd = tempInd(sortInd);
    if length(sortPksInd)>= 9
        aPriIPeakIndex(2:10) = sortPksInd(1:9);
    else
        aPriIPeakIndex(2:length(sortPksInd)+1) = sortPksInd(1:length(sortPksInd));
    end
    aRMSnoise(2) = std(sI(100:1100));
    aRMSnoise(3) = std(sIA(100:1100));    
    
    %later calculate analysis on primary peak; width (sigma), skewness
    M(:,3)=I;M(:,4)=sI;M(:,5)=sIA;
    aThrs(1) = pkFindIThr;
    aThrs(2) = skewThr;
    aThrs(3) = thrRMS;
    matPkEdges(1,1:length(thrholds)+1) = mainLedge;
    matPkEdges(2,1:length(thrholds)+1) = mainRedge;
    
%     figure(12)
%     hold on;
%     plot(T,Vraw,'r')
%     plot(T,Vsm,'b')
%     line([-500 0],[0 0],'Color','k','LineStyle','--')
%     xlabel('T (us)')
%     ylabel('Preamplifier V')
%     title('Smooth Preamplifier Voltage')
%     legend('Vraw','Vsmooth','Zero')
% %     xlim([-500 0]);
% 
%     if ~bShaped
%         figure(9)
%         clf;
%         hold on;
%         peakT = T(priPkInd(1));
%         T = T-peakT;
%         IdI = sI.*abs(double(centralDiff(sI,Fs)));
% %         IdI = IdI/(max(IdI)/max(sI));
%         IdI = IdI/1E5;
%         plot(T,sI,'r');
%         plot(T,IdI,'b');
%         xlabel('T (us)')
%         ylabel('I');
%         legend('I','I*dI','Location','Best');
%         ylim([-1 140]);
%     end

%     if ~bShaped
%         figure(8)
%         clf;
%         hold on;
%         peakT = T(priPkInd(1));
%         T = T-peakT;
%         [pks,locs] = findpeaks(V,'MinPeakProminence',0,'MinPeakWidth',0);
%         [locs,transInd] = sort(locs);
%         pks = pks(transInd);
%         Vstep = V;
%         for i = 1:length(locs)-1
% %             locs(i)
% %             locs(i+1)
%             aTemp = (locs(i)):locs(i+1);
%             tempT = 0:0.2:0.2*(length(aTemp)-1);
% %             l = length(aTemp)
% %             l2 = length(tempT)
%             val = exp(tempT./100)';
%             Vstep(aTemp) = V(aTemp).*val;
% %             if i==1
% %                 break
% %             end
%         end
%         Vstep = cumsum(Vstep);
%         plot(T,V,'r');
%         plot(T,Vstep,'k');
% %         plot(T,Vraw,'r');
% %         plot(T,V,'b');
%         xlabel('T (us)')
%         ylabel('V');
% %         xlim([-500 0]);
%     end
    
%     if ~bShaped
%         figure(8)
%         clf;
%         hold on;
%         peakT = T(priPkInd(1));
%         T = T-peakT;
%         plot(T,Vraw,'r');
%         plot(T,V,'b');
%         xlabel('T (us)')
%         ylabel('V');
% %         xlim([-500 0]);
%     end
    
    return;
end