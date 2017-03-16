close all;clear;clc;

bPlotSkew = true;
bPlotOtherScat = false;
bPlot = true;
sVisFe55 = 'off';

% conversion to keVr
[cvtTokeVr, cvtTokeVee] = fit_keVee_to_keVr();

%Load Data Files
Fe55_Pre_Back_12_12_16_S = load('./figures/12-12-16_filt/fe55_pre_back_12_12_16_2.mat');
Fe55_Post_Back_12_12_16_S = load('./figures/12-12-16_filt/fe55_post_back_12_12_16_2.mat');
Back_12_12_16_S = load('./figures/12-12-16_filt/background_12_12_16_2.mat');

Fe55_Pre_Co60_12_15_16_S = load('./figures/12-15-16_filt/fe55_pre_co60_12_15_16_2.mat');
Fe55_Post_Co60_12_15_16_S = load('./figures/12-15-16_filt/fe55_post_co60_12_15_16_2.mat');
Co60_12_15_16_S = load('./figures/12-15-16_filt/co60_12_15_16_2.mat');

Fe55_Pre_DD_2_15_17_S = load('./figures/2-15-17/fe55_Pre_DD_2_15_17.mat');
DD_GEM_2_15_17_S = load('./figures/2-15-17/DD_GEM_2_15_17.mat');
Fe55_Post_DD_2_15_17_S = load('./figures/2-15-17/fe55_Post_DD_2_15_17.mat');

Fe55_Pre_DD_2_16_17_S = load('./figures/2-16-17/fe55_Pre_DD_2_16_17.mat');
DD_Cathode_2_16_17_S = load('./figures/2-16-17/DD_Cathode_2_16_17.mat');
Fe55_Post_DD_2_16_17_S = load('./figures/2-16-17/fe55_Post_DD_2_16_17.mat');

%Find Saturated Events
saturatedV = 2.15;
selIndSat_Back_12_12_16 = Back_12_12_16_S.aUnVPriMax > saturatedV;
selIndSat_Co60_12_15_16 = Co60_12_15_16_S.aUnVPriMax > saturatedV;
selIndSat_DD_GEM_2_15_17 = DD_GEM_2_15_17_S.aUnVPriMax > saturatedV;
selIndSat_DD_Cathode_2_16_17 = DD_Cathode_2_16_17_S.aUnVPriMax > saturatedV;


%Total Area Array variables
aA_Fe55_Pre_Back_12_12_16 = Fe55_Pre_Back_12_12_16_S.matUnEvRegA(:,1)';
aA_Fe55_Post_Back_12_12_16 = Fe55_Post_Back_12_12_16_S.matUnEvRegA(:,1)';
aA_Back_12_12_16 = Back_12_12_16_S.matUnEvRegA(:,1)';
aA_Fe55_Pre_Co60_12_15_16 = Fe55_Pre_Co60_12_15_16_S.matUnEvRegA(:,1)';
aA_Fe55_Post_Co60_12_15_16 = Fe55_Post_Co60_12_15_16_S.matUnEvRegA(:,1)';
aA_Co60_12_15_16 = Co60_12_15_16_S.matUnEvRegA(:,1)';
aA_Fe55_Pre_DD_2_15_17 = Fe55_Pre_DD_2_15_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_DD_2_15_17 = Fe55_Post_DD_2_15_17_S.matUnEvRegA(:,1)';
aA_DD_GEM_2_15_17 = DD_GEM_2_15_17_S.matUnEvRegA(:,1)';
aA_Fe55_Pre_DD_2_16_17 = Fe55_Pre_DD_2_16_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_DD_2_16_17 = Fe55_Post_DD_2_16_17_S.matUnEvRegA(:,1)';
aA_DD_Cathode_2_16_17 = DD_Cathode_2_16_17_S.matUnEvRegA(:,1)';

if ~exist('convAtoE_Back_12_12_16','var') 
    binWid = 2;
    gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
    startPoints = [120  40 20 0.5];
    if strcmp(sVisFe55,'on')
        figure(1);
        hold on;
    end
    hA_Fe55_Pre_Back_12_12_16 = histogram(aA_Fe55_Pre_Back_12_12_16,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_Back_12_12_16 = hA_Fe55_Pre_Back_12_12_16.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_Back_12_12_16 = hA_Fe55_Pre_Back_12_12_16.Values;

    hA_Fe55_Post_Back_12_12_16 = histogram(aA_Fe55_Post_Back_12_12_16,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_Back_12_12_16 = hA_Fe55_Post_Back_12_12_16.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_Back_12_12_16 = hA_Fe55_Post_Back_12_12_16.Values;

    if strcmp(sVisFe55,'on')
        figure(2);
        hold on;
    end
    hA_Fe55_Pre_Co60_12_15_16 = histogram(aA_Fe55_Pre_Co60_12_15_16,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_Co60_12_15_16 = hA_Fe55_Pre_Co60_12_15_16.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_Co60_12_15_16 = hA_Fe55_Pre_Co60_12_15_16.Values;

    hA_Fe55_Post_Co60_12_15_16 = histogram(aA_Fe55_Post_Co60_12_15_16,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_Co60_12_15_16 = hA_Fe55_Post_Co60_12_15_16.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_Co60_12_15_16 = hA_Fe55_Post_Co60_12_15_16.Values;

    if strcmp(sVisFe55,'on')
        figure(3);
        hold on;
    end
    hA_Fe55_Pre_DD_2_15_17 = histogram(aA_Fe55_Pre_DD_2_15_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_DD_2_15_17 = hA_Fe55_Pre_DD_2_15_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_DD_2_15_17 = hA_Fe55_Pre_DD_2_15_17.Values;

    hA_Fe55_Post_DD_2_15_17 = histogram(aA_Fe55_Post_DD_2_15_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_DD_2_15_17 = hA_Fe55_Post_DD_2_15_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_DD_2_15_17 = hA_Fe55_Post_DD_2_15_17.Values;

    if strcmp(sVisFe55,'on')
        figure(4);
        hold on;
    end
    hA_Fe55_Pre_DD_2_16_17 = histogram(aA_Fe55_Pre_DD_2_16_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_DD_2_16_17 = hA_Fe55_Pre_DD_2_16_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_DD_2_16_17 = hA_Fe55_Pre_DD_2_16_17.Values;

    hA_Fe55_Post_DD_2_16_17 = histogram(aA_Fe55_Post_DD_2_16_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_DD_2_16_17 = hA_Fe55_Post_DD_2_16_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_DD_2_16_17 = hA_Fe55_Post_DD_2_16_17.Values;

    %Fit distributions to find x0
    fitA_Fe55_Pre_Back_12_12_16 = fit(aArea_Fe55_Pre_Back_12_12_16',aCount_Fe55_Pre_Back_12_12_16',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_Back_12_12_16 = fit(aArea_Fe55_Post_Back_12_12_16',aCount_Fe55_Post_Back_12_12_16',gaussEqn,'Start', startPoints);
    fitA_Fe55_Pre_Co60_12_15_16 = fit(aArea_Fe55_Pre_Co60_12_15_16',aCount_Fe55_Pre_Co60_12_15_16',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_Co60_12_15_16 = fit(aArea_Fe55_Post_Co60_12_15_16',aCount_Fe55_Post_Co60_12_15_16',gaussEqn,'Start', startPoints);
    fitA_Fe55_Pre_DD_2_15_17 = fit(aArea_Fe55_Pre_DD_2_15_17',aCount_Fe55_Pre_DD_2_15_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_DD_2_15_17 = fit(aArea_Fe55_Post_DD_2_15_17',aCount_Fe55_Post_DD_2_15_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Pre_DD_2_16_17 = fit(aArea_Fe55_Pre_DD_2_16_17',aCount_Fe55_Pre_DD_2_16_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_DD_2_16_17 = fit(aArea_Fe55_Post_DD_2_16_17',aCount_Fe55_Post_DD_2_16_17',gaussEqn,'Start', startPoints);
end


%Energy Calibration variables
convAtoE_Fe55_Pre_Back_12_12_16 = 5.9/fitA_Fe55_Pre_Back_12_12_16.x0;
convAtoE_Fe55_Post_Back_12_12_16 = 5.9/fitA_Fe55_Post_Back_12_12_16.x0;
convAtoE_Back_12_12_16 = (convAtoE_Fe55_Pre_Back_12_12_16+convAtoE_Fe55_Post_Back_12_12_16)/2;
convAtoE_Fe55_Pre_Co60_12_15_16 = 5.9/fitA_Fe55_Pre_Co60_12_15_16.x0;
convAtoE_Fe55_Post_Co60_12_15_16 = 5.9/fitA_Fe55_Post_Co60_12_15_16.x0;
convAtoE_Co60_12_15_16 = (convAtoE_Fe55_Pre_Co60_12_15_16+convAtoE_Fe55_Post_Co60_12_15_16)/2;
convAtoE_Fe55_Pre_DD_2_15_17 = 5.9/fitA_Fe55_Pre_DD_2_15_17.x0;
convAtoE_Fe55_Post_DD_2_15_17 = 5.9/fitA_Fe55_Post_DD_2_15_17.x0;
convAtoE_DD_GEM_2_15_17 = (convAtoE_Fe55_Pre_DD_2_15_17+convAtoE_Fe55_Post_DD_2_15_17)/2;
convAtoE_Fe55_Pre_DD_2_16_17 = 5.9/fitA_Fe55_Pre_DD_2_16_17.x0;
convAtoE_Fe55_Post_DD_2_16_17 = 5.9/fitA_Fe55_Post_DD_2_16_17.x0;
convAtoE_DD_Cathode_2_16_17 = (convAtoE_Fe55_Pre_DD_2_16_17+convAtoE_Fe55_Post_DD_2_16_17)/2;
% convAtoE_DD_Cathode_2_16_17 = convAtoE_DD_GEM_2_15_17;

%Load Laser Skewness Curve

%Length Array variables
aL_Fe55_Pre_Back_12_12_16 = Fe55_Pre_Back_12_12_16_S.matUnEvRegZ(:,3)';
aL_Fe55_Post_Back_12_12_16 = Fe55_Post_Back_12_12_16_S.matUnEvRegZ(:,3)';
aL_Back_12_12_16 = Back_12_12_16_S.matUnEvRegZ(:,3)';
aL_Fe55_Pre_Co60_12_15_16 = Fe55_Pre_Co60_12_15_16_S.matUnEvRegZ(:,3)';
aL_Fe55_Post_Co60_12_15_16 = Fe55_Post_Co60_12_15_16_S.matUnEvRegZ(:,3)';
aL_Co60_12_15_16 = Co60_12_15_16_S.matUnEvRegZ(:,3)';
aL_Fe55_Pre_DD_2_15_17 = Fe55_Pre_DD_2_15_17_S.matUnEvRegZ(:,3)';
aL_Fe55_Post_DD_2_15_17 = Fe55_Post_DD_2_15_17_S.matUnEvRegZ(:,3)';
aL_DD_GEM_2_15_17 = DD_GEM_2_15_17_S.matUnEvRegZ(:,3)';
aL_Fe55_Pre_DD_2_16_17 = Fe55_Pre_DD_2_16_17_S.matUnEvRegZ(:,3)';
aL_Fe55_Post_DD_2_16_17 = Fe55_Post_DD_2_16_17_S.matUnEvRegZ(:,3)';
aL_DD_Cathode_2_16_17 = DD_Cathode_2_16_17_S.matUnEvRegZ(:,3)';

%Max dE/dx Array variables
adEdx_Fe55_Pre_Back_12_12_16 = Fe55_Pre_Back_12_12_16_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Pre_Back_12_12_16;
adEdx_Fe55_Post_Back_12_12_16 = Fe55_Post_Back_12_12_16_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Post_Back_12_12_16;
adEdx_Back_12_12_16 = Back_12_12_16_S.matUnIPriMax(:,1)'*convAtoE_Back_12_12_16;
adEdx_Fe55_Pre_Co60_12_15_16 = Fe55_Pre_Co60_12_15_16_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Pre_Co60_12_15_16;
adEdx_Fe55_Post_Co60_12_15_16 = Fe55_Post_Co60_12_15_16_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Post_Co60_12_15_16;
adEdx_Co60_12_15_16 = Co60_12_15_16_S.matUnIPriMax(:,1)'*convAtoE_Co60_12_15_16;
adEdx_Fe55_Pre_DD_2_15_17 = Fe55_Pre_DD_2_15_17_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Pre_DD_2_15_17;
adEdx_Fe55_Post_DD_2_15_17 = Fe55_Post_DD_2_15_17_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Post_DD_2_15_17;
adEdx_DD_GEM_2_15_17 = DD_GEM_2_15_17_S.matUnIPriMax(:,1)'*convAtoE_DD_GEM_2_15_17;
adEdx_Fe55_Pre_DD_2_16_17 = Fe55_Pre_DD_2_16_17_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Pre_DD_2_16_17;
adEdx_Fe55_Post_DD_2_16_17 = Fe55_Post_DD_2_16_17_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Post_DD_2_16_17;
adEdx_DD_Cathode_2_16_17 = DD_Cathode_2_16_17_S.matUnIPriMax(:,1)'*convAtoE_DD_Cathode_2_16_17;

%ln(n) Array variables
alnn_Fe55_Pre_Back_12_12_16 = (log(adEdx_Fe55_Pre_Back_12_12_16./aL_Fe55_Pre_Back_12_12_16))';
alnn_Fe55_Post_Back_12_12_16 = (log(adEdx_Fe55_Post_Back_12_12_16./aL_Fe55_Post_Back_12_12_16))';
alnn_Back_12_12_16 = (log(adEdx_Back_12_12_16./aL_Back_12_12_16))';

alnn_Fe55_Pre_Co60_12_12_16 = (log(adEdx_Fe55_Pre_Co60_12_15_16./aL_Fe55_Pre_Co60_12_15_16))';
alnn_Fe55_Post_Co60_12_12_16 = (log(adEdx_Fe55_Post_Co60_12_15_16./aL_Fe55_Post_Co60_12_15_16))';
alnn_Co60_12_12_16 = (log(adEdx_Co60_12_15_16./aL_Co60_12_15_16))';
alnn_Fe55_Pre_DD_2_15_17 = (log(adEdx_Fe55_Pre_DD_2_15_17./aL_Fe55_Pre_DD_2_15_17))';
alnn_Fe55_Post_DD_2_15_17 = (log(adEdx_Fe55_Post_DD_2_15_17./aL_Fe55_Post_DD_2_15_17))';
alnn_DD_GEM_2_15_17 = (log(adEdx_DD_GEM_2_15_17./aL_DD_GEM_2_15_17))';
alnn_Fe55_Pre_DD_2_16_17 = (log(adEdx_Fe55_Pre_DD_2_16_17./aL_Fe55_Pre_DD_2_16_17))';
alnn_Fe55_Post_DD_2_16_17 = (log(adEdx_Fe55_Post_DD_2_16_17./aL_Fe55_Post_DD_2_16_17))';
alnn_DD_Cathode_2_16_17 = (log(adEdx_DD_Cathode_2_16_17./aL_DD_Cathode_2_16_17))';


%AvgdEdx Array variables
aAvgdEdx_Fe55_Pre_Back_12_12_16 = Fe55_Pre_Back_12_12_16_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Pre_Back_12_12_16;
aAvgdEdx_Fe55_Post_Back_12_12_16 = Fe55_Post_Back_12_12_16_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Post_Back_12_12_16;
aAvgdEdx_Back_12_12_16 = Back_12_12_16_S.matUnAvgdAdZ(:,3)'*convAtoE_Back_12_12_16;
aAvgdEdx_Fe55_Pre_Co60_12_15_16 = Fe55_Pre_Co60_12_15_16_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Pre_Co60_12_15_16;
aAvgdEdx_Fe55_Post_Co60_12_15_16 = Fe55_Post_Co60_12_15_16_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Post_Co60_12_15_16;
aAvgdEdx_Co60_12_15_16 = Co60_12_15_16_S.matUnAvgdAdZ(:,3)'*convAtoE_Co60_12_15_16;
aAvgdEdx_Fe55_Pre_DD_2_15_17 = Fe55_Pre_DD_2_15_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Pre_DD_2_15_17;
aAvgdEdx_Fe55_Post_DD_2_15_17 = Fe55_Post_DD_2_15_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Post_DD_2_15_17;
aAvgdEdx_DD_GEM_2_15_17 = DD_GEM_2_15_17_S.matUnAvgdAdZ(:,3)'*convAtoE_DD_GEM_2_15_17;
aAvgdEdx_Fe55_Pre_DD_2_16_17 = Fe55_Pre_DD_2_16_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Pre_DD_2_16_17;
aAvgdEdx_Fe55_Post_DD_2_16_17 = Fe55_Post_DD_2_16_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Post_DD_2_16_17;
aAvgdEdx_DD_Cathode_2_16_17 = DD_Cathode_2_16_17_S.matUnAvgdAdZ(:,3)'*convAtoE_DD_Cathode_2_16_17;

%Skewness Array variables
aSkewMatDD_GEM_12_15_17 = DD_GEM_2_15_17_S.aUnSkewMat;
aSkewMatDD_Cathode_12_16_17 = DD_Cathode_2_16_17_S.aUnSkewMat;

avgdEdzCut = 3;
lnCut = 0.5;
compNumBack = 2209; %Take Equal LiveTimes for Co60 and Back (135 minutes)
compNumDD_GEM = 7945;

%apply cuts to NRs (nguyen) 
% %apply cuts to Co60 (Nguyen's)
selIndNR_Co60_12_15_16 = ~selIndSat_Co60_12_15_16 & alnn_Co60_12_12_16' > lnCut;
selIndNR_Co60_12_15_16 = selIndNR_Co60_12_15_16 & aAvgdEdx_Co60_12_15_16 > avgdEdzCut;
 
% %apply cuts to Back (Nguyen's)
selIndNR_Back_12_12_16 = ~selIndSat_Back_12_12_16 & alnn_Back_12_12_16' > lnCut;
selIndNR_Back_12_12_16 = selIndNR_Back_12_12_16 & aAvgdEdx_Back_12_12_16 > avgdEdzCut;

selIndNR_DD_GEM_2_15_17 = ~selIndSat_DD_GEM_2_15_17 & alnn_DD_GEM_2_15_17' > lnCut;
selIndNR_DD_GEM_2_15_17 = selIndNR_DD_GEM_2_15_17 & aAvgdEdx_DD_GEM_2_15_17 > avgdEdzCut;

selIndNR_DD_Cathode_2_16_17 = ~selIndSat_DD_Cathode_2_16_17 & alnn_DD_Cathode_2_16_17' > lnCut;
selIndNR_DD_Cathode_2_16_17 = selIndNR_DD_Cathode_2_16_17 & aAvgdEdx_DD_Cathode_2_16_17 > avgdEdzCut;

if strcmp(sVisFe55,'on')
    figure(1);
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_Back_12_12_16.a*exp(-((x-fitA_Fe55_Pre_Back_12_12_16.x0)/fitA_Fe55_Pre_Back_12_12_16.c).^2)+fitA_Fe55_Pre_Back_12_12_16.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_Back_12_12_16.a*exp(-((x-fitA_Fe55_Post_Back_12_12_16.x0)/fitA_Fe55_Post_Back_12_12_16.c).^2)+fitA_Fe55_Post_Back_12_12_16.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre Back','Fe55 Post Back','Fit Pre Back','Fit Post Back','Location','Best');
    xlim([0 120]);

    figure(2);
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
    
    figure(3);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_DD_2_15_17.a*exp(-((x-fitA_Fe55_Pre_DD_2_15_17.x0)/fitA_Fe55_Pre_DD_2_15_17.c).^2)+fitA_Fe55_Pre_DD_2_15_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_DD_2_15_17.a*exp(-((x-fitA_Fe55_Post_DD_2_15_17.x0)/fitA_Fe55_Post_DD_2_15_17.c).^2)+fitA_Fe55_Post_DD_2_15_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre DD GEM','Fe55 Post DD GEM','Fit Pre DD GEM','Fit Post DD GEM','Location','Best');
    xlim([0 120]);
    
    figure(4);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_DD_2_16_17.a*exp(-((x-fitA_Fe55_Pre_DD_2_16_17.x0)/fitA_Fe55_Pre_DD_2_16_17.c).^2)+fitA_Fe55_Pre_DD_2_16_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_DD_2_16_17.a*exp(-((x-fitA_Fe55_Post_DD_2_16_17.x0)/fitA_Fe55_Post_DD_2_16_17.c).^2)+fitA_Fe55_Post_DD_2_16_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre DD Cathode','Fe55 Post DD Cathode','Fit Pre DD Cathode','Fit Post DD Cathode','Location','Best');
    xlim([0 120]);
end

mSize = 6;
mLineWid = 0.5;
figNum = 4;
if bPlot
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_Fe55_Pre_Back_12_12_16*convAtoE_Fe55_Pre_Back_12_12_16,aL_Fe55_Pre_Back_12_12_16,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_Back_12_12_16*convAtoE_Fe55_Pre_Back_12_12_16,aL_Fe55_Post_Back_12_12_16,'r.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(~selIndSat_Back_12_12_16)*convAtoE_Back_12_12_16,aL_Back_12_12_16(~selIndSat_Back_12_12_16),'k.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(selIndNR_Back_12_12_16)*convAtoE_Back_12_12_16,aL_Back_12_12_16(selIndNR_Back_12_12_16),'k*','LineWidth',mLineWid);
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('Fe55 Pre Back','Fe55 Post Back','Back 12-12-16','Back: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_Fe55_Pre_Co60_12_15_16*convAtoE_Fe55_Pre_Co60_12_15_16,aL_Fe55_Pre_Co60_12_15_16,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_Co60_12_15_16*convAtoE_Fe55_Post_Co60_12_15_16,aL_Fe55_Post_Co60_12_15_16,'r.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,aL_Co60_12_15_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,aL_Co60_12_15_16(selIndNR_Co60_12_15_16),'m*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('Fe55 Pre Co60','Fe55 Post Co60','Co60 12-15-16','Co60: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_Back_12_12_16(~selIndSat_Back_12_12_16)*convAtoE_Back_12_12_16,aL_Back_12_12_16(~selIndSat_Back_12_12_16),'k.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(selIndNR_Back_12_12_16)*convAtoE_Back_12_12_16,aL_Back_12_12_16(selIndNR_Back_12_12_16),'k*','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,aL_Co60_12_15_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,aL_Co60_12_15_16(selIndNR_Co60_12_15_16),'g*','LineWidth',mLineWid);        
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('Back 12-12-16','Back: NR','Co60 12-15-16','Co60: NR','Location','best');
    grid on;
    xlim([0 450]);
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_Fe55_Pre_DD_2_15_17*convAtoE_Fe55_Pre_DD_2_15_17,aL_Fe55_Pre_DD_2_15_17,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_DD_2_15_17*convAtoE_Fe55_Post_DD_2_15_17,aL_Fe55_Post_DD_2_15_17,'r.','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,aL_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17),'g.','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,aL_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17),'g*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('Fe55 Pre DD GEM','Fe55 Post DD GEM','DD GEM 12-15-17','DD GEM: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_Fe55_Pre_DD_2_16_17*convAtoE_Fe55_Pre_DD_2_16_17,aL_Fe55_Pre_DD_2_16_17,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_DD_2_16_17*convAtoE_Fe55_Post_DD_2_16_17,aL_Fe55_Post_DD_2_16_17,'r.','LineWidth',mLineWid);
    scatter(aA_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,aL_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17),'g.','LineWidth',mLineWid);
    scatter(aA_DD_Cathode_2_16_17(selIndNR_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,aL_DD_Cathode_2_16_17(selIndNR_DD_Cathode_2_16_17),'g*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('Fe55 Pre DD Cathode','Fe55 Post DD Cathode','DD Cathode 12-16-17','DD Cathode: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,aL_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17),'g.','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,aL_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17),'g*','LineWidth',mLineWid);    
    scatter(aA_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,aL_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17),'b.','LineWidth',mLineWid);
    scatter(aA_DD_Cathode_2_16_17(selIndNR_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,aL_DD_Cathode_2_16_17(selIndNR_DD_Cathode_2_16_17),'r*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('DD GEM 12-15-17','DD GEM: NR','DD Cathode 12-16-17','DD Cathode: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack))*convAtoE_Back_12_12_16,aL_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack)),'k.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack))*convAtoE_Back_12_12_16,aL_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack)),'k*','LineWidth',mLineWid);    
    scatter(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,aL_Co60_12_15_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,aL_Co60_12_15_16(selIndNR_Co60_12_15_16),'m*','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM))*convAtoE_DD_GEM_2_15_17,aL_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM)),'g.','LineWidth',mLineWid);    
    scatter(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM))*convAtoE_DD_GEM_2_15_17,aL_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM)),'g*','LineWidth',mLineWid);
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    title('Same Live Time (135min)');
    legend('Back 12-12-16','Back 12-12-16: NR','Co60 12-15-16','Co60: NR','DD GEM 7-26-16','DD GEM: NR','Location','best');
    title('135 Min Live Time');    
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aA_Fe55_Pre_Back_12_12_16*convAtoE_Fe55_Pre_Back_12_12_16,alnn_Fe55_Pre_Back_12_12_16,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_Back_12_12_16*convAtoE_Fe55_Pre_Back_12_12_16,alnn_Fe55_Post_Back_12_12_16,'r.','LineWidth',mLineWid);    
    scatter(aA_Back_12_12_16(~selIndSat_Back_12_12_16)*convAtoE_Back_12_12_16,alnn_Back_12_12_16(~selIndSat_Back_12_12_16),'k.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(selIndNR_Back_12_12_16)*convAtoE_Back_12_12_16,alnn_Back_12_12_16(selIndNR_Back_12_12_16),'k*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('Fe55 Pre Back','Fe55 Post Back','Back 12-12-16','Back: NR','Location','best');
    grid on;

    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aA_Fe55_Pre_Back_12_12_16*convAtoE_Fe55_Pre_Back_12_12_16,alnn_Fe55_Pre_Back_12_12_16,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_Back_12_12_16*convAtoE_Fe55_Pre_Back_12_12_16,alnn_Fe55_Post_Back_12_12_16,'r.','LineWidth',mLineWid);    
    scatter(aA_Back_12_12_16(~selIndSat_Back_12_12_16)*convAtoE_Back_12_12_16,alnn_Back_12_12_16(~selIndSat_Back_12_12_16),'k.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(selIndNR_Back_12_12_16)*convAtoE_Back_12_12_16,alnn_Back_12_12_16(selIndNR_Back_12_12_16),'k*','LineWidth',mLineWid);        
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('Fe55 Pre Back','Fe55 Post Back','Back 12-12-16','Back: NR','Location','best');
    grid on;
    xlim([0 250]);
    
    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aA_Fe55_Pre_DD_2_15_17*convAtoE_Fe55_Pre_DD_2_15_17,alnn_Fe55_Pre_DD_2_15_17,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_DD_2_15_17*convAtoE_Fe55_Pre_DD_2_15_17,alnn_Fe55_Post_DD_2_15_17,'r.','LineWidth',mLineWid);    
    scatter(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,alnn_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17),'g.','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,alnn_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17),'g*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('Fe55 Pre DD GEM','Fe55 Post DD GEM','DD GEM 2-15-17','DD GEM: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aA_Fe55_Pre_DD_2_15_17*convAtoE_Fe55_Pre_DD_2_15_17,alnn_Fe55_Pre_DD_2_15_17,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_DD_2_15_17*convAtoE_Fe55_Pre_DD_2_15_17,alnn_Fe55_Post_DD_2_15_17,'r.','LineWidth',mLineWid);    
    scatter(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,alnn_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17),'k.','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,alnn_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17),'k*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('Fe55 Pre DD GEM','Fe55 Post DD GEM','DD GEM 2-15-17','DD GEM: NR','Location','best');
    grid on;    
    xlim([0 450]);
    
%     figNum = figNum+1;
%     figure(figNum)
%     hold on
%     scatter(aA_Fe55_Pre_DD_2_15_17*convAtoE_Fe55_Pre_DD_2_15_17,alnn_Fe55_Pre_DD_2_15_17,'b.','LineWidth',mLineWid);
%     scatter(aA_Fe55_Post_DD_2_15_17*convAtoE_Fe55_Pre_DD_2_15_17,alnn_Fe55_Post_DD_2_15_17,'r.','LineWidth',mLineWid);    
%     scatter(aA_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,alnn_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17),'k.','LineWidth',mLineWid);
%     scatter(aA_DD_Cathode_2_16_17(selIndNR_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,alnn_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17),'k*','LineWidth',mLineWid);    
%     xlabel('E (keVee)','FontSize',20);
%     ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
%     legend('Fe55 Pre DD GEM','Fe55 Post DD GEM','DD GEM 2-15-17','DD GEM: NR','Location','best');
%     grid on;    
%     xlim([0 450]);
%     
    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aA_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack))*convAtoE_Back_12_12_16,alnn_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack)),'k.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack))*convAtoE_Back_12_12_16,alnn_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack)),'k*','LineWidth',mLineWid);    
    scatter(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,alnn_Co60_12_12_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,alnn_Co60_12_12_16(selIndNR_Co60_12_15_16),'m*','LineWidth',mLineWid);    
    scatter(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM))*convAtoE_DD_GEM_2_15_17,alnn_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM)),'g.','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM))*convAtoE_DD_GEM_2_15_17,alnn_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM)),'g*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    title('135 Min Live Time');
    legend('Back 12-12-16','Back 12-12-16: NR','Co60 12-15-16','Co60: NR','DD GEM 7-26-16','DD GEM: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aA_Fe55_Pre_Co60_12_15_16*convAtoE_Fe55_Pre_Co60_12_15_16,alnn_Fe55_Pre_Co60_12_12_16,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_Co60_12_15_16*convAtoE_Fe55_Pre_Co60_12_15_16,alnn_Fe55_Post_Co60_12_12_16,'r.','LineWidth',mLineWid);    
    scatter(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,alnn_Co60_12_12_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,alnn_Co60_12_12_16(selIndNR_Co60_12_15_16),'m*','LineWidth',mLineWid);        
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('Fe55 Pre Co60','Fe55 Post Co60','Co60 12-15-16','Co60: NR','Location','best');
    grid on;
    xlim([0 450]);
    
    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aA_Fe55_Pre_Co60_12_15_16*convAtoE_Fe55_Pre_Co60_12_15_16,alnn_Fe55_Pre_Co60_12_12_16,'b.','LineWidth',mLineWid);
    scatter(aA_Fe55_Post_Co60_12_15_16*convAtoE_Fe55_Pre_Co60_12_15_16,alnn_Fe55_Post_Co60_12_12_16,'r.','LineWidth',mLineWid);    
    scatter(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,alnn_Co60_12_12_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,alnn_Co60_12_12_16(selIndNR_Co60_12_15_16),'m*','LineWidth',mLineWid);        
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('Fe55 Pre Co60','Fe55 Post Co60','Co60 12-15-16','Co60: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack))*convAtoE_Back_12_12_16,aAvgdEdx_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack)),'k.','LineWidth',mLineWid);
    scatter(aA_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack))*convAtoE_Back_12_12_16,aAvgdEdx_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack)),'k*','LineWidth',mLineWid);    
    scatter(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,aAvgdEdx_Co60_12_15_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,aAvgdEdx_Co60_12_15_16(selIndNR_Co60_12_15_16),'m*','LineWidth',mLineWid);        
    scatter(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM))*convAtoE_DD_GEM_2_15_17,aAvgdEdx_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM)),'g.','LineWidth',mLineWid);
    scatter(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM))*convAtoE_DD_GEM_2_15_17,aAvgdEdx_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM)),'g*','LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('Avg dE/dx (keVee/mm)','FontSize',20);
    title('Same Live Time (135min)');
    legend('Back 12-12-16','Back 12-12-16: NR','Co60 12-15-16','Co60: NR','DD GEM 7-26-16','DD GEM: NR','Location','best');
    title('135 Min Live Time');    
    grid on;   
    
    
    figNum = figNum+1;
    figure(figNum)
    hold on
    scatter(aAvgdEdx_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack)),alnn_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack)),'k.','LineWidth',mLineWid);
    scatter(aAvgdEdx_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack)),alnn_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack)),'k*','LineWidth',mLineWid);    
    scatter(aAvgdEdx_Co60_12_15_16(~selIndSat_Co60_12_15_16),alnn_Co60_12_12_16(~selIndSat_Co60_12_15_16),'m.','LineWidth',mLineWid);
    scatter(aAvgdEdx_Co60_12_15_16(selIndNR_Co60_12_15_16),alnn_Co60_12_12_16(selIndNR_Co60_12_15_16),'m*','LineWidth',mLineWid);        
    scatter(aAvgdEdx_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM)),alnn_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM)),'g.','LineWidth',mLineWid);
    scatter(aAvgdEdx_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM)),alnn_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17(1:compNumDD_GEM)),'g*','LineWidth',mLineWid);        
    xlabel('avgdEdx (keVee/mm)','FontSize',20);
    ylabel('ln(n) (keVee/mm2)','FontSize',20);
    legend('Back 12-12-16','Back: NR','Co60 12-15-16','Co60: NR','DD GEM 7-26-16','DD GEM: NR','Location','best'); 
    title('135 Min Live Time');    
    grid on;
      
    figNum = figNum+1;
    figure(figNum)
    hold on;
    grid on;
    wid = 10;
    histogram(aA_Back_12_12_16(~selIndSat_Back_12_12_16)*convAtoE_Back_12_12_16,'binwidth',wid,'EdgeColor','k','DisplayStyle','stair');
    histogram(aA_Co60_12_15_16(~selIndSat_Co60_12_15_16)*convAtoE_Co60_12_15_16,'binwidth',wid,'EdgeColor','m','DisplayStyle','stair');
    histogram(aA_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,'binwidth',wid,'EdgeColor','r','DisplayStyle','stair');
    histogram(aA_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,'binwidth',wid,'EdgeColor','b','DisplayStyle','stair');    
    legend('Back 12-12-16','Co60 12-15-16','DD GEM 2-15-17','DD Cathode 2-16-17','Location','Best');
    xlabel('Energy (keVee)','FontSize',20);
    ylabel('Counts','FontSize',20);
    title('E Spec All Events');
    set(gca,'yscale','log');
    xlim([0 450]);
    
    figNum = figNum+1;
    figure(figNum)
    hold on;
    grid on;
    histogram(aA_Back_12_12_16(selIndNR_Back_12_12_16)*convAtoE_Back_12_12_16,'binwidth',wid,'EdgeColor','k','DisplayStyle','stair');
    histogram(aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16,'binwidth',wid,'EdgeColor','m','DisplayStyle','stair');
    histogram(aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17,'binwidth',wid,'EdgeColor','r','DisplayStyle','stair');
    histogram(aA_DD_Cathode_2_16_17(selIndNR_DD_Cathode_2_16_17)*convAtoE_DD_Cathode_2_16_17,'binwidth',wid,'EdgeColor','b','DisplayStyle','stair');    
    legend('Back 12-12-16','Co60 12-15-16','DD GEM 2-15-17','DD Cathode 2-16-17','Location','Best');
    xlabel('Energy (keVee)','FontSize',20);
    ylabel('Counts','FontSize',20);
    title('E Spec NR Sel Cut');
    set(gca,'yscale','log');
    xlim([0 450]);
    
    
%     figNum = figNum+1;
%     figure(figNum)
%     expEqn = 'a*exp(-b*x)+d';
%     startPoints = [40  1.0/50 0];
%     hold on;
%     grid on;
%     binWid = 50;
%     keVee_NR_back = aA_Back_12_12_16(selIndNR_Back_12_12_16(1:compNumBack))*convAtoE_Back_12_12_16;
%     keVr_NR_back = cvtTokeVr(keVee_NR_back);
%     keVee_NR_Co60 = aA_Co60_12_15_16(selIndNR_Co60_12_15_16)*convAtoE_Co60_12_15_16;
%     keVr_NR_Co60 = cvtTokeVr(keVee_NR_Co60);
%     keVee_NR_DD = aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17)*convAtoE_DD_GEM_2_15_17;
%     keVr_NR_DD = cvtTokeVr(keVee_NR_DD);    
%     
%     hNR_Back = histogram(keVr_NR_back,'binwidth',binWid,'EdgeColor','b','DisplayStyle','stair');
%     hNR_DD = histogram(keVr_NR_DD,'binwidth',binWid,'EdgeColor','b','DisplayStyle','stair');         
%     histogram(keVr_NR_back,'binwidth',binWid,'EdgeColor','m','DisplayStyle','stair');
%     legend('Back: NR 12-12-16','Co60: NR 12-15-16','Location','Best');
%     xlabel('Energy (keVr)','FontSize',20);
%     ylabel('Counts','FontSize',20);
%     title('135 Min Live Time');    
    
    figNum = figNum+1;
    figure(figNum)
    hold on;
    grid on;
    histogram(alnn_Fe55_Pre_Back_12_12_16','binwidth',0.1,'EdgeColor','b','DisplayStyle','stair');
    histogram(alnn_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack))','binwidth',0.1,'EdgeColor','k','DisplayStyle','stair');
    histogram(alnn_Co60_12_12_16(~selIndSat_Co60_12_15_16)','binwidth',0.1,'EdgeColor','m','DisplayStyle','stair');
    histogram(alnn_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM))','binwidth',0.1,'EdgeColor','g','DisplayStyle','stair');    
    histogram(alnn_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17)','binwidth',0.1,'EdgeColor','r','DisplayStyle','stair');    
    legend('Fe55 Pre Back','Back 12-12-16','Co60 12-15-16','DD GEM 2-15-17','DD Cathode 2-16-17','Location','Best');
    xlabel('ln(\eta) (keVee/mm2)','FontSize',20);
    ylabel('Counts','FontSize',20);
    set(gca,'yscale','log');
    title('135 Min Live Time');    
    
    figNum = figNum+1;
    figure(figNum)
    hold on;
    grid on;
    histogram(aAvgdEdx_Fe55_Pre_Back_12_12_16,'binwidth',1,'EdgeColor','b','DisplayStyle','stair');
    histogram(aAvgdEdx_Back_12_12_16(~selIndSat_Back_12_12_16(1:compNumBack)),'binwidth',1,'EdgeColor','k','DisplayStyle','stair');
    histogram(aAvgdEdx_Co60_12_15_16(~selIndSat_Co60_12_15_16),'binwidth',1,'EdgeColor','m','DisplayStyle','stair');    
    histogram(aAvgdEdx_DD_GEM_2_15_17(~selIndSat_DD_GEM_2_15_17(1:compNumDD_GEM)),'binwidth',1,'EdgeColor','g','DisplayStyle','stair');
    histogram(aAvgdEdx_DD_Cathode_2_16_17(~selIndSat_DD_Cathode_2_16_17),'binwidth',1,'EdgeColor','r','DisplayStyle','stair');        
    legend('Fe55 Pre Back','Back 12-12-16','Co60 12-15-16','DD GEM 2-15-17','DD Cathode 2-16-17','Location','Best');
    xlabel('avgdE/dx (keVee/mm)','FontSize',20);
    ylabel('Counts','FontSize',20);
    set(gca,'yscale','log');
    title('135 Min Live Time');

    if bPlotSkew
        figNum = figNum+1;
        figure(figNum)
        hold on
        
        pltEwid = 50;
        aPltE = 0:pltEwid:350;
        aSkMat_NR_GEM_vsE = zeros(1,length(aPltE));
        aErrSkMat_NR_GEM_vsE = zeros(1,length(aPltE));
        aSkMat_NR_GEM_vsE_rmL = zeros(1,length(aPltE));
        aErrSkMat_NR_GEM_vsE_rmL = zeros(1,length(aPltE));

        aMeanE_NR_GEM_vsE = zeros(1,length(aPltE));
        aErrE_NR_GEM_vsE = zeros(1,length(aPltE));

        aSkMat_NR_Cathode_vsE = zeros(1,length(aPltE));
        aErrSkMat_NR_Cathode_vsE = zeros(1,length(aPltE));
        aSkMat_NR_Cathode_vsE_rmL = zeros(1,length(aPltE));
        aErrSkMat_NR_Cathode_vsE_rmL = zeros(1,length(aPltE));
        
        aMeanE_NR_Cathode_vsE = zeros(1,length(aPltE));
        aErrE_NR_Cathode_vsE = zeros(1,length(aPltE));

        aForFracMat_NR_GEM_vsE = zeros(1,length(aPltE));
        aForFracMat_NR_Cathode_vsE = zeros(1,length(aPltE));
        
        n = 1;
        for pltE=aPltE
            tempMat_NR_GEM =  aSkewMatDD_GEM_12_15_17(selIndNR_DD_GEM_2_15_17 & aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17>=pltE & aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17<=pltE+pltEwid);
            tempE_NR_GEM =  aA_DD_GEM_2_15_17(selIndNR_DD_GEM_2_15_17 & aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17>=pltE & aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17<=pltE+pltEwid)*convAtoE_DD_GEM_2_15_17;
            tempMat_NR_Cathode =  aSkewMatDD_Cathode_12_16_17(selIndNR_DD_Cathode_2_16_17 & aA_DD_Cathode_2_16_17*convAtoE_DD_Cathode_2_16_17>=pltE & aA_DD_Cathode_2_16_17*convAtoE_DD_Cathode_2_16_17<=pltE+pltEwid);
            tempE_NR_Cathode =  aA_DD_Cathode_2_16_17(selIndNR_DD_Cathode_2_16_17 & aA_DD_Cathode_2_16_17*convAtoE_DD_Cathode_2_16_17>=pltE & aA_DD_Cathode_2_16_17*convAtoE_DD_Cathode_2_16_17<=pltE+pltEwid)*convAtoE_DD_Cathode_2_16_17;
            if isempty(tempMat_NR_GEM)
                break;
            end
            midEbin = pltE+pltEwid/2;
            aMeanE_NR_GEM_vsE(n) = mean(tempE_NR_GEM);
            aErrE_NR_GEM_vsE(n) = std(tempE_NR_GEM)/sqrt(length(tempE_NR_GEM));

            aMeanE_NR_Cathode_vsE(n) = mean(tempE_NR_Cathode);
            aErrE_NR_Cathode_vsE(n) = std(tempE_NR_Cathode)/sqrt(length(tempE_NR_Cathode));
            
            aSkMat_NR_GEM_vsE(n) = mean(tempMat_NR_GEM);
            aErrSkMat_NR_GEM_vsE(n) = std(tempMat_NR_GEM)/sqrt(length(tempMat_NR_GEM));
            aSkMat_NR_GEM_vsE_rmL(n) = mean(tempMat_NR_GEM);
            aErrSkMat_NR_GEM_vsE_rmL(n) = std(tempMat_NR_GEM)/sqrt(length(tempMat_NR_GEM));
            
            aSkMat_NR_Cathode_vsE(n) = mean(tempMat_NR_Cathode);
            aErrSkMat_NR_Cathode_vsE(n) = std(tempMat_NR_Cathode)/sqrt(length(tempMat_NR_Cathode));
            aSkMat_NR_Cathode_vsE_rmL(n) = mean(tempMat_NR_Cathode);
            aErrSkMat_NR_Cathode_vsE_rmL(n) = std(tempMat_NR_Cathode)/sqrt(length(tempMat_NR_Cathode));

            aForFracMat_NR_GEM_vsE(n) = 100*sum(tempMat_NR_GEM>0)/length(tempMat_NR_GEM);
            aForFracMat_NR_Cathode_vsE(n) = 100*sum(tempMat_NR_Cathode>0)/length(tempMat_NR_Cathode);
            n = n+1;
        end
        h1 = errorbar(aPltE+pltEwid/2,aSkMat_NR_GEM_vsE,aErrSkMat_NR_GEM_vsE,'g.-','Linewidth',2);
        herrorbar(aPltE+pltEwid/2,aSkMat_NR_GEM_vsE,aErrE_NR_GEM_vsE,'g.');
        h2 = errorbar(aPltE+pltEwid/2,aSkMat_NR_Cathode_vsE,aErrSkMat_NR_Cathode_vsE,'k.-','Linewidth',2);
        herrorbar(aPltE+pltEwid/2,aSkMat_NR_Cathode_vsE,aErrE_NR_Cathode_vsE,'k.');
        legend([h1 h2],{'DD GEM: NR','DD Cathode: NR'},'Location','best');
        grid on;
        xlabel('E (keV)','FontSize',20);
        ylabel('Skewness','FontSize',20);
        title('Skewness vs Energy');
               
%         figNum = figNum+1;
%         figure(figNum)
%         hold on;
%         plot(aPltE+pltEwid/2,aForFracMat_NR_GEM_vsE,'gd-');
%         plot(aPltE+pltEwid/2,aForFracMat_NR_Cathode_vsE,'kd-');
%         legend('DD GEM: NR','Location','Best');
%         grid on;
%         title('Forward Fraction (Laser Mean Removed)');
%         xlabel('E_min (keV)','FontSize',20);
%         ylabel('Percent Forward','FontSize',20);
    end
end

% deadTperTrig = 0.814742268;
deadTperTrig = 0.77;
convSecToHrs = 60*60;
eThr = 50;
Ttot_Back_12_12_16 = 541*60;
Ttot_Co60_12_15_16 = 242*60;
Ttot_DD_GEM_2_15_17 = 301*60;
Ttot_DD_Cath_2_16_17 = 285*60;

c_B_gr = sum(aA_Back_12_12_16*convAtoE_Back_12_12_16>=eThr);
cNR_B_gr = sum(selIndNR_Back_12_12_16 & aA_Back_12_12_16*convAtoE_Back_12_12_16>=eThr)
cNR_Co60_gr = sum(selIndNR_Co60_12_15_16 & aA_Co60_12_15_16*convAtoE_Co60_12_15_16>=eThr)
c_Co60_gr = sum(aA_Co60_12_15_16*convAtoE_Co60_12_15_16>=eThr);
cNR_DD_GEM_gr = sum(selIndNR_DD_GEM_2_15_17 & aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17>=eThr)
c_DD_GEM_gr = sum(aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17>=eThr);
cNR_DD_Cath_gr = sum(selIndNR_DD_Cathode_2_16_17 & aA_DD_Cathode_2_16_17*convAtoE_DD_Cathode_2_16_17>=eThr)
c_DD_Cath_gr = sum(aA_DD_Cathode_2_16_17*convAtoE_DD_GEM_2_15_17>=eThr);

mr_B_gr_r = c_B_gr/Ttot_Back_12_12_16;
mr_Co60_gr_r = c_Co60_gr/Ttot_Co60_12_15_16;
mr_DD_GEM_gr_r = c_DD_GEM_gr/Ttot_DD_GEM_2_15_17;
mr_DD_Cath_gr_r = c_DD_Cath_gr/Ttot_DD_Cath_2_16_17;

corr_B_gr_r = convSecToHrs*mr_B_gr_r/(1-deadTperTrig*mr_B_gr_r);
corr_Co60_gr_r = convSecToHrs*mr_Co60_gr_r/(1-deadTperTrig*mr_Co60_gr_r);
corr_DD_GEM_gr_r = convSecToHrs*mr_DD_GEM_gr_r/(1-deadTperTrig*mr_DD_GEM_gr_r);
corr_DD_Cath_gr_r = convSecToHrs*mr_DD_Cath_gr_r/(1-deadTperTrig*mr_DD_Cath_gr_r);


mr_B_gr_r = convSecToHrs*mr_B_gr_r;
mr_Co60_gr_r = convSecToHrs*mr_Co60_gr_r;
mr_DD_GEM_gr_r = convSecToHrs*mr_DD_GEM_gr_r;
mr_DD_Cath_gr_r = convSecToHrs*mr_DD_Cath_gr_r;

mrNR_B_gr_r = cNR_B_gr/Ttot_Back_12_12_16;
mrNR_Co60_gr_r = cNR_Co60_gr/Ttot_Co60_12_15_16;
mrNR_DD_GEM_gr_r = cNR_DD_GEM_gr/Ttot_DD_GEM_2_15_17;
mrNR_DD_Cath_gr_r = cNR_DD_Cath_gr/Ttot_DD_Cath_2_16_17;

corrNR_B_gr_r = convSecToHrs*mrNR_B_gr_r/(1-deadTperTrig*mrNR_B_gr_r)
corrNR_Co60_gr_r = convSecToHrs*mrNR_Co60_gr_r/(1-deadTperTrig*mrNR_Co60_gr_r)
corrNR_DD_GEM_gr_r = convSecToHrs*mrNR_DD_GEM_gr_r/(1-deadTperTrig*mrNR_DD_GEM_gr_r)
corrNR_DD_Cath_gr_r = convSecToHrs*mrNR_DD_Cath_gr_r/(1-deadTperTrig*mrNR_DD_Cath_gr_r)

mrNR_B_gr_r = convSecToHrs*mrNR_B_gr_r
mrNR_Co60_gr_r = convSecToHrs*mrNR_Co60_gr_r
mrNR_DD_GEM_gr_r = convSecToHrs*mrNR_DD_GEM_gr_r
mrNR_DD_Cath_gr_r = convSecToHrs*mrNR_DD_Cath_gr_r