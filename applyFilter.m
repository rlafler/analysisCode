function [fV] = applyFilter(V,Fs)
    Fpass = 30E3;
    Fstop = 100E3;
    Astop = 45;
    Apass = 0.01;

    df = designfilt('lowpassfir', ...
      'PassbandFrequency',Fpass,'StopbandFrequency',Fstop, ...
      'PassbandRipple',Apass,'StopbandAttenuation',Astop, ...
      'DesignMethod','equiripple','SampleRate',Fs);
  
%   figure(16);
%   fvtool(df)


%     Fstop1 = 1;
%     Fpass1 = 1E3;
%     Fpass2 = 30E3;
%     Fstop2 = 100E3;
%     Astop1 = 6;
%     Apass  = 0.01;
%     Astop2 = 45;
% 
%     df = designfilt('bandpassfir', ...
%       'StopbandFrequency1',Fstop1,'PassbandFrequency1', Fpass1, ...
%       'PassbandFrequency2',Fpass2,'StopbandFrequency2', Fstop2, ...
%       'StopbandAttenuation1',Astop1,'PassbandRipple', Apass, ...
%       'StopbandAttenuation2',Astop2, ...
%       'DesignMethod','equiripple','SampleRate',Fs);              

        fV = filtfilt(df,V);
return;
end