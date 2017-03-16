function [fV] = applyNotchFilter(V,Fs,aF0, aBW, aAB)
    fV = V;
%     aF0 = [25E3];
%     aBW = [10E3];
%     aAB = [-6];
    for i=1:length(aF0)
        F0 = aF0(i)/(Fs/2);
        BW = aBW(i)/(Fs/2);
        AB = aAB(i);
        [b, a] = iirnotch(F0, BW,AB);
%         fvtool(b,a);
        fV = filter(b,a,V);
    end
%         Fnorm = filtCutFreq/(Fs/2); % Normalized frequency
%     %             df = designfilt('lowpassiir',...
%     %                    'PassbandFrequency',Fnorm,...
%     %                    'FilterOrder',7,...
%     %                    'PassbandRipple',1,...
%     %                    'StopbandAttenuation',6);
%                 Fstop = 100;
%                 Fpass = 101;
%                 Astop = 65;
%                 Apass = 0.5;
%                 df = designfilt('highpassiir','StopbandFrequency',Fstop ,...
%                   'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
%                   'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','butter');
% 
%         fV = filtfilt(df,V);
    return;
end