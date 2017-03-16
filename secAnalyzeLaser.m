close all;clear;clc;
Fe55_Pre_Co60_12_15_16_S = load('./figures/12-15-16_filt/fe55_pre_co60_12_15_16.mat');
Fe55_Post_Co60_12_15_16_S = load('./figures/12-15-16_filt/fe55_post_co60_12_15_16.mat');
Laser_Pre_Co60_12_15_16_S = load('./figures/12-15-16_filt/laser_pre_co60_12_15_16.mat');
Laser_Post_Co60_12_15_16_S = load('./figures/12-15-16_filt/laser_post_co60_12_15_16.mat');

aA_Fe55_Pre_Co60_12_15_16 = Fe55_Pre_Co60_12_15_16_S.matUnEvRegA(:,1)';
aA_Fe55_Post_Co60_12_15_16 = Fe55_Post_Co60_12_15_16_S.matUnEvRegA(:,1)';
aA_Laser_Pre_Co60_12_15_16 = Laser_Pre_Co60_12_15_16_S.matUnEvRegA(:,1)';
aA_Laser_Post_Co60_12_15_16 = Laser_Post_Co60_12_15_16_S.matUnEvRegA(:,1)';

binWid = 2;
gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
startPoints = [120  40 20 0.5];

figNum = 0;
figNum = figNum+1;
figure(figNum);
hold on;
hA_Fe55_Pre_Co60_12_15_16 = histogram(aA_Fe55_Pre_Co60_12_15_16,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair');
aArea_Fe55_Pre_Co60_12_15_16 = hA_Fe55_Pre_Co60_12_15_16.BinEdges(1:end-1)+binWid/2;
aCount_Fe55_Pre_Co60_12_15_16 = hA_Fe55_Pre_Co60_12_15_16.Values;
fitA_Fe55_Pre_Co60_12_15_16 = fit(aArea_Fe55_Pre_Co60_12_15_16',aCount_Fe55_Pre_Co60_12_15_16',gaussEqn,'Start', startPoints);

hA_Fe55_Post_Co60_12_15_16 = histogram(aA_Fe55_Post_Co60_12_15_16,'binwidth',binWid,'EdgeColor','b','DisplayStyle','stair');
aArea_Fe55_Post_Co60_12_15_16 = hA_Fe55_Post_Co60_12_15_16.BinEdges(1:end-1)+binWid/2;
aCount_Fe55_Post_Co60_12_15_16 = hA_Fe55_Post_Co60_12_15_16.Values;
fitA_Fe55_Post_Co60_12_15_16 = fit(aArea_Fe55_Post_Co60_12_15_16',aCount_Fe55_Post_Co60_12_15_16',gaussEqn,'Start', startPoints);

figure(figNum);
hold on;
x = 0:0.1:140;
fitCurvePre = fitA_Fe55_Pre_Co60_12_15_16.a*exp(-((x-fitA_Fe55_Pre_Co60_12_15_16.x0)/fitA_Fe55_Pre_Co60_12_15_16.c).^2)+fitA_Fe55_Pre_Co60_12_15_16.d;
plot(x, fitCurvePre,'k');
fitCurvePost = fitA_Fe55_Post_Co60_12_15_16.a*exp(-((x-fitA_Fe55_Post_Co60_12_15_16.x0)/fitA_Fe55_Post_Co60_12_15_16.c).^2)+fitA_Fe55_Post_Co60_12_15_16.d;
plot(x, fitCurvePost,'m');
xlabel('Area');
ylabel('Counts');
legend('Fe55 Pre Co60','Fe55 Post Co60','Fit Pre Co60','Fit Post Co60','Location','Best');
xlim([0 120]);

convAtoE_Fe55_Pre_Co60_12_15_16 = 5.9/fitA_Fe55_Pre_Co60_12_15_16.x0;
convAtoE_Fe55_Post_Co60_12_15_16 = 5.9/fitA_Fe55_Post_Co60_12_15_16.x0;


figNum = figNum+1;
figure(figNum);
hold on;
grid on;
histogram(aA_Laser_Pre_Co60_12_15_16*convAtoE_Fe55_Pre_Co60_12_15_16,'binwidth',10,'EdgeColor','r','DisplayStyle','stair');
histogram(aA_Laser_Post_Co60_12_15_16*convAtoE_Fe55_Post_Co60_12_15_16,'binwidth',10,'EdgeColor','b','DisplayStyle','stair');
legend('Laser Pre Co60','Laser Post Co60','Location','Best');
xlabel('Energy (keVee)','FontSize',20);
ylabel('Counts','FontSize',20);


%Fid Analysis
fbox = 1;
HV = 60E3;
detLen = 58.3; %cm
Press = 30;
driftE = HV*fbox/detLen
points = 10000;

threshold = 10;
perIMax = 0.03;
bOnly1 = false;

dVelmm_SF6 = calcDriftVel(Press,driftE,true)/1000
dVelmm_SF5 = calcDriftVel(Press,driftE,false)/1000

matLaserPre_IT = Laser_Pre_Co60_12_15_16_S.matUnIPeakT;
matLaserPre_IMax = Laser_Pre_Co60_12_15_16_S.matUnIPriMax;
aTPriTot_LaserPre = matLaserPre_IT(:,1)';
aPriI_LaserPre = matLaserPre_IMax(:,1);
matTempI_LaserPre = matLaserPre_IMax(:,2:end);
matTSecs_LaserPre = matLaserPre_IT(:,2:end);

matLaserPost_IT = Laser_Post_Co60_12_15_16_S.matUnIPeakT;
matLaserPost_IMax = Laser_Post_Co60_12_15_16_S.matUnIPriMax;
aTPriTot_LaserPost = matLaserPost_IT(:,1)';
aPriI_LaserPost = matLaserPost_IMax(:,1);
matTempI_LaserPost = matLaserPost_IMax(:,2:end);
matTSecs_LaserPost = matLaserPost_IT(:,2:end);


[r,c] = size(matTempI_LaserPre);
c = c+1;
aISec_LaserPre = 0;
aTSec_LaserPre = 0;
aTPri_LaserPre = 0;
n=1;
for i = 1:length(aTPriTot_LaserPre)
    priI = aPriI_LaserPre(i);
    priT = aTPriTot_LaserPre(i);
    threshold = priI*perIMax;

    l = 1;
    aSecI = matTempI_LaserPre(i,:);
    aSecT = matTSecs_LaserPre(i,:);
    [secTempInd,dT] = findSF5Peak2(threshold,priT,aSecI,aSecT);
    aISec_LaserPre(n) = aSecI(secTempInd);
    aTSec_LaserPre(n) = aSecT(secTempInd);
    aTPri_LaserPre(n) = priT;
    n = n+1;
end

%post laser
[r,c] = size(matTempI_LaserPost);
c = c+1;
aISec_LaserPost = 0;
aTSec_LaserPost = 0;
aTPri_LaserPost = 0;
n=1;
for i = 1:length(aTPriTot_LaserPost)
    priI = aPriI_LaserPost(i);
    priT = aTPriTot_LaserPost(i);
    threshold = priI*perIMax;

    l = 1;
    aSecI = matTempI_LaserPost(i,:);
    aSecT = matTSecs_LaserPost(i,:);
    [secTempInd,dT] = findSF5Peak2(threshold,priT,aSecI,aSecT);
    aISec_LaserPost(n) = aSecI(secTempInd);
    aTSec_LaserPost(n) = aSecT(secTempInd);
    aTPri_LaserPost(n) = priT;
    n = n+1;
end

%fit pri and sec peak abs time
binWid = 0.2;
gaussEqn = 'a*exp(-((x-x0)/c)^2)';
startPoints = [100  0.5 3735];
figNum = figNum+1;
figure(figNum);
hold on;
hT_Laser_Pre_Pri = histogram(aTPri_LaserPre,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair');
aT_Laser_Pre_Pri = hT_Laser_Pre_Pri.BinEdges(1:end-1)+binWid/2;
aCount_Laser_Pre_Pri = hT_Laser_Pre_Pri.Values;
fitT_Laser_Pre_Pri = fit(aT_Laser_Pre_Pri',aCount_Laser_Pre_Pri',gaussEqn,'Start', startPoints);
x = 3734:0.01:3736;
fitCurvePre_Pri = fitT_Laser_Pre_Pri.a*exp(-((x-fitT_Laser_Pre_Pri.x0)/fitT_Laser_Pre_Pri.c).^2);
plot(x, fitCurvePre_Pri,'k');
xlabel('Time (us)');
ylabel('Counts');
title('Pre Laser Primary Arrival Time');

startPoints = [30  3 3456.5];
binWid = 1;
figNum = figNum+1;
figure(figNum);
hold on;
hT_Laser_Pre_Sec = histogram(aTSec_LaserPre,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair');
aT_Laser_Pre_Sec = hT_Laser_Pre_Sec.BinEdges(1:end-1)+binWid/2;
aCount_Laser_Pre_Sec = hT_Laser_Pre_Sec.Values;
fitT_Laser_Pre_Sec = fit(aT_Laser_Pre_Sec',aCount_Laser_Pre_Sec',gaussEqn,'Start', startPoints);
x = 3440:0.2:3470;
fitCurvePre_Sec = fitT_Laser_Pre_Sec.a*exp(-((x-fitT_Laser_Pre_Sec.x0)/fitT_Laser_Pre_Sec.c).^2);
plot(x, fitCurvePre_Sec,'k');
xlabel('Time (us)');
ylabel('Counts');
xlim([3440 3470]);
title('Pre Laser Secondary Arrival Time');


adT_LaserPre = aTPri_LaserPre-aTSec_LaserPre;
adT_LaserPost = aTPri_LaserPost-aTSec_LaserPost;

mdVel_SF6_Pre = detLen*10/fitT_Laser_Pre_Pri.x0
mdVel_SF5_Pre = detLen*10/fitT_Laser_Pre_Sec.x0
mdVel_SF6_Post = detLen*10/mean(aTPriTot_LaserPost)
mdVel_SF5_Post = detLen*10/mean(aTSec_LaserPost)

coeffZpre = (mdVel_SF6_Pre*mdVel_SF5_Pre)/(mdVel_SF5_Pre-mdVel_SF6_Pre)
coeffZpost = (mdVel_SF6_Post*mdVel_SF5_Post)/(mdVel_SF5_Post-mdVel_SF6_Post)
% coeffZ = (dVelmm_SF6*dVelmm_SF5)/(dVelmm_SF5-dVelmm_SF6)
Z_LaserPre = coeffZpre*adT_LaserPre;
Z_LaserPost = coeffZpost*adT_LaserPost;
maxdT = detLen*10/coeffZpost

figNum = figNum+1;
figure(figNum);
hold on;
grid on;
histogram(adT_LaserPre,'binwidth',1,'EdgeColor','r','DisplayStyle','stair');
histogram(adT_LaserPost,'binwidth',1,'EdgeColor','b','DisplayStyle','stair');
xlabel('\DeltaT (us)');
ylabel('Count');
legend('Laser Pre Co60','Laser Post Co60','Location','Best');

figNum = figNum+1;
figure(figNum);
hax = axes;
hold on;
grid on;
histogram(Z_LaserPre,'binwidth',2,'EdgeColor','r','DisplayStyle','stair');
histogram(Z_LaserPost,'binwidth',2,'EdgeColor','b','DisplayStyle','stair');
line([detLen*10 detLen*10], get(hax,'YLim'),'Color','k','LineStyle','-');
xlabel('Z (mm)');
ylabel('Count');
legend('Laser Pre Co60','Laser Post Co60','Cathode Z','Location','Best');

%Look at Average Pulse
T = (-1000:0.2:1000-0.2)';
figNum = figNum+1;
figure(figNum);
hax = axes;
hold on;
grid on;
% [preAvgVmax,preInd] = max(Laser_Pre_Co60_12_15_16_S.aAvgUnI);
[postAvgVmax,postInd] = max(Laser_Pre_Co60_12_15_16_S.aAvgUnI);

[avgIpks, locsavgI] = findpeaks(Laser_Pre_Co60_12_15_16_S.aAvgUnI);
[~,preSortInd] = sort(avgIpks,'descend');
aPksavgI = avgIpks(preSortInd);
aPreInd = locsavgI(preSortInd);
priI = aPksavgI(1);
preIndPriI = aPreInd(1);
secI = aPksavgI(2);
preIndSecI = aPreInd(2);
% [postAvgVmax,postInd] = sort(Laser_Pre_Co60_12_15_16_S.aAvgUnI,'descend');

preAvgI = Laser_Pre_Co60_12_15_16_S.aAvgUnI/priI;
postAvgI = Laser_Post_Co60_12_15_16_S.aAvgUnI/postAvgVmax;
plot(T-T(preIndPriI),preAvgI,'r');
plot(T-T(postInd),postAvgI,'b');
xlabel('T (us)');
ylabel('I (Normalized to Max V)');
legend('Laser Pre 12-15-16','Laser Post 12-15-16','Location','Best');
xlim([-600 300]);
% T(p)-T(aPreInd(2))

perDiffdVel = 100*(mdVel_SF6_Pre-mdVel_SF6_Post)/((mdVel_SF6_Pre+mdVel_SF6_Post)/2)