function pltFileSel(Struct,selInd)
    unFnames = Struct.unFnames(selInd)
    shFnames = Struct.shFnames(selInd);
    convAtoE_un = 0.2095;
    convAtoE_sh = Struct.convAtoE_sh;
    
    
%     fbox = 0.888;
%     HV = 37.3E3;
    fbox = 1;
    HV = 60.0E3;    
    detLen = 58.3; %cm
    Press = 30;
    % Press = 20;
    driftE = HV*fbox/detLen;
    points = 10000;
    dVelmm = calcDriftVel(Press,driftE,true)/1000;
    
    sHomeDir = 'F:';
%     sHomeDir = '/media/randy/48749D2C749D1E2E';

%     sDataTypeDir = 'SF6_DD_Shaper_filterBox';
%     sDataTypeDir = 'SF6_Co-60_Gamma_Run_Shaper_filterBox';
    sDataTypeDir = 'SF6_NoFiltBox';


% stype = 'co60';Type = 'Co60';
% sDate = '12-15-16';Date = '12-15-16';
% 
% stype = 'background',Type = 'Background';
% sDate = '3-1-17';Date = '3-1-17';

stype = 'DD_Cathode_143mV';Type = 'DD';
sDate = '2-23-17';Date = '2-23-17';

% stype = 'DD_GEM';Type = 'DD';
% sDate = '3-8-17';Date = '3-8-17';

% stype = 'DD_thresh_100mV_70kV_60uA';Type = 'DD';
% stype = 'Cf252_thresh_100mV';
% stype = 'fe55_pre_run';Type = 'Fe55';
% stype = 'laser';Type = 'Laser';
% stype = 'Co60';Type = 'Co60';
% stype = 'fe55_mid_run';Type = 'Fe55';
% stype = 'laser_Vamp_1st';Type = 'Fe55';
% stype = 'fe55_post_run';Type = 'Fe55';
% stype = 'background';Type = 'Background';

% stype = 'fe55_pre_DD';Type = 'Fe55';
% stype = 'fe55_post_DD';Type = 'Fe55';
% stype = 'fe55_pre_back';Type = 'Fe55';

% sDate = '11-7-16';Date = '11-7-16';
% sDate = '11-7-16';Date = '11-7-16_pre_back';
% sDate = '11-7-16';Date = '11-7-16_pre_DD';
% sDate = '11-7-16';Date = '11-7-16_post_DD';
% sDate = '9-19-16';Date = '9-19-16+';
% sDate = '9-20-16';Date = '9-20-16';
% sDate = '7-26-16';Date = '7-26-16';
% sDate = '6-30-16';
% sDate = '3-30-2016';
    
    unDirName = sprintf('%s/%s/%s/%s/raw/',sHomeDir,sDataTypeDir,sDate,stype);
    shDirName = sprintf('%s/%s/%s/%s/shaped/',sHomeDir,sDataTypeDir,sDate,stype);
    
    numToInclude = length(unFnames);
    for K = 1:numToInclude
          %Load unshaped
          unFname = unFnames(K).name
          [unM,aUnPkVInd, unVOffSet, aUnPriPeakIndex,aUnMainEdges,unEvRegZ,unEstEvA,unEstOutA,unAvgdAdx,aUnTempRMSnoise,aUnSkew,aUnNum,aUnThrs] = analyzeEvent(strcat(unDirName,unFname),Press,driftE,points,false,Type,Date);
          unT = unM(:,1);unV = unM(:,2);I = unM(:,3);sI = unM(:,4);sIA = unM(:,5);
          if isempty(aUnPkVInd)
              continue;
          end
          if unEstEvA(1) == 0 | unEvRegZ == 0
              continue;
          end
          if isempty(I) || isempty(aUnPriPeakIndex)
              continue;
          end
          %Load shaped
          shFname = shFnames(K).name
          [shM,~,shVOffSet, aShPriPeakIndex,aShMainEdges,shEvRegZ,shEstEvA,shEstOutA,shAvgdAdx,aShTempRMSnoise,aShSkew,aShNum,aShThrs] = analyzeEvent(strcat(shDirName,shFname),Press,driftE,points,true,Type,Date);
          shT = shM(:,1);shV = shM(:,2);shsV = unM(:,4);shsVA = unM(:,5);
          if isempty(aShPriPeakIndex) | shEstEvA == 0
              continue;
          end
          EvE = unEstEvA(1)*convAtoE_un
          [aUnVPriMax(K),unVmaxLocInd] = max(unV(aUnPkVInd));
          unVmaxInd = aUnPkVInd(unVmaxLocInd);
          maxdEdx = sI(aUnPriPeakIndex(1))*convAtoE_un/dVelmm
          L = unEvRegZ(3)
          avgdEdx = unAvgdAdx(3)*convAtoE_un;
          lnmaxdEdxPerL = log(maxdEdx/L);
          avgdEdxChrg = EvE/unEvRegZ(1);
          fprintf('skew = %f\n',aUnSkew(2));
          fprintf('avgdEdx = %f, avgdedxChrg = %f\n',avgdEdx,avgdEdxChrg);
          pltAnalyzedEv(Press,driftE,unM,convAtoE_un,unEstEvA,unEstOutA,unEvRegZ,aUnMainEdges,aUnSkew(2),unVmaxInd,aUnPriPeakIndex,aUnThrs,false);
          pltAnalyzedEv(Press,driftE,shM,convAtoE_sh,shEstEvA,shEstOutA,shEvRegZ,aShMainEdges,aShSkew(2),aShPriPeakIndex,aShPriPeakIndex,aShThrs,true);
          pause;
    end
end