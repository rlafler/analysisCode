% close all;clear;clc;

bPlotSkew = true;
bPlotOtherScat = false;
bPlot = false;
sVisFe55 = 'off';

cCath_23 = 'g';
mCath_23 = '+';
cCath_25 = 'b';
mCath_25 = 'x';
cGEM_8 = 'r';
mGEM_8 = '>';
cGEM_9 = 'm';
mGEM_9 = '<';
cBack = 'k';
mBack = '*';
% conversion to keVr
[cvtTokeVr, cvtTokeVee] = fit_keVee_to_keVr();

%Load Data Files
Fe55_Pre_DD_2_23_17_S = load('./figures/2-23-17/fe55_Pre_DD_2_23_17.mat');
DD_Cathode_2_23_17_S = load('./figures/2-23-17/DD_Cathode_2_23_17.mat');
Fe55_Post_DD_2_23_17_S = load('./figures/2-23-17/fe55_Post_DD_2_23_17.mat');

Fe55_Pre_DD_2_25_17_S = load('./figures/2-25-17/fe55_Pre_DD_Cathode_2_25_17.mat');
DD_Cathode_2_25_17_S = load('./figures/2-25-17/DD_Cathode_2_25_17.mat');
Fe55_Post_DD_2_25_17_S = load('./figures/2-25-17/fe55_Post_DD_Cathode_2_25_17.mat');

Fe55_Pre_Background_3_1_17_S = load('./figures/3-1-17/fe55_Pre_Background_3_1_17.mat');
Background_3_1_17_S = load('./figures/3-1-17/Background_3_1_17.mat');
Fe55_Post_Background_3_1_17_S = load('./figures/3-1-17/fe55_Post_Background_3_1_17.mat');

Fe55_Pre_DD_3_8_17_S = load('./figures/3-8-17/fe55_Pre_DD_GEM_3_8_17.mat');
DD_GEM_3_8_17_S = load('./figures/3-8-17/DD_GEM_3_8_17.mat');
Fe55_Post_DD_3_8_17_S = load('./figures/3-8-17/fe55_Post_DD_GEM_3_8_17.mat');

Fe55_Pre_DD_3_9_17_S = load('./figures/3-9-17/fe55_Pre_DD_GEM_3_9_17.mat');
DD_GEM_3_9_17_S = load('./figures/3-9-17/DD_GEM_3_9_17.mat');
Fe55_Post_DD_3_9_17_S = load('./figures/3-9-17/fe55_Post_DD_GEM_3_9_17.mat');

Fe55_Pre_Co60_3_13_17_S = load('./figures/3-13-17/fe55_Pre_Co60_3_13_17.mat');
Co60_3_13_17_S = load('./figures/3-13-17/Co60_3_13_17.mat');
Fe55_Post_Co60_3_13_17_S = load('./figures/3-13-17/fe55_Post_Co60_3_13_17.mat');

%Find Saturated Events
saturatedV = 1.30199;
selIndSat_DD_Cathode_2_23_17 = DD_Cathode_2_23_17_S.aUnVPriMax > saturatedV;
selIndSat_DD_Cathode_2_25_17 = DD_Cathode_2_25_17_S.aUnVPriMax > saturatedV;
selIndSat_Background_3_1_17 = Background_3_1_17_S.aUnVPriMax > saturatedV;
selIndSat_DD_Cathode = [selIndSat_DD_Cathode_2_23_17,selIndSat_DD_Cathode_2_25_17];
selIndSat_DD_GEM_3_8_17 = DD_GEM_3_8_17_S.aUnVPriMax > saturatedV;
selIndSat_DD_GEM_3_9_17 = DD_GEM_3_9_17_S.aUnVPriMax > saturatedV;
selIndSat_DD_GEM = [selIndSat_DD_GEM_3_8_17,selIndSat_DD_GEM_3_9_17];
selIndSat_Co60_3_13_17 = Co60_3_13_17.aUnVPriMax > saturatedV;
selIndSat_Co60 = [selIndSat_Co60_3_13_17];

%Total Area Array variables
aA_Fe55_Pre_DD_2_23_17 = Fe55_Pre_DD_2_23_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_DD_2_23_17 = Fe55_Post_DD_2_23_17_S.matUnEvRegA(:,1)';
aA_DD_Cathode_2_23_17 = DD_Cathode_2_23_17_S.matUnEvRegA(:,1)';

aA_Fe55_Pre_DD_2_25_17 = Fe55_Pre_DD_2_25_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_DD_2_25_17 = Fe55_Post_DD_2_25_17_S.matUnEvRegA(:,1)';
aA_DD_Cathode_2_25_17 = DD_Cathode_2_25_17_S.matUnEvRegA(:,1)';

aA_Fe55_Pre_Background_3_1_17 = Fe55_Pre_Background_3_1_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_Background_3_1_17 = Fe55_Post_Background_3_1_17_S.matUnEvRegA(:,1)';
aA_Background_3_1_17 = Background_3_1_17_S.matUnEvRegA(:,1)';

aA_Fe55_Pre_DD_3_8_17 = Fe55_Pre_DD_3_8_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_DD_3_8_17 = Fe55_Post_DD_3_8_17_S.matUnEvRegA(:,1)';
aA_DD_GEM_3_8_17 = DD_GEM_3_8_17_S.matUnEvRegA(:,1)';

aA_Fe55_Pre_DD_3_9_17 = Fe55_Pre_DD_3_9_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_DD_3_9_17 = Fe55_Post_DD_3_9_17_S.matUnEvRegA(:,1)';
aA_DD_GEM_3_9_17 = DD_GEM_3_9_17_S.matUnEvRegA(:,1)';

aA_Fe55_Pre_Co60_3_13_17 = Fe55_Pre_Co60_3_13_17_S.matUnEvRegA(:,1)';
aA_Fe55_Post_Co60_3_13_17 = Fe55_Post_Co60_3_13_17_S.matUnEvRegA(:,1)';
aA_Co60_3_13_17 = Co60_3_13_17_S.matUnEvRegA(:,1)';

if ~exist('convAtoE_Fe55_Pre_DD_2_23_17','var') 
    binWid = 2;
    gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
    startPoints = [120  40 20 0.5];
    if strcmp(sVisFe55,'on')
        figure(1);
        hold on;
    end
    hA_Fe55_Pre_DD_2_23_17 = histogram(aA_Fe55_Pre_DD_2_23_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_DD_2_23_17 = hA_Fe55_Pre_DD_2_23_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_DD_2_23_17 = hA_Fe55_Pre_DD_2_23_17.Values;

    hA_Fe55_Post_DD_2_23_17 = histogram(aA_Fe55_Post_DD_2_23_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_DD_2_23_17 = hA_Fe55_Post_DD_2_23_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_DD_2_23_17 = hA_Fe55_Post_DD_2_23_17.Values;

    %Fit distributions to find x0
    fitA_Fe55_Pre_DD_2_23_17 = fit(aArea_Fe55_Pre_DD_2_23_17',aCount_Fe55_Pre_DD_2_23_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_DD_2_23_17 = fit(aArea_Fe55_Post_DD_2_23_17',aCount_Fe55_Post_DD_2_23_17',gaussEqn,'Start', startPoints);
end

if ~exist('convAtoE_Fe55_Pre_DD_2_25_17','var') 
    binWid = 2;
    gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
    startPoints = [120  40 20 0.5];
    if strcmp(sVisFe55,'on')
        figure(2);
        hold on;
    end
    hA_Fe55_Pre_DD_2_25_17 = histogram(aA_Fe55_Pre_DD_2_25_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_DD_2_25_17 = hA_Fe55_Pre_DD_2_25_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_DD_2_25_17 = hA_Fe55_Pre_DD_2_25_17.Values;

    hA_Fe55_Post_DD_2_25_17 = histogram(aA_Fe55_Post_DD_2_25_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_DD_2_25_17 = hA_Fe55_Post_DD_2_25_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_DD_2_25_17 = hA_Fe55_Post_DD_2_25_17.Values;

    %Fit distributions to find x0
    fitA_Fe55_Pre_DD_2_25_17 = fit(aArea_Fe55_Pre_DD_2_25_17',aCount_Fe55_Pre_DD_2_25_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_DD_2_25_17 = fit(aArea_Fe55_Post_DD_2_25_17',aCount_Fe55_Post_DD_2_25_17',gaussEqn,'Start', startPoints);
end

if ~exist('convAtoE_Fe55_Pre_Background_3_1_17','var') 
    binWid = 2;
    gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
    startPoints = [120  40 20 0.5];
    if strcmp(sVisFe55,'on')
        figure(3);
        hold on;
    end
    hA_Fe55_Pre_Background_3_1_17 = histogram(aA_Fe55_Pre_Background_3_1_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_Background_3_1_17 = hA_Fe55_Pre_Background_3_1_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_Background_3_1_17 = hA_Fe55_Pre_Background_3_1_17.Values;

    hA_Fe55_Post_Background_3_1_17 = histogram(aA_Fe55_Post_Background_3_1_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_Background_3_1_17 = hA_Fe55_Post_Background_3_1_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_Background_3_1_17 = hA_Fe55_Post_Background_3_1_17.Values;

    %Fit distributions to find x0
    fitA_Fe55_Pre_Background_3_1_17 = fit(aArea_Fe55_Pre_Background_3_1_17',aCount_Fe55_Pre_Background_3_1_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_Background_3_1_17 = fit(aArea_Fe55_Post_Background_3_1_17',aCount_Fe55_Post_Background_3_1_17',gaussEqn,'Start', startPoints);
end

if ~exist('convAtoE_Fe55_Pre_DD_3_8_17','var') 
    binWid = 2;
    gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
    startPoints = [120  40 20 0.5];
    if strcmp(sVisFe55,'on')
        figure(4);
        hold on;
    end
    hA_Fe55_Pre_DD_3_8_17 = histogram(aA_Fe55_Pre_DD_3_8_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_DD_3_8_17 = hA_Fe55_Pre_DD_3_8_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_DD_3_8_17 = hA_Fe55_Pre_DD_3_8_17.Values;

    hA_Fe55_Post_DD_3_8_17 = histogram(aA_Fe55_Post_DD_3_8_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_DD_3_8_17 = hA_Fe55_Post_DD_3_8_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_DD_3_8_17 = hA_Fe55_Post_DD_3_8_17.Values;

    %Fit distributions to find x0
    fitA_Fe55_Pre_DD_3_8_17 = fit(aArea_Fe55_Pre_DD_3_8_17',aCount_Fe55_Pre_DD_3_8_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_DD_3_8_17 = fit(aArea_Fe55_Post_DD_3_8_17',aCount_Fe55_Post_DD_3_8_17',gaussEqn,'Start', startPoints);
end

if ~exist('convAtoE_Fe55_Pre_DD_3_9_17','var') 
    binWid = 2;
    gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
    startPoints = [120  40 20 0.5];
    if strcmp(sVisFe55,'on')
        figure(5);
        hold on;
    end
    hA_Fe55_Pre_DD_3_9_17 = histogram(aA_Fe55_Pre_DD_3_9_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_DD_3_9_17 = hA_Fe55_Pre_DD_3_9_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_DD_3_9_17 = hA_Fe55_Pre_DD_3_9_17.Values;

    hA_Fe55_Post_DD_3_9_17 = histogram(aA_Fe55_Post_DD_3_9_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_DD_3_9_17 = hA_Fe55_Post_DD_3_9_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_DD_3_9_17 = hA_Fe55_Post_DD_3_9_17.Values;

    %Fit distributions to find x0
    fitA_Fe55_Pre_DD_3_9_17 = fit(aArea_Fe55_Pre_DD_3_9_17',aCount_Fe55_Pre_DD_3_9_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_DD_3_9_17 = fit(aArea_Fe55_Post_DD_3_9_17',aCount_Fe55_Post_DD_3_9_17',gaussEqn,'Start', startPoints);
end

if ~exist('convAtoE_Fe55_Pre_Co60_3_13_17','var') 
    binWid = 2;
    gaussEqn = 'a*exp(-((x-x0)/c)^2)+d';
    startPoints = [120  40 20 0.5];
    if strcmp(sVisFe55,'on')
        figure(5);
        hold on;
    end
    hA_Fe55_Pre_Co60_3_13_17 = histogram(aA_Fe55_Pre_Co60_3_13_17,'binwidth',binWid,'EdgeColor','g','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Pre_Co60_3_13_17 = hA_Fe55_Pre_Co60_3_13_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Pre_Co60_3_13_17 = hA_Fe55_Pre_Co60_3_13_17.Values;

    hA_Fe55_Post_Co60_3_13_17 = histogram(aA_Fe55_Post_Co60_3_13_17,'binwidth',binWid,'EdgeColor','r','DisplayStyle','stair','visible',sVisFe55);
    aArea_Fe55_Post_Co60_3_13_17 = hA_Fe55_Post_Co60_3_13_17.BinEdges(1:end-1)+binWid/2;
    aCount_Fe55_Post_Co60_3_13_17 = hA_Fe55_Post_Co60_3_13_17.Values;

    %Fit distributions to find x0
    fitA_Fe55_Pre_Co60_3_13_17 = fit(aArea_Fe55_Pre_Co60_3_13_17',aCount_Fe55_Pre_Co60_3_13_17',gaussEqn,'Start', startPoints);
    fitA_Fe55_Post_DD_Co60_3_13_17 = fit(aArea_Fe55_Post_Co60_3_13_17',aCount_Fe55_Post_Co60_3_13_17',gaussEqn,'Start', startPoints);
end

%Energy Calibration variables
convAtoE_Fe55_Pre_DD_2_23_17 = 5.9/fitA_Fe55_Pre_DD_2_23_17.x0;
convAtoE_Fe55_Post_DD_2_23_17 = 5.9/fitA_Fe55_Post_DD_2_23_17.x0;
% convAtoE_DD_Cathode_2_23_17 = (convAtoE_Fe55_Pre_DD_2_23_17+convAtoE_Fe55_Post_DD_2_23_17)/2;
convAtoE_DD_Cathode_2_23_17 = (convAtoE_Fe55_Post_DD_2_23_17);

convAtoE_Fe55_Pre_DD_2_25_17 = 5.9/fitA_Fe55_Pre_DD_2_25_17.x0;
convAtoE_Fe55_Post_DD_2_25_17 = 5.9/fitA_Fe55_Post_DD_2_25_17.x0;
convAtoE_DD_Cathode_2_25_17 = (convAtoE_Fe55_Post_DD_2_25_17);
% convAtoE_DD_Cathode_2_25_17 = (convAtoE_Fe55_Pre_DD_2_25_17+convAtoE_Fe55_Post_DD_2_25_17)/2;

convAtoE_Fe55_Pre_Background_3_1_17 = 5.9/fitA_Fe55_Pre_Background_3_1_17.x0;
convAtoE_Fe55_Post_Background_3_1_17 = 5.9/fitA_Fe55_Post_Background_3_1_17.x0;
convAtoE_Background_3_1_17 = (convAtoE_Fe55_Post_Background_3_1_17);

% convAtoE_Background_3_1_17 = (convAtoE_Fe55_Pre_Background_3_1_17+convAtoE_Fe55_Post_Background_3_1_17)/2;
convAtoE_Fe55_Pre_DD_3_8_17 = 5.9/fitA_Fe55_Pre_DD_3_8_17.x0;
convAtoE_Fe55_Post_DD_3_8_17 = 5.9/fitA_Fe55_Post_DD_3_8_17.x0;
convAtoE_DD_GEM_3_8_17 = (convAtoE_Fe55_Pre_DD_3_8_17+convAtoE_Fe55_Post_DD_3_8_17)/2;

convAtoE_Fe55_Pre_DD_3_9_17 = 5.9/fitA_Fe55_Pre_DD_3_9_17.x0;
convAtoE_Fe55_Post_DD_3_9_17 = 5.9/fitA_Fe55_Post_DD_3_9_17.x0;
convAtoE_DD_GEM_3_9_17 = (convAtoE_Fe55_Pre_DD_3_9_17+convAtoE_Fe55_Post_DD_3_9_17)/2;

convAtoE_Fe55_Pre_Co60_3_13_17 = 5.9/fitA_Fe55_Pre_Co60_3_13_17.x0;
convAtoE_Fe55_Post_Co60_3_13_17 = 5.9/fitA_Fe55_Post_Co60_3_13_17.x0;
convAtoE_Co60_3_13_17 = (convAtoE_Fe55_Pre_Co60_3_13_17+convAtoE_Fe55_Post_Co60_3_13_17)/2;

%Total E Array variables
aE_DD_Cathode = [aA_DD_Cathode_2_23_17*convAtoE_DD_Cathode_2_23_17, ...
    aA_DD_Cathode_2_25_17*convAtoE_DD_Cathode_2_25_17];
aE_DD_GEM = [aA_DD_GEM_3_8_17*convAtoE_DD_GEM_3_8_17,aA_DD_GEM_3_9_17*convAtoE_DD_GEM_3_9_17];
aE_Co60 = [aA_Co60_3_13_17*convAtoE_Co60_3_13_17];

%Length Array variables
aL_Fe55_Pre_DD_2_23_17 = Fe55_Pre_DD_2_23_17_S.matUnEvRegZ(:,3)';
aL_Fe55_Post_DD_2_23_17 = Fe55_Post_DD_2_23_17_S.matUnEvRegZ(:,3)';
aL_DD_Cathode_2_23_17 = DD_Cathode_2_23_17_S.matUnEvRegZ(:,3)';
aL_DD_Cathode_2_25_17 = DD_Cathode_2_25_17_S.matUnEvRegZ(:,3)';
aL_Background_3_1_17 = Background_3_1_17_S.matUnEvRegZ(:,3)';
aL_DD_Cathode = [aL_DD_Cathode_2_23_17,aL_DD_Cathode_2_25_17];
aL_DD_GEM_3_8_17 = DD_GEM_3_8_17_S.matUnEvRegZ(:,3)';
aL_DD_GEM_3_9_17 = DD_GEM_3_9_17_S.matUnEvRegZ(:,3)';
aL_DD_GEM = [aL_DD_GEM_3_8_17,aL_DD_GEM_3_9_17];
aL_Co60_3_13_17 = Co60_3_13_17_S.matUnEvRegZ(:,3)';
aL_Co60_3_13 = [aL_Co60_3_13];

%Max dE/dx Array variables
adEdx_Fe55_Pre_DD_2_23_17 = Fe55_Pre_DD_2_23_17_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Pre_DD_2_23_17;
adEdx_Fe55_Post_DD_2_23_17 = Fe55_Post_DD_2_23_17_S.matUnIPriMax(:,1)'*convAtoE_Fe55_Post_DD_2_23_17;
adEdx_DD_Cathode_2_23_17 = DD_Cathode_2_23_17_S.matUnIPriMax(:,1)'*convAtoE_DD_Cathode_2_23_17;
adEdx_DD_Cathode_2_25_17 = DD_Cathode_2_25_17_S.matUnIPriMax(:,1)'*convAtoE_DD_Cathode_2_25_17;
adEdx_Background_3_1_17 = Background_3_1_17_S.matUnIPriMax(:,1)'*convAtoE_Background_3_1_17;
adEdx_DD_Cathode = [adEdx_DD_Cathode_2_23_17,adEdx_DD_Cathode_2_25_17];
adEdx_DD_GEM_3_8_17 = DD_GEM_3_8_17_S.matUnIPriMax(:,1)'*convAtoE_DD_GEM_3_8_17;
adEdx_DD_GEM_3_9_17 = DD_GEM_3_9_17_S.matUnIPriMax(:,1)'*convAtoE_DD_GEM_3_9_17;
adEdx_DD_GEM = [adEdx_DD_GEM_3_8_17,adEdx_DD_GEM_3_9_17];
adEdx_Co60_3_13_17 = Co60_3_13_17_S.matUnIPriMax(:,1)'*convAtoE_Co60_3_13_17;
adEdx_Co60_3_13 = [adEdx_Co60_3_13_17];

%ln(n) Array variables
alnn_Fe55_Pre_DD_2_23_17 = (log(adEdx_Fe55_Pre_DD_2_23_17./aL_Fe55_Pre_DD_2_23_17))';
alnn_Fe55_Post_DD_2_23_17 = (log(adEdx_Fe55_Post_DD_2_23_17./aL_Fe55_Post_DD_2_23_17))';
alnn_DD_Cathode_2_23_17 = (log(adEdx_DD_Cathode_2_23_17./aL_DD_Cathode_2_23_17));
alnn_DD_Cathode_2_25_17 = (log(adEdx_DD_Cathode_2_25_17./aL_DD_Cathode_2_25_17));
alnn_Background_3_1_17 = (log(adEdx_Background_3_1_17./aL_Background_3_1_17));
alnn_DD_Cathode = [alnn_DD_Cathode_2_23_17,alnn_DD_Cathode_2_25_17];
alnn_DD_GEM_3_8_17 = (log(adEdx_DD_GEM_3_8_17./aL_DD_GEM_3_8_17));
alnn_DD_GEM_3_9_17 = (log(adEdx_DD_GEM_3_9_17./aL_DD_GEM_3_9_17));
alnn_Co60_3_13_17 = (log(adEdx_Co60_3_13_17./aL_Co60_3_13_17));

%AvgdEdx Array variables
aAvgdEdx_Fe55_Pre_DD_2_23_17 = Fe55_Pre_DD_2_23_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Pre_DD_2_23_17;
aAvgdEdx_Fe55_Post_DD_2_23_17 = Fe55_Post_DD_2_23_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Fe55_Post_DD_2_23_17;
aAvgdEdx_DD_Cathode_2_23_17 = DD_Cathode_2_23_17_S.matUnAvgdAdZ(:,3)'*convAtoE_DD_Cathode_2_23_17;
aAvgdEdx_DD_Cathode_2_25_17 = DD_Cathode_2_25_17_S.matUnAvgdAdZ(:,3)'*convAtoE_DD_Cathode_2_25_17;
aAvgdEdx_Background_3_1_17 = Background_3_1_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Background_3_1_17;
aAvgdEdx_DD_Cathode = [aAvgdEdx_DD_Cathode_2_23_17,aAvgdEdx_DD_Cathode_2_25_17];
aAvgdEdx_DD_GEM_3_8_17 = DD_GEM_3_8_17_S.matUnAvgdAdZ(:,3)'*convAtoE_DD_GEM_3_8_17;
aAvgdEdx_DD_GEM_3_9_17 = DD_GEM_3_9_17_S.matUnAvgdAdZ(:,3)'*convAtoE_DD_GEM_3_9_17;
aAvgdEdx_DD_GEM = [aAvgdEdx_DD_GEM_3_8_17,aAvgdEdx_DD_GEM_3_9_17];
aAvgdEdx_Co60_3_13_17 = Co60_3_13_17_S.matUnAvgdAdZ(:,3)'*convAtoE_Co60_3_13_17;
aAvgdEdx_Co60 = [aAvgdEdx_Co60_3_13_17];

%Skewness Array variables
% aSkewMatDD_GEM_12_25_17 = DD_GEM_2_25_17_S.aUnSkewMat;
aSkewMatDD_Cathode_2_23_17 = DD_Cathode_2_23_17_S.aUnSkewMat;
aSkewMatDD_Cathode_2_25_17 = DD_Cathode_2_25_17_S.aUnSkewMat;
aSkewMatDD_Cathode = [aSkewMatDD_Cathode_2_23_17,aSkewMatDD_Cathode_2_25_17];
aSkewMatDD_GEM_3_8_17 = DD_GEM_3_8_17_S.aUnSkewMat;
aSkewMatDD_GEM_3_9_17 = DD_GEM_3_9_17_S.aUnSkewMat;
aSkewMatDD_GEM = [aSkewMatDD_GEM_3_8_17,aSkewMatDD_GEM_3_9_17];

avgdEdzCut = 5;
lnCut = 0.5;
compNumBack = 2209; %Take Equal LiveTimes for Co60 and Back (135 minutes)
compNumDD_GEM = 7945;

%apply cuts to NRs (nguyen)
selIndNR_DD_Cathode_2_23_17 = ~selIndSat_DD_Cathode_2_23_17 & alnn_DD_Cathode_2_23_17 > lnCut;
selIndNR_DD_Cathode_2_23_17 = selIndNR_DD_Cathode_2_23_17 & aAvgdEdx_DD_Cathode_2_23_17 > avgdEdzCut;

selIndNR_DD_Cathode_2_25_17 = ~selIndSat_DD_Cathode_2_25_17 & alnn_DD_Cathode_2_25_17 > lnCut;
selIndNR_DD_Cathode_2_25_17 = selIndNR_DD_Cathode_2_25_17 & aAvgdEdx_DD_Cathode_2_25_17 > avgdEdzCut;

selIndNR_Background_3_1_17 = ~selIndSat_Background_3_1_17 & alnn_Background_3_1_17 > lnCut;
selIndNR_Background_3_1_17 = selIndNR_Background_3_1_17 & aAvgdEdx_Background_3_1_17 > avgdEdzCut;

selIndNR_DD_GEM_3_8_17 = ~selIndSat_DD_GEM_3_8_17 & alnn_DD_GEM_3_8_17 > lnCut;
selIndNR_DD_GEM_3_8_17 = selIndNR_DD_GEM_3_8_17 & aAvgdEdx_DD_GEM_3_8_17 > avgdEdzCut;

selIndNR_DD_GEM_3_9_17 = ~selIndSat_DD_GEM_3_9_17 & alnn_DD_GEM_3_9_17 > lnCut;
selIndNR_DD_GEM_3_9_17 = selIndNR_DD_GEM_3_9_17 & aAvgdEdx_DD_GEM_3_9_17 > avgdEdzCut;

selIndNR_Co60_3_13_17 = ~selIndSat_Co60_3_13_17 & alnn_Co60_3_13_17 > lnCut;
selIndNR_Co60_3_13_17 = selIndNR_Co60_3_13_17 & aAvgdEdx_Co60_3_13_17 > avgdEdzCut;

selIndNR_DD_Cathode = [selIndNR_DD_Cathode_2_23_17,selIndNR_DD_Cathode_2_25_17];
selIndNR_DD_GEM = [selIndNR_DD_GEM_3_8_17,selIndNR_DD_GEM_3_9_17];
selIndNR_Co60 = [selIndNR_Co60_3_13_17];

if strcmp(sVisFe55,'on')    
    figure(1);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_DD_2_23_17.a*exp(-((x-fitA_Fe55_Pre_DD_2_23_17.x0)/fitA_Fe55_Pre_DD_2_23_17.c).^2)+fitA_Fe55_Pre_DD_2_23_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_DD_2_23_17.a*exp(-((x-fitA_Fe55_Post_DD_2_23_17.x0)/fitA_Fe55_Post_DD_2_23_17.c).^2)+fitA_Fe55_Post_DD_2_23_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre DD Cathode 2-23-17','Fe55 Post DD Cathode 2-23-17','Fit Pre DD Cathode','Fit Post DD Cathode','Location','Best');
    xlim([0 120]);
    
    figure(2);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_DD_2_25_17.a*exp(-((x-fitA_Fe55_Pre_DD_2_25_17.x0)/fitA_Fe55_Pre_DD_2_25_17.c).^2)+fitA_Fe55_Pre_DD_2_25_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_DD_2_25_17.a*exp(-((x-fitA_Fe55_Post_DD_2_25_17.x0)/fitA_Fe55_Post_DD_2_25_17.c).^2)+fitA_Fe55_Post_DD_2_25_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre DD Cathode 2-25-17','Fe55 Post DD Cathode 2-25-17','Fit Pre DD Cathode','Fit Post DD Cathode','Location','Best');
    xlim([0 120]);

    figure(3);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_Background_3_1_17.a*exp(-((x-fitA_Fe55_Pre_Background_3_1_17.x0)/fitA_Fe55_Pre_Background_3_1_17.c).^2)+fitA_Fe55_Pre_Background_3_1_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_Background_3_1_17.a*exp(-((x-fitA_Fe55_Post_Background_3_1_17.x0)/fitA_Fe55_Post_Background_3_1_17.c).^2)+fitA_Fe55_Post_Background_3_1_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre Background 3-1-17','Fe55 Post Background 3-1-17','Fit Pre Background','Fit Post Background','Location','Best');
    xlim([0 120]);
    
    figure(4);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_DD_3_8_17.a*exp(-((x-fitA_Fe55_Pre_DD_3_8_17.x0)/fitA_Fe55_Pre_DD_3_8_17.c).^2)+fitA_Fe55_Pre_DD_3_8_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_DD_3_8_17.a*exp(-((x-fitA_Fe55_Post_DD_3_8_17.x0)/fitA_Fe55_Post_DD_3_8_17.c).^2)+fitA_Fe55_Post_DD_3_8_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre DD GEM 3-8-17','Fe55 Post DD GEM 3-8-17','Fit Pre DD','Fit Post DD','Location','Best');
    xlim([0 120]);
    
    figure(5);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_DD_3_9_17.a*exp(-((x-fitA_Fe55_Pre_DD_3_9_17.x0)/fitA_Fe55_Pre_DD_3_9_17.c).^2)+fitA_Fe55_Pre_DD_3_9_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_DD_3_9_17.a*exp(-((x-fitA_Fe55_Post_DD_3_9_17.x0)/fitA_Fe55_Post_DD_3_9_17.c).^2)+fitA_Fe55_Post_DD_3_9_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre DD GEM 3-9-17','Fe55 Post DD GEM 3-9-17','Fit Pre DD','Fit Post DD','Location','Best');
    xlim([0 120]);
    
    figure(6);
    hold on;
    x = 0:0.1:140;
    fitCurvePre = fitA_Fe55_Pre_Co60_3_13_17.a*exp(-((x-fitA_Fe55_Pre_Co60_3_13_17.x0)/fitA_Fe55_Pre_Co60_3_13_17.c).^2)+fitA_Fe55_Pre_Co60_3_13_17.d;
    plot(x, fitCurvePre,'k');
    fitCurvePost = fitA_Fe55_Post_Co60_3_13_17.a*exp(-((x-fitA_Fe55_Post_Co60_3_13_17.x0)/fitA_Fe55_Post_Co60_3_13_17.c).^2)+fitA_Fe55_Post_Co60_3_13_17.d;
    plot(x, fitCurvePost,'m');
    xlabel('Area');
    ylabel('Counts');
    legend('Fe55 Pre Co60 3-13-17','Fe55 Post Co60 3-13-17','Fit Pre Co60','Fit Post Co60','Location','Best');
    xlim([0 120]);    
end

mSize = 6;
mLineWid = 0.5;
figNum = 6;

if bPlot    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_DD_Cathode_2_23_17(~selIndSat_DD_Cathode_2_23_17)*convAtoE_DD_Cathode_2_23_17,aL_DD_Cathode_2_23_17(~selIndSat_DD_Cathode_2_23_17),strcat(cCath_23,'.'),'LineWidth',mLineWid);    
    scatter(aA_DD_Cathode_2_23_17(selIndNR_DD_Cathode_2_23_17)*convAtoE_DD_Cathode_2_23_17,aL_DD_Cathode_2_23_17(selIndNR_DD_Cathode_2_23_17),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);
    scatter(aA_DD_Cathode_2_25_17(~selIndSat_DD_Cathode_2_25_17)*convAtoE_DD_Cathode_2_25_17,aL_DD_Cathode_2_25_17(~selIndSat_DD_Cathode_2_25_17),strcat(cCath_25,'.'),'LineWidth',mLineWid);    
    scatter(aA_DD_Cathode_2_25_17(selIndNR_DD_Cathode_2_25_17)*convAtoE_DD_Cathode_2_25_17,aL_DD_Cathode_2_25_17(selIndNR_DD_Cathode_2_25_17),strcat(cCath_25,mCath_25),'LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('DD Cathode 2-23-17','DD Cath 2-13-17: NR','DD Cathode 2-25-17','DD Cath 2-25-17: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_DD_GEM_3_8_17(~selIndSat_DD_GEM_3_8_17)*convAtoE_DD_GEM_3_8_17,aL_DD_GEM_3_8_17(~selIndSat_DD_GEM_3_8_17),strcat(cGEM_8,'.'),'LineWidth',mLineWid);    
    scatter(aA_DD_GEM_3_8_17(selIndNR_DD_GEM_3_8_17)*convAtoE_DD_GEM_3_8_17,aL_DD_GEM_3_8_17(selIndNR_DD_GEM_3_8_17),strcat(cGEM_8,mGEM_8),'LineWidth',mLineWid);
    scatter(aA_DD_GEM_3_9_17(~selIndSat_DD_GEM_3_9_17)*convAtoE_DD_GEM_3_8_17,aL_DD_GEM_3_9_17(~selIndSat_DD_GEM_3_9_17),strcat(cGEM_9,'.'),'LineWidth',mLineWid);    
    scatter(aA_DD_GEM_3_9_17(selIndNR_DD_GEM_3_9_17)*convAtoE_DD_GEM_3_8_17,aL_DD_GEM_3_9_17(selIndNR_DD_GEM_3_9_17),strcat(cGEM_9,mGEM_9),'LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('DD GEM 3-8-17','DD Cath 3-8-17: NR','DD GEM 3-9-17','DD Cath 3-9-17: NR','Location','best');
    grid on;    
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aE_DD_Cathode(~selIndSat_DD_Cathode),aL_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);    
    scatter(aE_DD_Cathode(selIndNR_DD_Cathode),aL_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);
    scatter(aA_Background_3_1_17(~selIndSat_Background_3_1_17)*convAtoE_Background_3_1_17,aL_Background_3_1_17(~selIndSat_Background_3_1_17),strcat(cBack,'.'),'LineWidth',mLineWid);    
    scatter(aA_Background_3_1_17(selIndNR_Background_3_1_17)*convAtoE_Background_3_1_17,aL_Background_3_1_17(selIndNR_Background_3_1_17),strcat(cBack,mBack),'LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('DD Cathode','DD Cath: NR','Background 3-1-17','Background: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aE_DD_Cathode(~selIndSat_DD_Cathode),aL_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);    
    scatter(aE_DD_GEM(~selIndSat_DD_GEM_3_8_17),aL_DD_GEM_3_8_17(~selIndSat_DD_GEM_3_8_17),strcat(cGEM_8,'.'),'LineWidth',mLineWid);
    scatter(aA_Background_3_1_17(~selIndSat_Background_3_1_17)*convAtoE_Background_3_1_17,aL_Background_3_1_17(~selIndSat_Background_3_1_17),strcat(cBack,'.'),'LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('L (mm)','FontSize',20);
    legend('DD Cathode','DD GEM','Background 3-1-17','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aA_DD_Cathode_2_23_17(~selIndSat_DD_Cathode_2_23_17)*convAtoE_DD_Cathode_2_23_17,alnn_DD_Cathode_2_23_17(~selIndSat_DD_Cathode_2_23_17),strcat(cCath_23,'.'),'LineWidth',mLineWid);
    scatter(aA_DD_Cathode_2_23_17(selIndNR_DD_Cathode_2_23_17)*convAtoE_DD_Cathode_2_23_17,alnn_DD_Cathode_2_23_17(selIndNR_DD_Cathode_2_23_17),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);    
    scatter(aA_DD_Cathode_2_25_17(~selIndSat_DD_Cathode_2_25_17)*convAtoE_DD_Cathode_2_25_17,alnn_DD_Cathode_2_25_17(~selIndSat_DD_Cathode_2_25_17),strcat(cCath_25,'.'),'LineWidth',mLineWid);
    scatter(aA_DD_Cathode_2_25_17(selIndNR_DD_Cathode_2_25_17)*convAtoE_DD_Cathode_2_25_17,alnn_DD_Cathode_2_25_17(selIndNR_DD_Cathode_2_25_17),strcat(cCath_25,mCath_25),'LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('DD Cathode 2-23-17','DD Cath 2-13-17: NR','DD Cathode 2-25-17','DD Cath 2-25-17: NR','Location','best');
    grid on;
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on
    scatter(aE_DD_Cathode(~selIndSat_DD_Cathode),alnn_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);
    scatter(aE_DD_Cathode(selIndNR_DD_Cathode),alnn_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);    
    scatter(aA_Background_3_1_17(~selIndSat_Background_3_1_17)*convAtoE_Background_3_1_17,alnn_Background_3_1_17(~selIndSat_Background_3_1_17),strcat(cBack,'.'),'LineWidth',mLineWid);
    scatter(aA_Background_3_1_17(selIndNR_Background_3_1_17)*convAtoE_Background_3_1_17,alnn_Background_3_1_17(selIndNR_Background_3_1_17),strcat(cBack,mBack),'LineWidth',mLineWid);    
    xlabel('E (keVee)','FontSize',20);
    ylabel('ln(\eta) (keVee/mm2)','FontSize',20);
    legend('DD Cathode 2-23-17','DD Cath 2-13-17: NR','Background 3-1-17','Background: NR','Location','best');
    grid on;     
      
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on;
    grid on;
    wid = 10;
    histogram(aA_DD_Cathode_2_23_17(~selIndSat_DD_Cathode_2_23_17)*convAtoE_DD_Cathode_2_23_17,'binwidth',wid,'EdgeColor',cCath_23,'DisplayStyle','stair');    
    histogram(aA_DD_Cathode_2_25_17(~selIndSat_DD_Cathode_2_25_17)*convAtoE_DD_Cathode_2_25_17,'binwidth',wid,'EdgeColor',cCath_25,'DisplayStyle','stair');        
    legend('DD Cathode 2-23-17','DD Cathode 2-25-17','Location','Best');
    xlabel('Energy (keVee)','FontSize',20);
    ylabel('Counts','FontSize',20);
    title('E Spec All Events');
    set(gca,'yscale','log');
    
    figure(figNum)
    clf;
    hold on;
    grid on;
    wid = 10;
    histogram(aE_DD_Cathode(~selIndSat_DD_Cathode),'binwidth',wid,'EdgeColor',cCath_23,'DisplayStyle','stair');    
    histogram(aE_DD_GEM(~selIndSat_DD_GEM),'binwidth',wid,'EdgeColor',cGEM_8,'DisplayStyle','stair');        
    histogram(aA_Background_3_1_17(~selIndSat_Background_3_1_17)*convAtoE_Background_3_1_17,'binwidth',wid,'EdgeColor',cBack,'DisplayStyle','stair');
    legend('DD Cathode','DD GEM','Background','Location','Best');
    xlabel('Energy (keVee)','FontSize',20);
    ylabel('Counts','FontSize',20);
    title('E Spec All Events');
    set(gca,'yscale','log');
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on;
    grid on;
    histogram(aA_DD_Cathode_2_23_17(selIndNR_DD_Cathode_2_23_17)*convAtoE_DD_Cathode_2_23_17,'binwidth',wid,'EdgeColor',cCath_23,'DisplayStyle','stair');    
    histogram(aA_DD_Cathode_2_25_17(selIndNR_DD_Cathode_2_25_17)*convAtoE_DD_Cathode_2_25_17,'binwidth',wid,'EdgeColor',cCath_25,'DisplayStyle','stair');        
    histogram(aA_DD_GEM_3_8_17(selIndNR_DD_GEM_3_8_17)*convAtoE_DD_GEM_3_8_17,'binwidth',wid,'EdgeColor',cGEM_8,'DisplayStyle','stair');            
    histogram(aA_DD_GEM_3_9_17(selIndNR_DD_GEM_3_9_17)*convAtoE_DD_GEM_3_9_17,'binwidth',wid,'EdgeColor',cGEM_9,'DisplayStyle','stair');            
    legend('DD Cath 2-23-17: NR','DD Cath 2-25-17: NR','DD GEM 3-8-17: NR','DD GEM 3-9-17: NR','Location','Best');
    xlabel('Energy (keVee)','FontSize',20);
    ylabel('Counts','FontSize',20);
    title('E Spec NR Sel Cut');
    set(gca,'yscale','log');
      
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on;
    grid on;
    histogram(alnn_DD_Cathode_2_23_17(~selIndSat_DD_Cathode_2_23_17)','binwidth',0.1,'EdgeColor',cCath_23,'DisplayStyle','stair');    
    histogram(alnn_DD_Cathode_2_25_17(~selIndSat_DD_Cathode_2_25_17)','binwidth',0.1,'EdgeColor',cCath_25,'DisplayStyle','stair');        
    histogram(alnn_DD_GEM_3_8_17(~selIndSat_DD_GEM_3_8_17)','binwidth',0.1,'EdgeColor',cGEM_8,'DisplayStyle','stair');            
    histogram(alnn_DD_GEM_3_9_17(~selIndSat_DD_GEM_3_9_17)','binwidth',0.1,'EdgeColor',cGEM_9,'DisplayStyle','stair');                
    histogram(alnn_Background_3_1_17(~selIndSat_Background_3_1_17)','binwidth',0.1,'EdgeColor',cBack,'DisplayStyle','stair');
    legend('DD Cathode 2-23-17','DD Cathode 2-25-17','DD GEM 3-8-17','DD GEM 3-9-17','Background 3-1-17','Location','Best');
    xlabel('ln(\eta) (keVee/mm2)','FontSize',20);
    ylabel('Counts','FontSize',20);
    set(gca,'yscale','log');
    
    figNum = figNum+1;
    figure(figNum)
    clf;
    hold on;
    grid on;
    histogram(aAvgdEdx_DD_Cathode_2_23_17(~selIndSat_DD_Cathode_2_23_17),'binwidth',1,'EdgeColor',cCath_23,'DisplayStyle','stair');        
    histogram(aAvgdEdx_DD_Cathode_2_25_17(~selIndSat_DD_Cathode_2_25_17),'binwidth',1,'EdgeColor',cCath_25,'DisplayStyle','stair');
    histogram(aAvgdEdx_DD_GEM_3_8_17(~selIndSat_DD_GEM_3_8_17),'binwidth',1,'EdgeColor',cGEM_8,'DisplayStyle','stair');    
    histogram(aAvgdEdx_DD_GEM_3_9_17(~selIndSat_DD_GEM_3_9_17),'binwidth',1,'EdgeColor',cGEM_9,'DisplayStyle','stair');        
    histogram(aAvgdEdx_Background_3_1_17(~selIndSat_Background_3_1_17),'binwidth',1,'EdgeColor',cBack,'DisplayStyle','stair');                
    legend('DD Cathode 2-23-17','DD Cathode 2-25-17','DD GEM 3-8-17','DD GEM 3-9-17','Background 3-1-17','Location','Best');
    xlabel('avgdE/dx (keVee/mm)','FontSize',20);
    ylabel('Counts','FontSize',20);
    set(gca,'yscale','log');

    if bPlotSkew
        figNum = figNum+1;
        figure(figNum)
        clf;
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
            tempMat_NR_GEM =  aSkewMatDD_GEM_3_8_17(selIndNR_DD_GEM_3_8_17 & aA_DD_GEM_3_8_17*convAtoE_DD_GEM_3_8_17>=pltE & aA_DD_GEM_3_8_17*convAtoE_DD_GEM_3_8_17<=pltE+pltEwid);
            tempE_NR_GEM =  aA_DD_GEM_3_8_17(selIndNR_DD_GEM_3_8_17 & aA_DD_GEM_3_8_17*convAtoE_DD_GEM_3_8_17>=pltE & aA_DD_GEM_3_8_17*convAtoE_DD_GEM_3_8_17<=pltE+pltEwid)*convAtoE_DD_GEM_3_8_17;
            tempMat_NR_Cathode =  aSkewMatDD_Cathode(selIndNR_DD_Cathode & aE_DD_Cathode>=pltE & aE_DD_Cathode<=pltE+pltEwid);
            tempE_NR_Cathode =  aE_DD_Cathode(selIndNR_DD_Cathode & aE_DD_Cathode>=pltE & aE_DD_Cathode<=pltE+pltEwid);
            if isempty(tempMat_NR_Cathode)
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
        h1 = errorbar(aPltE+pltEwid/2,aSkMat_NR_GEM_vsE,aErrSkMat_NR_GEM_vsE,strcat(cCath_23,'.-'),'Linewidth',2);
        herrorbar(aPltE+pltEwid/2,aSkMat_NR_GEM_vsE,aErrE_NR_GEM_vsE,cCath_23);
        h2 = errorbar(aPltE+pltEwid/2,aSkMat_NR_Cathode_vsE,aErrSkMat_NR_Cathode_vsE,'k.-','Linewidth',2);
        herrorbar(aPltE+pltEwid/2,aSkMat_NR_Cathode_vsE,aErrE_NR_Cathode_vsE,'k.');
        legend([h1 h2],{'DD GEM: NR','DD Cathode: NR'},'Location','best');
        grid on;
        xlabel('E (keV)','FontSize',20);
        ylabel('Skewness','FontSize',20);
        title('Skewness vs Energy');
    end
    if bPlotOtherScat
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on
        scatter(aE_DD_Cathode(~selIndSat_DD_Cathode),aAvgdEdx_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);
        scatter(aE_DD_Cathode(selIndNR_DD_Cathode),aAvgdEdx_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);    
        xlabel('E (keVee)','FontSize',20);
        ylabel('Avg dE/dx (keVee/mm)','FontSize',20);
        legend('DD Cathode','DD GEM: NR','Location','best');
        grid on;   
        
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on
        scatter(aAvgdEdx_DD_Cathode(~selIndSat_DD_Cathode),aL_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);        
        scatter(aAvgdEdx_DD_Cathode(selIndNR_DD_Cathode),aL_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);        
        xlabel('avgdEdx (keVee/mm)','FontSize',20);
        ylabel('L (mm)','FontSize',20);
        legend('DD Cathode','DD Cathode: NR','Location','best'); 
        grid on;        
        
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on
        scatter(aAvgdEdx_DD_Cathode(~selIndSat_DD_Cathode),alnn_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);        
        scatter(aAvgdEdx_DD_Cathode(selIndNR_DD_Cathode),alnn_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);        
        xlabel('avgdEdx (keVee/mm)','FontSize',20);
        ylabel('ln(n) (keVee/mm2)','FontSize',20);
        legend('DD Cathode','DD Cathode: NR','Location','best'); 
        grid on;
        
        aLchrg_Background_3_1_17 = Background_3_1_17_S.matUnEvRegZ(:,1)';
        aLchrg_DD_Cathode_2_23_17 = DD_Cathode_2_23_17_S.matUnEvRegZ(:,1)';
        aLchrg_DD_Cathode_2_25_17 = DD_Cathode_2_25_17_S.matUnEvRegZ(:,1)';
        aLchrg_DD_Cathode = [aLchrg_DD_Cathode_2_23_17,aLchrg_DD_Cathode_2_25_17];
        
        aAvgdEdxChrg_Background_3_1_17 = (aA_Background_3_1_17*convAtoE_Background_3_1_17)./aLchrg_Background_3_1_17;
        aAvgdEdxChrg_DD_Cathode = aE_DD_Cathode./aLchrg_DD_Cathode;
        
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on
        scatter(aAvgdEdxChrg_DD_Cathode(~selIndSat_DD_Cathode),aL_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);        
%         scatter(aAvgdEdxChrg_DD_Cathode(selIndNR_DD_Cathode),aL_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);
        scatter(aAvgdEdxChrg_Background_3_1_17(~selIndSat_Background_3_1_17),aL_Background_3_1_17(~selIndSat_Background_3_1_17),strcat(cBack,'.'),'LineWidth',mLineWid);        
%         scatter(aAvgdEdxChrg_Background_3_1_17(selIndNR_Background_3_1_17),aL_Background_3_1_17(selIndNR_Background_3_1_17),strcat(cBack,mBack),'LineWidth',mLineWid);        
        xlabel('avgdEdx of Total Charge Distribution (keVee/mm)','FontSize',20);
        ylabel('L (mm)','FontSize',20);
        legend('DD Cathode','Background 3-1-17','Location','best');                 
%         legend('DD Cathode','DD Cathode: NR','Background 3-1-17','Background: NR','Location','best'); 
        grid on;
        
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on
        scatter(aE_DD_Cathode(~selIndSat_DD_Cathode),aAvgdEdxChrg_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);        
%         scatter(aE_DD_Cathode(selIndNR_DD_Cathode),aAvgdEdxChrg_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);
        scatter(aA_Background_3_1_17(~selIndSat_Background_3_1_17)*convAtoE_Background_3_1_17,aAvgdEdxChrg_Background_3_1_17(~selIndSat_Background_3_1_17),strcat(cBack,'.'),'LineWidth',mLineWid);        
%         scatter(aA_Background_3_1_17(selIndNR_Background_3_1_17)*convAtoE_Background_3_1_17,aAvgdEdxChrg_Background_3_1_17(selIndNR_Background_3_1_17),strcat(cBack,mBack),'LineWidth',mLineWid);        
        ylabel('avgdEdx of Total Charge Distribution (keVee/mm)','FontSize',20);
        xlabel('E (keVee)','FontSize',20);
        legend('DD Cathode','Background 3-1-17','Location','best');         
%         legend('DD Cathode','DD Cathode: NR','Background 3-1-17','Background: NR','Location','best'); 
        grid on;
        
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on
        scatter(adEdx_DD_Cathode(~selIndSat_DD_Cathode),aLchrg_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);        
%         scatter(adEdx_DD_Cathode(selIndNR_DD_Cathode),aLchrg_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);
        scatter(adEdx_Background_3_1_17(~selIndSat_Background_3_1_17),aLchrg_Background_3_1_17(~selIndSat_Background_3_1_17),strcat(cBack,'.'),'LineWidth',mLineWid);        
%         scatter(adEdx_Background_3_1_17(selIndNR_Background_3_1_17),aLchrg_Background_3_1_17(selIndNR_Background_3_1_17),strcat(cBack,mBack),'LineWidth',mLineWid);        
        xlabel('maxdEdx (keVee/mm)','FontSize',20);
        ylabel('L Charge Distribution(mm)','FontSize',20);
        legend('DD Cathode','Background 3-1-17','Location','best'); 
%         legend('DD Cathode','DD Cathode: NR','Background 3-1-17','Background: NR','Location','best'); 
        grid on;
        
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on
        scatter(adEdx_DD_Cathode(~selIndSat_DD_Cathode),aAvgdEdxChrg_DD_Cathode(~selIndSat_DD_Cathode),strcat(cCath_23,'.'),'LineWidth',mLineWid);        
%         scatter(adEdx_DD_Cathode(selIndNR_DD_Cathode),aAvgdEdxChrg_DD_Cathode(selIndNR_DD_Cathode),strcat(cCath_23,mCath_23),'LineWidth',mLineWid);
        scatter(adEdx_Background_3_1_17(~selIndSat_Background_3_1_17),aAvgdEdxChrg_Background_3_1_17(~selIndSat_Background_3_1_17),strcat(cBack,'.'),'LineWidth',mLineWid);        
%         scatter(adEdx_Background_3_1_17(selIndNR_Background_3_1_17),aAvgdEdxChrg_Background_3_1_17(selIndNR_Background_3_1_17),strcat(cBack,mBack),'LineWidth',mLineWid);        
        xlabel('maxdEdx (keVee/mm)','FontSize',20);
        ylabel('avgdEdx chrg','FontSize',20);
        legend('DD Cathode','Background 3-1-17','Location','best'); 
%         legend('DD Cathode','DD Cathode: NR','Background 3-1-17','Background: NR','Location','best'); 
        grid on;        
        
        figNum = figNum+1;
        figure(figNum)
        clf;
        hold on;
        grid on;
        histogram(adEdx_DD_Cathode(~selIndSat_DD_Cathode_2_23_17),'binwidth',1,'EdgeColor',cCath_23,'DisplayStyle','stair');        
        histogram(adEdx_Background_3_1_17(~selIndSat_Background_3_1_17),'binwidth',1,'EdgeColor',cBack,'DisplayStyle','stair');                
        legend('DD Cathode','Background 3-1-17','Location','Best');
        xlabel('maxdE/dx (keVee/mm)','FontSize',20);
        ylabel('Counts','FontSize',20);
        set(gca,'yscale','log');        
    end
end

% deadTperTrig = 0.814742268;
deadTperTrig = 0.77;
convSecToHrs = 60*60;
eThr = 50;
Ttot_Back_3_1_17 = (7*60+58)*60;
% Ttot_Co60_12_15_16 = 242*60;
% Ttot_DD_GEM_2_15_17 = 301*60;
Ttot_DD_Cath = (3*60+50)*60+(5*60+48)*60;

c_B_gr = sum(aA_Background_3_1_17*convAtoE_Background_3_1_17>=eThr);
cNR_B_gr = sum(selIndNR_Background_3_1_17 & aA_Background_3_1_17*convAtoE_Background_3_1_17>=eThr)
% cNR_Co60_gr = sum(selIndNR_Co60_12_15_16 & aA_Co60_12_15_16*convAtoE_Co60_12_15_16>=eThr)
% c_Co60_gr = sum(aA_Co60_12_15_16*convAtoE_Co60_12_15_16>=eThr);
% cNR_DD_GEM_gr = sum(selIndNR_DD_GEM_2_15_17 & aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17>=eThr)
% c_DD_GEM_gr = sum(aA_DD_GEM_2_15_17*convAtoE_DD_GEM_2_15_17>=eThr);
cNR_Cath_gr = sum(selIndNR_DD_Cathode & aE_DD_Cathode>=eThr)
c_Cath_gr = sum(aE_DD_Cathode>=eThr);

mr_B_gr_r = c_B_gr/Ttot_Back_3_1_17;
% mr_Co60_gr_r = c_Co60_gr/Ttot_Co60_12_15_16;
% mr_DD_GEM_gr_r = c_DD_GEM_gr/Ttot_DD_GEM_2_15_17;
mr_Cath_gr_r = c_Cath_gr/Ttot_DD_Cath;

corr_B_gr_r = convSecToHrs*mr_B_gr_r/(1-deadTperTrig*mr_B_gr_r);
% corr_Co60_gr_r = convSecToHrs*mr_Co60_gr_r/(1-deadTperTrig*mr_Co60_gr_r);
% corr_DD_GEM_gr_r = convSecToHrs*mr_DD_GEM_gr_r/(1-deadTperTrig*mr_DD_GEM_gr_r);
corr_Cath_gr_r = convSecToHrs*mr_Cath_gr_r/(1-deadTperTrig*mr_Cath_gr_r);


mr_B_gr_r = convSecToHrs*mr_B_gr_r;
% mr_Co60_gr_r = convSecToHrs*mr_Co60_gr_r;
% mr_DD_GEM_gr_r = convSecToHrs*mr_DD_GEM_gr_r;
mr_Cath_gr_r = convSecToHrs*mr_Cath_gr_r;

mrNR_B_gr_r = cNR_B_gr/Ttot_Back_3_1_17;
% mrNR_Co60_gr_r = cNR_Co60_gr/Ttot_Co60_12_15_16;
% mrNR_DD_GEM_gr_r = cNR_DD_GEM_gr/Ttot_DD_GEM_2_15_17;
mrNR_Cath_gr_r = cNR_Cath_gr/Ttot_DD_Cath;

corrNR_B_gr_r = convSecToHrs*mrNR_B_gr_r/(1-deadTperTrig*mrNR_B_gr_r)
% corrNR_Co60_gr_r = convSecToHrs*mrNR_Co60_gr_r/(1-deadTperTrig*mrNR_Co60_gr_r)
% corrNR_DD_GEM_gr_r = convSecToHrs*mrNR_DD_GEM_gr_r/(1-deadTperTrig*mrNR_DD_GEM_gr_r)
corrNR_Cath_gr_r = convSecToHrs*mrNR_Cath_gr_r/(1-deadTperTrig*mrNR_Cath_gr_r)

mrNR_B_gr_r = convSecToHrs*mrNR_B_gr_r
% mrNR_Co60_gr_r = convSecToHrs*mrNR_Co60_gr_r
% mrNR_DD_GEM_gr_r = convSecToHrs*mrNR_DD_GEM_gr_r
mrNR_Cath_gr_r = convSecToHrs*mrNR_Cath_gr_r