%%
clc;
close all;
clear all;
% fbox = 0.888;
% HV = 37.3E3;
detLen = 58.3; %cm
fbox = 1;
HV = 60E3;
Press = 30;
driftE = HV*fbox/detLen
points = 10000;

%     convAtoE_un = 5.9/30.9579; %arb/keV (6-30)
%     convAtoE_sh = 5.9/2.9998; %Vus

convAtoE_un = 5.9/38.2895 %arb/kev (7-26)
convAtoE_sh = 5.9/0.6667; %Vus
convAtoE = convAtoE_un;

% evNum = 2137;
% evNum = 2323;
evNum = 1016;

bShaped = false;
if bShaped
    convAtoE = convAtoE_sh;
end
sHomeDir = 'F:';
% sHomeDir = '/media/randy/48749D2C749D1E2E';
% stype = 'DD_thresh_100mV_70kV_60uA';
% stype = 'laser';
% stype = 'fe55_pre_run';


% sDataTypeDir = 'SF6_DD_Shaper_filterBox';
sDataTypeDir = 'SF6_NoFiltBox';
% sDataTypeDir = 'SF6_Co-60_Gamma_Run_Shaper_filterBox';

% sDataTypeDir = 'testGrRefRem';
% stype = '';Type = '';
% sDate = '2-11-17';Date = '2-11-17';

% stype = 'DD_thresh_100mV_70kV_60uA';Type = 'DD';
% stype = 'testNoise_HV_Off/200u';Type = stype;
% stype = 'testNoise_HV_30kV/10u';Type = stype;

% stype = 'fe55_pre_run',Type = 'Fe55';
% sDate = '12-12-16';Date = '12-12-16_pre_back';

% stype = 'background',Type = 'Background';
% sDate = '12-12-16';Date = '12-12-16';

% stype = 'laser_250mV_div/2nd';Type = 'Laser';
% sDate = '1-14-17';Date = '1-14-17_2nd';

% stype = 'fe55_pre_laser';Type = 'Fe55';
% sDate = '1-14-17';Date = '1-14-17_pre_laser';

% stype = 'fe55_pre_co60';Type = 'Fe55';
% sDate = '12-15-16';Date = '12-15-16_pre_co60';
% stype = 'fe55_post_co60';Type = 'Fe55';
% sDate = '12-15-16';Date = '12-15-16_post_co60';

% stype = 'co60';Type = 'Co60';
% sDate = '12-15-16';Date = '12-15-16';


% stype = 'laser_pre_co60';Type = 'Laser';
% sDate = '12-15-16';Date = '12-15-16_pre_co60';


% stype = 'laser_post_co60';Type = 'Laser';
% sDate = '12-15-16';Date = '12-15-16_post_co60';

% stype = 'noise_HV_60kV_GEM_Off',Type = stype;
% stype = 'noise_HV_60kV_GEM_820V',Type = stype;

% sDate = '7-26-16';Date = '7-26-16';
% sDate = '11-7-16';Date = '11-7-16';
% sDate = '12-2-16';Date = '12-2-16';
% sDate = '12-5-16';Date = sDate;
% sDate = '12-8-16';Date = sDate;
% 
% stype = 'Fe55_Pre_DD';Type = 'Fe55';
% sDate = '2-15-17';Date = '2-15-17_pre_DD';

% stype = 'Fe55_Post_DD';Type = 'Fe55';
% sDate = '2-16-17';Date = '2-16-17_post_DD';

% stype = 'DD_GEM';Type = 'DD';
% sDate = '2-15-17';Date = '2-15-17';

% stype = 'DD_Cathode_143mV';Type = 'DD';
% sDate = '2-23-17';Date = '2-23-17';

% stype = 'Fe55_Pre_DD_GEM';Type = 'Fe55';
% sDate = '2-25-17';Date = '2-25-17_pre_DD_GEM';

% stype = 'laser_Pre_DD_Cathode';Type = 'Laser';
% sDate = '2-25-17';Date = '2-25-17';

% stype = 'laser';Type = 'Laser';
% sDate = '2-28-17';Date = '2-28-17';

stype = 'DD_Cathode';Type = 'DD';
sDate = '2-25-17';Date = '2-25-17';
% 
% stype = 'fe55_Pre_Background';Type = 'Fe55';
% sDate = '3-1-17';Date = '3-1-17';

% dirName = sprintf('%s/%s/%s/%s/signal/',sHomeDir,sDataTypeDir,sDate,stype)
dirName = sprintf('%s/%s/%s/%s/raw/',sHomeDir,sDataTypeDir,sDate,stype)

% fname = sprintf('laser_raw__%d.txt',evNum);
% fname = sprintf('fe55_raw__%d.txt',evNum);
fname = sprintf('DD_Cathode_820V_60kV_raw__%d.txt',evNum);


% fname = sprintf('laser_820V_raw__%d.txt',evNum);
% fname = sprintf('co60_60kV_820V_raw__%d.txt',evNum);
% fname = sprintf('laser_60kV_820V_raw__%d.txt',evNum);
% fname = sprintf('background_60kV_820V_raw__%d.txt',evNum);
% fname = sprintf('fe55_60kV_820V_raw__%d.txt',evNum);
% fname = sprintf('testNoise__%d.txt',evNum);
% fname = sprintf('testNoise_HV_30kV_lights_off_anode_grd_raw__%d.txt',evNum);
% fname = sprintf('SF6_30Torr_37_3kV_820V_laser_raw___%d.txt',evNum);
% fname = sprintf('pulseGen_100Hz_signal__%d.txt',evNum);

[M,aVmaxIndex, vOffSet, aPriPeakIndex,aEdges,aEvRegZ,estEvA,estOutA,avgdAdx,aRMSnoise,aSkew,aNumEvPks,aThrs] = analyzeEvent(strcat(dirName,fname),Press,driftE,points,bShaped,Type,Date);
T = M(:,1);V = M(:,2);I = M(:,3);sI = M(:,4);sIA = M(:,5);
if isempty(aVmaxIndex)
    aVmaxIndex = 1;
end
pltAnalyzedEv(Press,driftE,M,convAtoE,estEvA(1),estOutA,aEvRegZ,aEdges,aSkew(2),aVmaxIndex,aPriPeakIndex,aThrs,bShaped);
