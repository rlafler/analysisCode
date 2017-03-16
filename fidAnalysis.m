%% Fidutialization Analysis
close all;clear;clc;
fbox = 0.888;
detLen = 58.3; %cm
HV = 37.3E3;
Press = 30;
% Press = 20;
driftE = HV*fbox/detLen;
points = 10000;
dVelmm_SF6 = calcDriftVel(Press,driftE,true)/1000
dVelmm_SF5 = calcDriftVel(Press,driftE,false)/1000


%Load mat files
DD_GEM_7_26_16_S = load('./figures/7-26-16/DD_GEM_7-26-16.mat');
Co60_9_20_16_S = load('./figures/9-20-16/Co60_9-20-16.mat');

%Selection Cuts
convAtoE_DD_GEM_7_26_16 = 0.1532;
convAtoE_Co60_9_20_16 = 0.1537;
aL_DD_GEM_7_26_16 = DD_GEM_7_26_16_S.matUnEvRegZ(:,3)';
aL_Co60_9_20_16 = Co60_9_20_16_S.matUnEvRegZ(:,3)';
adEdx_DD_GEM_7_26_16 = DD_GEM_7_26_16_S.matUnIPriMax(:,1)'*convAtoE_DD_GEM_7_26_16;
adEdx_Co60_9_20_16 = Co60_9_20_16_S.matUnIPriMax(:,1)'*convAtoE_Co60_9_20_16;
alnn_DD_GEM_7_26_16 = (log(adEdx_DD_GEM_7_26_16./aL_DD_GEM_7_26_16))';
alnn_Co60_9_20_16 = (log(adEdx_Co60_9_20_16./aL_Co60_9_20_16))';
aAvgdEdx_DD_GEM_7_26_16 = DD_GEM_7_26_16_S.matUnAvgdAdZ(:,3)'*convAtoE_DD_GEM_7_26_16;
aAvgdEdx_Co60_9_20_16 = Co60_9_20_16_S.matUnAvgdAdZ(:,3)'*convAtoE_Co60_9_20_16;

avgdEdzCut = 12;
lnCut = 1.0;
%apply cuts to NRs (nguyen)
selIndNR_GEM_7_26_16 = alnn_DD_GEM_7_26_16' > lnCut;
selIndNR_GEM_7_26_16 = selIndNR_GEM_7_26_16 & aAvgdEdx_DD_GEM_7_26_16 > avgdEdzCut;
selIndNR_Co60_9_20_16 = alnn_Co60_9_20_16' > lnCut;
selIndNR_Co60_9_20_16 = selIndNR_Co60_9_20_16 & aAvgdEdx_Co60_9_20_16 > avgdEdzCut;

%Fiductialization
threshold = 30.0;
bSecMax = false
bOnly1 = true

matCo60_IT = Co60_9_20_16_S.matUnIPeakT;
matCo60_IMax = Co60_9_20_16_S.matUnIPriMax;
%apply Cuts
matCo60_IT = matCo60_IT(selIndNR_Co60_9_20_16,1:end);
matCo60_IMax = matCo60_IMax(selIndNR_Co60_9_20_16,1:end);

%Inter Vars
aTPriTot_Co60 = matCo60_IT(:,1)';
aPriI_Co60 = Co60_9_20_16_S.matUnIPriMax(:,1);
matTempI_Co60 = matCo60_IMax(:,2:end);
matTSecs_Co60 = matCo60_IT(:,2:end);

%Ensure secondary peak before primary, more negative.
[r,c] = size(matTempI_Co60);
c = c+1;
n = 1;
aISec_Co60 = 0;
aTSec_Co60 = 0;
aTPri_Co60 = 0;
for i = 1:length(aTPriTot_Co60)
    priI = aPriI_Co60(i);
    priT_Co60 = aTPriTot_Co60(i);
    for j = 1:c-1
        secI = matTempI_Co60(i,j);
        if matTSecs_Co60(i,j)>priT_Co60 % reject secondary peaks mistakingly added after primary
            matTempI_Co60(i,j) = -1000;
            continue;
        end
    end
    if bSecMax
        [secPkVal_Co60,tempInd] = max(matTempI_Co60(i,:));
        secT_Co60 = matTSecs_Co60(i,tempInd);
    else
        l = 1;
        aSecAbI_Co60 = [];
        aSecAbT_Co60 = [];
        for j = 1:c-1
            secI = matTempI_Co60(i,j);
            if secI > threshold
                aSecAbI_Co60(l) = secI;
                aSecAbT_Co60(l) = matTSecs_Co60(i,j);
                l = l+1;
            end
        end
        if isempty(aSecAbT_Co60)
            continue;
        end
        length(aSecAbI_Co60)
        if bOnly1 && length(aSecAbI_Co60)>1
            continue;
        end
        [aSecPkT_Co60,aSecAbInd_Co60] = min(aSecAbT_Co60);
        secPkVal_Co60 = aSecAbI_Co60(aSecAbInd_Co60);
        secT_Co60 = aSecPkT_Co60;
    end
    if secPkVal_Co60 < threshold
        continue;
    end
    aISec_Co60(n) = secPkVal_Co60;
    aTSec_Co60(n) = secT_Co60;
    aTPri_Co60(n) = priT_Co60;
    n = n+1;
end

matDD_GEM_IT = DD_GEM_7_26_16_S.matUnIPeakT;
matDD_GEM_IMax = DD_GEM_7_26_16_S.matUnIPriMax;
matDD_GEM_IT = matDD_GEM_IT(selIndNR_GEM_7_26_16,1:end);
matDD_GEM_IMax = matDD_GEM_IMax(selIndNR_GEM_7_26_16,1:end);

aTPriTot_DD_GEM = matDD_GEM_IT(:,1)';
aPriI_DD_GEM = matDD_GEM_IMax(:,1);
matTempI_DD_GEM = matDD_GEM_IMax(:,2:end);
matTSecs_DD_GEM = matDD_GEM_IT(:,2:end);

[r,c] = size(matTempI_DD_GEM);
c = c+1;
aISec_DD_GEM = 0;
aTSec_DD_GEM = 0;
aTPri_DD_GEM = 0;
n=1;
for i = 1:length(aTPriTot_DD_GEM)
    priI = aPriI_DD_GEM(i);
    priT_GEM = aTPriTot_DD_GEM(i);
    for j = 1:c-1
        secI = matTempI_DD_GEM(i,j);
        if matTSecs_DD_GEM(i,j)>priT_GEM
            matTempI_DD_GEM(i,j) = -1000;
            continue;
        end
    end        
    if bSecMax
        [secPkVal_GEM,tempInd] = max(matTempI_GEM(i,:));
        secT_GEM = matTSecs_GEM(i,tempInd);
    else
        l = 1;
        aSecAbI_GEM = [];
        aSecAbT_GEM = [];
        for j = 1:c-1
            secI = matTempI_DD_GEM(i,j);
            if secI > threshold
                aSecAbI_GEM(l) = secI;
                aSecAbT_GEM(l) = matTSecs_DD_GEM(i,j);
                l = l+1;
            end
        end
        if isempty(aSecAbT_GEM)
            continue;
        end
        if bOnly1 && length(aSecAbI_GEM)>1
            continue;
        end
        [aSecPkT_GEM,aSecAbInd_GEM] = min(aSecAbT_GEM);
        secPkVal_GEM = aSecAbI_GEM(aSecAbInd_GEM);
        secT_GEM = aSecPkT_GEM;
    end    
    if secPkVal_GEM < threshold
        continue;
    end
    aISec_DD_GEM(n) = secPkVal_GEM;
    aTSec_DD_GEM(n) = secT_GEM;
    aTPri_DD_GEM(n) = priT_GEM;
    n = n+1;
end

adT_Co60 = aTPri_Co60-aTSec_Co60;
adT_DD_GEM = aTPri_DD_GEM-aTSec_DD_GEM;
coeffZ = (dVelmm_SF6*dVelmm_SF5)/(dVelmm_SF5-dVelmm_SF6)
Z_Co60 = coeffZ*adT_Co60;
Z_GEM = coeffZ*adT_DD_GEM;

figNum = 0;
figNum = figNum+1;
figure(figNum);
hold on;
grid on;
histogram(aTPri_Co60,'binwidth',5,'EdgeColor','b','DisplayStyle','stair');
histogram(aTPri_DD_GEM,'binwidth',5,'EdgeColor','r','DisplayStyle','stair');
xlabel('T Primary (us)');
ylabel('Count');
legend('Co60','DD GEM','Location','Best');

figNum = figNum+1;
figure(figNum);
hold on;
grid on;
histogram(aTSec_Co60,'binwidth',50,'EdgeColor','b','DisplayStyle','stair');
histogram(aTSec_DD_GEM,'binwidth',50,'EdgeColor','r','DisplayStyle','stair');
xlabel('T Secondary(us)');
ylabel('Count');
legend('Co60','DD GEM','Location','Best');

figNum = figNum+1;
figure(figNum);
hold on;
grid on;
plot(aTSec_Co60,aISec_Co60,'.b');
plot(aTSec_DD_GEM,aISec_DD_GEM,'.r');
xlabel('T Secondary(us)');
ylabel('I Secondary (keV/mm)');
legend('Co60','DD GEM','Location','Best');

figNum = figNum+1;
figure(figNum);
hold on;
grid on;
histogram(adT_Co60,'binwidth',50,'EdgeColor','b','DisplayStyle','stair');
histogram(adT_DD_GEM,'binwidth',50,'EdgeColor','r','DisplayStyle','stair');
xlabel('\DeltaT (us)');
ylabel('Count');
legend('Co60','DD GEM','Location','Best');

figNum = figNum+1;
figure(figNum);
hold on;
grid on;
histogram(aISec_Co60,'binwidth',5,'EdgeColor','b','DisplayStyle','stair');
histogram(aISec_DD_GEM,'binwidth',5,'EdgeColor','r','DisplayStyle','stair');
xlabel('Secondary Peak Amplitude (keV/mm)');
ylabel('Count');
legend('Co60','DD GEM','Location','Best');


figNum = figNum+1;
figure(figNum);
hax = axes;
hold on;
grid on;
histogram(Z_Co60,'binwidth',50,'EdgeColor','b','DisplayStyle','stair');
histogram(Z_GEM,'binwidth',50,'EdgeColor','r','DisplayStyle','stair');
line([583 583], get(hax,'YLim'),'Color','k','LineStyle','-');
xlabel('Z (mm)');
ylabel('Count');
legend('Co60','DD GEM','Cathode Z','Location','Best');