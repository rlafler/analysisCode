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
% Press = 20;
driftE = HV*fbox/detLen;
points = 10000;
dVelmm = calcDriftVel(Press,driftE,true)/1000;
bPlot = false;
aboveE = -1000;


convAtoE_un = 0.2056; %arb/kev (11-7 post DD)
convAtoE_sh = 5.2067; %Vus

% convAtoE_un = 5.9/40.2626; %arb/kev (11-7 preback)
% convAtoE_sh = 5.9/0.3181; %Vus

% convAtoE_un = 5.9/40.9747; %arb/kev (7-26)
% convAtoE_sh = 5.9/0.6669; %Vus

% convAtoE_un = 5.9/41.8980; %arb/kev (9-19-16) Pre
% convAtoE_sh = 5.9/0.7084; %Vus

% convAtoE_un = 5.9/34.7132; %arb/kev (9-19-16) Mid
% convAtoE_sh = 5.9/0.5796; %Vus

% convAtoE_un = 5.9/36.3790; %arb/kev (9-20-16)
% convAtoE_sh = 5.9/0.6384; %Vus

sHomeDir = 'E:';
% sHomeDir = '/media/randy/48749D2C749D1E2E';

% sDataTypeDir = 'SF6_DD_Shaper_filterBox';
% sDataTypeDir = 'SF6_Co-60_Gamma_Run_Shaper_filterBox';
sDataTypeDir = 'SF6_NoFiltBox';

% stype = 'fe55_pre_run';Type = 'Fe55';
% sDate = '12-12-16';Date = '12-12-16_pre_back';

% stype = 'fe55_post_run';Type = 'Fe55';
% sDate = '12-12-16';Date = '12-12-16_post_back';

% stype = 'background',Type = 'Background';
% sDate = '12-12-16';Date = '12-12-16';

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

% stype = 'laser_250mV_div/5th';Type = 'Laser';
% sDate = '1-14-17';Date = '1-14-17_5th';

% stype = 'fe55_post_laser';Type = 'Fe55';
% sDate = '1-14-17';Date = '1-14-17_post_laser';

% stype = 'Fe55_Pre_DD';Type = 'Fe55';
% sDate = '2-15-17';Date = '2-15-17_pre_DD';

% stype = 'Fe55_Post_DD';Type = 'Fe55';
% sDate = '2-15-17';Date = '2-15-17_post_DD';

% stype = 'DD_GEM';Type = 'DD';
% sDate = '2-15-17';Date = '2-15-17';

% stype = 'Fe55_Pre_DD';Type = 'Fe55';
% sDate = '2-16-17';Date = '2-16-17_pre_DD';

% stype = 'Fe55_Post_DD';Type = 'Fe55';
% sDate = '2-16-17';Date = '2-16-17_post_DD';

% stype = 'Fe55_Post_DD';Type = 'Fe55';
% sDate = '2-16-17';Date = '2-16-17_post_DD';
% 
% stype = 'DD_Cathode';Type = 'DD';
% sDate = '2-16-17';Date = '2-16-17';

% stype = 'laser_Pre_DD';Type = 'Laser';
% sDate = '2-16-17';Date = '2-16-17_pre_DD';

% stype = 'DD_Cathode_143mV';Type = 'DD';
% sDate = '2-23-17';Date = '2-23-17';

% stype = 'Fe55_Pre_DD_GEM';Type = 'Fe55';
% sDate = '2-25-17';Date = '2-25-17_pre_DD_GEM';

% stype = 'fe55_test_GEM';Type = 'Fe55';
% sDate = '2-28-17';Date = '2-28-17';

% stype = 'background_15mV';Type = 'Background';
% sDate = '2-28-17';Date = '2-28-17';

% stype = 'DD_Cathode';Type = 'DD';
% sDate = '2-25-17';Date = '2-25-17';

% stype = 'Fe55_Post_DD_Cathode';Type = 'Fe55';
% sDate = '2-25-17';Date = '2-25-17_post_DD_Cathode';
% 
% stype = 'background';Type = 'Background';
% sDate = '3-1-17';Date = '3-1-17';


stype = 'fe55_Post_Co60';Type = 'Fe55';
sDate = '3-14-17';Date = '3-14-17_post_Co60';

unDirName = sprintf('%s/%s/%s/%s/raw/',sHomeDir,sDataTypeDir,sDate,stype)
unFnames = dir(strcat(unDirName,'*__*.txt'));

shDirName = sprintf('%s/%s/%s/%s/shaped/',sHomeDir,sDataTypeDir,sDate,stype)
shFnames = dir(strcat(shDirName,'*__*.txt'));

numfids = length(unFnames)

numToInclude=numfids;
% numToInclude = 2000;
% numToInclude = 100;
if numToInclude>numfids
    return
end

matUnEvRegZ = zeros(numToInclude,7);
matUnEvRegA = zeros(numToInclude,5);
matUnIPeakT = zeros(numToInclude,5);
matUnIPriMax = zeros(numToInclude,5);
aUnRMSnoiseV = zeros(1,numToInclude);
aUnRMSnoiseI = zeros(1,numToInclude);
aUnRMSnoiseIA = zeros(1,numToInclude);
aUnVPriMax = zeros(1,numToInclude);
aUnVOff = zeros(1,numToInclude);
aUnSkewSim = zeros(1,numToInclude);
aUnSkewMat = zeros(1,numToInclude);
aUnNumEvPks = zeros(1,numToInclude);
aUnNumTWindPks = zeros(1,numToInclude);
aAvgUnI = zeros(points,1);
aAvgUnV = zeros(points,1);

matShEvRegPriZ = zeros(numToInclude,7);
matShEvRegA = zeros(numToInclude,5);
aShRMSnoiseV = zeros(1,numToInclude);
aShRMSnoiseVA = zeros(1,numToInclude);
aShVPriMax = zeros(1,numToInclude);
aShVOff = zeros(1,numToInclude);
aShSkewSim = zeros(1,numToInclude);
aShSkewMat = zeros(1,numToInclude);
aShNumEvPks = zeros(1,numToInclude);
aShNumTWindPks = zeros(1,numToInclude);
aAvgShI = zeros(points,1);

aEvTypeNum = zeros(1,numToInclude);
matUnAvgdAdZ = zeros(numToInclude,3);
aEvNum = zeros(1,numToInclude);
countSatEvents = 0;
countOther = 0;
countIerr = 0;
satEvents = [];
otherEv = [];
IerrEv = [];
for K = 1:numToInclude
  %Load unshaped
  unFname = unFnames(K).name;
  [unM,aUnPkVInd, unVOffSet, aUnPriPeakIndex,aUnEdges,unEvRegZ,unEstEvA,unEstOutA,unAvgdAdx,aUnTempRMSnoise,aUnSkew,aUnNum,aUnThrs] = analyzeEvent(strcat(unDirName,unFname),Press,driftE,points,false,Type,Date);
  unT = unM(:,1);unV = unM(:,2);I = unM(:,3);sI = unM(:,4);sIA = unM(:,5);
%   if unEstEvA(1) == 0
%       continue;
%   end
  %Load shaped
  shFname = shFnames(K).name;
  [shM,~,shVOffSet, aShPriPeakIndex,aShEdges,shEvRegZ,shEstEvA,shEstOutA,shAvgdAdx,aShTempRMSnoise,aShSkew,aShNum,aShThrs] = analyzeEvent(strcat(shDirName,shFname),Press,driftE,points,true,Type,Date);
  shT = shM(:,1);shV = shM(:,2);shsV = unM(:,4);shsVA = unM(:,5);
  if isempty(aShPriPeakIndex)
        aShVPriMax(K) = 0;
  else
      aShVPriMax(K) = max(shV(aShPriPeakIndex));
  end
  EvE = unEstEvA(1)*convAtoE_un;
  if EvE<aboveE %| ~bPassCut
      continue;
  end
  aEvNum(K) = K;
  [aUnVPriMax(K),unVmaxLocInd] = max(unV(aUnPkVInd));
  unVmaxInd = aUnPkVInd(unVmaxLocInd);
  aUnRMSnoiseV(K) = aUnTempRMSnoise(1);
  aUnRMSnoiseI(K) = aUnTempRMSnoise(2);
  aUnRMSnoiseIA(K) = aUnTempRMSnoise(3);
  aUnVOff(K) = unVOffSet;
  aAvgUnI = aAvgUnI + sI;
  aAvgUnV = aAvgUnV + unV;
 
  aShRMSnoiseV(K) = aShTempRMSnoise(1);
  aShRMSnoiseVA(K) = aShTempRMSnoise(3);
  aShVOff(K) = shVOffSet;
  matShEvRegA(K,1:length(shEstEvA)) = shEstEvA;
  matUnEvRegZ(K,1:length(shEvRegZ)) = shEvRegZ;
  aShSkewSim(K) = aShSkew(1);
  aShSkewMat(K) = aShSkew(2);
  aShNumEvPks(K) = aShNum(1);
  aShNumTWindPks(K) = aShNum(2);
  aAvgShI = aAvgShI + shsV;
  
  matUnIPriMax(K,1:length(aUnPriPeakIndex)) = sI(aUnPriPeakIndex)/dVelmm;
  matUnEvRegA(K,1:length(unEstEvA)) = unEstEvA;
  matUnEvRegZ(K,1:length(unEvRegZ)) = unEvRegZ;
  matUnIPeakT(K,1:length(aUnPriPeakIndex)) = unT(aUnPriPeakIndex);
  aUnSkewSim(K) = aUnSkew(1);
  aUnSkewMat(K) = aUnSkew(2);
  aUnNumEvPks(K) = aUnNum(1);
  aUnNumTWindPks(K) = aUnNum(2);
  matUnAvgdAdZ(K,1:length(unAvgdAdx)) = unAvgdAdx;
  if rem(K,10)==0
      fprintf('Loaded %d events\n',K);
  end
  if (EvE>aboveE)
      if bPlot
          pltAnalyzedEv(Press,driftE,unM,convAtoE_un,unEstEvA(1),unEstOutA,unEvRegZ,aUnEdges,aUnSkew(2),unVmaxInd,aUnPriPeakIndex,aUnThrs,false);
          pltAnalyzedEv(Press,driftE,shM,convAtoE_sh,shEstEvA(1),shEstOutA,shEvRegZ,aShEdges,aShSkew(2),aShPriPeakIndex(1),aShPriPeakIndex,aShThrs,true);
      end
      if bPlot
        pause
      end
  end
end
%Remove excess zeros
rmInds = matUnEvRegA(:,1)==0;
matUnEvRegZ(rmInds,:)=[];
matUnEvRegA(rmInds,:)=[];
matUnIPeakT(rmInds,:)=[];
aUnRMSnoiseV(rmInds)=[];
aUnRMSnoiseI(rmInds)=[];
aUnRMSnoiseIA(rmInds)=[];
aUnVPriMax(rmInds)=[];
matUnIPriMax(rmInds,:)=[];
aUnVOff(rmInds)=[];
aUnSkewSim(rmInds)=[];
aUnSkewMat(rmInds)=[];
aUnNumEvPks(rmInds)=[];
aUnNumTWindPks(rmInds)=[];

matShEvRegPriZ(rmInds)=[];
matShEvRegA(rmInds)=[];
aShRMSnoiseV(rmInds)=[];
aShRMSnoiseVA(rmInds)=[];
aShVPriMax(rmInds)=[];
aShVOff(rmInds)=[];
aShSkewSim(rmInds)=[];
aShSkewMat(rmInds)=[];
aShNumEvPks(rmInds)=[];
aShNumTWindPks(rmInds)=[];

aEvTypeNum(rmInds)=[];
matUnAvgdAdZ(rmInds,:)=[];
aEvNum(rmInds)=[];
unFnames(rmInds)=[];
shFnames(rmInds)=[];

aAvgUnI = aAvgUnI/length(aUnVOff);
aAvgShI = aAvgShI/length(aUnVOff);
aAvgUnV = aAvgUnV/length(aUnVOff);

mean(aUnVOff)
mean(aUnRMSnoiseI)
mean(aUnRMSnoiseV)
mean(aShVOff)
mean(aShRMSnoiseV)