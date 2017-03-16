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

gausFun = @(x,x0,sig) (1.0/(sig*sqrt(2*pi)))*exp(-((x-x0).^2)/(2*sig.^2));

sHomeDir = 'F:';
% sHomeDir = '/media/randy/48749D2C749D1E2E';

sDataTypeDir = 'SF6_NoFiltBox';

stype = 'DD_GEM';Type = 'DD';
sDate = '2-15-17';Date = '2-15-17';

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

unDirName = sprintf('%s/%s/%s/%s/raw/',sHomeDir,sDataTypeDir,sDate,stype)
unFnames = dir(strcat(unDirName,'*__*.txt'));

shDirName = sprintf('%s/%s/%s/%s/shaped/',sHomeDir,sDataTypeDir,sDate,stype)
shFnames = dir(strcat(shDirName,'*__*.txt'));

numfids = length(unFnames)

numToInclude=numfids;
numToInclude = 2000;

if numToInclude>numfids
    return
end

aUnRMSnoiseV = zeros(1,numToInclude);
aUnRMSnoiseI = zeros(1,numToInclude);
aUnRMSnoiseIA = zeros(1,numToInclude);
aUnVOff = zeros(1,numToInclude);

aShRMSnoiseV = zeros(1,numToInclude);
aShRMSnoiseVA = zeros(1,numToInclude);
aShVPriMax = zeros(1,numToInclude);
aShVOff = zeros(1,numToInclude);

for K = 1:numToInclude
    %Load unshaped
    unFname = unFnames(K).name;

    M = dlmread(strcat(unDirName,unFname),'\t',1,0);
    T = M(:,1);
    V = M(:,2);
    unV = double(V+0.0);
    unT = T*1E6;
    [VmaxVal,vMaxInd] = max(V);
    %quick and temp removal of saturated events
    if VmaxVal>=2.2 & ~bShaped
        fprintf('Event %d Saturated!\n',evNum);
        return;
    end  
  
    %Load shaped
    shFname = shFnames(K).name;

    M = dlmread(strcat(shDirName,shFname),'\t',1,0);
    T = M(:,1);
    V = M(:,2);
    shV = double(V+0.0);
    shT = T*1E6;
    [VmaxVal,vMaxInd] = max(V);
    %quick and temp removal of saturated events
    if VmaxVal>=2.2 & ~bShaped
        fprintf('Event %d Saturated!\n',evNum);
        return;
    end
    shVOffSet = mean(V(100:1100));  
    
    aUnVOff(K) = unVOffSet;
    aShVOff(K) = shVOffSet;

    if rem(K,10)==0
      fprintf('Loaded %d events\n',K);
    end
    if bPlot
        figure(1)
        clf;
        plot(unT,unV,'b')
        xlabel('T (us)');
        ylabel('V (V)');
        title('Preamp Voltage');
        
        figure(2)
        clf;
        plot(shT,shV,'r')
        xlabel('T (us)');
        ylabel('V (V)');
        title('Shaper Voltage');  
        pause
    end  
end

mean(aUnVOff)
mean(aShVOff)