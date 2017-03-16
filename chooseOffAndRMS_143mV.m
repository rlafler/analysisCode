function [offsetV, rmsV, rmsI] = chooseOffAndRMS_143mV(bShaped,type,date)
    offsetV = 0; rmsV = 0; rmsI = 0;
    if ~bShaped
       if strcmp(type,'DD')
            if strcmp(date,'2-23-17')
                rmsV = 0.0012;
                offsetV = -0.0238;
                rmsI = 0.1218;
            elseif strcmp(date,'2-25-17')
                rmsV = 0.0013;
                offsetV = -0.0233;
                rmsI = 0.1255;
            elseif strcmp(date,'3-8-17')
                rmsV = 0.00085;
                offsetV = -0.0298;
                rmsI = 0.1041;
            elseif strcmp(date,'3-9-17')
                rmsV = 0.00081;
                offsetV = -0.0322;
                rmsI = 0.1007;                
            end
       elseif strcmp(type,'Laser')
            if strcmp(date,'9-19-16_1st')
                rmsV = 0.0081; %laser 9-19-16 (1st)
                offsetV = -0.0536;
                rmsI = 0.4337;       
            end
       elseif strcmp(type,'Background')
            if strcmp(date,'9-19-16')
                rmsV = 0.0026; %Back 9-19-16 
                offsetV = -0.0416;
                rmsI = 0.0981;
            elseif strcmp(date,'2-28-17')
                rmsV = 0.00026; 
                offsetV = -0.0376;
                rmsI = 0.0611;
            elseif strcmp(date,'3-1-17')
                rmsV = 0.00099; 
                offsetV = -0.0241;
                rmsI = 0.1148;                  
            end
       elseif strcmp(type,'Co60')
            if strcmp(date,'9-20-16')
                rmsV = 0.0071; %Co60 9-20-16 
                offsetV = -0.0465;
                rmsI = 0.2039;
            elseif strcmp(date,'3-13-17')
                rmsV = 0.00091; 
                offsetV = -0.0307;
                rmsI = 0.1060;                
            end
       elseif strcmp(type,'Fe55')
           if strcmp(date,'2-23-17_pre_DD')
                rmsV = 0.00026; 
                offsetV = -0.0362;
                rmsI = 0.0603; 
           elseif strcmp(date,'2-23-17_post_DD')
                rmsV = 0.00025; 
                offsetV = -0.0355;
                rmsI = 0.0595;
           elseif strcmp(date,'2-25-17_pre_DD_Cathode')
                rmsV = 0.00029; 
                offsetV = -0.0364;
                rmsI = 0.0612;
           elseif strcmp(date,'2-25-17_post_DD_Cathode')
                rmsV = 0.00026; 
                offsetV = -0.0372;
                rmsI = 0.0608;                
           elseif strcmp(date,'2-25-17_pre_DD_GEM')
                rmsV = 0.00026; 
                offsetV = -0.0440;
                rmsI = 0.0631;
           elseif strcmp(date,'2-28-17')
                rmsV = 0.00028; 
                offsetV = -0.0383;
                rmsI = 0.0628;
           elseif strcmp(date,'3-1-17_pre_Background')
                rmsV = 0.00026; 
                offsetV = -0.0361;
                rmsI = 0.0591;
           elseif strcmp(date,'3-1-17_post_Background')
                rmsV = 0.00028; 
                offsetV = -0.0368;
                rmsI = 0.0620;
           elseif strcmp(date,'3-8-17_pre_DD')
                rmsV = 0.00024; 
                offsetV = -0.0371;
                rmsI = 0.0510;
           elseif strcmp(date,'3-8-17_post_DD')
                rmsV = 0.00026; 
                offsetV = -0.0371;
                rmsI = 0.0504;
           elseif strcmp(date,'3-9-17_pre_DD')
                rmsV = 0.00024; 
                offsetV = -0.0384;
                rmsI = 0.0516;
           elseif strcmp(date,'3-9-17_post_DD')
                rmsV = 0.00038; 
                offsetV = -0.0373;
                rmsI = 0.0570;
           elseif strcmp(date,'3-13-17_pre_Co60')
                rmsV = 0.00027; 
                offsetV = -0.0390;
                rmsI = 0.0539;
           elseif strcmp(date,'3-13-17_post_Co60')
                rmsV = 0.00024; 
                offsetV = -0.0383;
                rmsI = 0.0514;
           elseif strcmp(date,'3-14-17_pre_Co60')
                rmsV = 0.00026; 
                offsetV = -0.0387;
                rmsI = 0.0531;
           elseif strcmp(date,'3-14-17_post_Co60')
                rmsV = 0.00024; 
                offsetV = -0.0384;
                rmsI = 0.0524;                 
           end
       end
    else %%shaped
        if strcmp(type,'DD')
            if strcmp(date,'2-23-17')
                rmsV = 0.0012;
                offsetV = -0.0018;
            elseif strcmp(date,'2-25-17')
                rmsV = 0.0012;
                offsetV = 0.00068; 
            elseif strcmp(date,'3-8-17')
                rmsV = 0.0009;
                offsetV = -0.0074;
            elseif strcmp(date,'3-9-17')
                rmsV = 0.0009;
                offsetV = -0.0073;                
            end
        elseif strcmp(type,'Laser')
            if strcmp(date,'9-19-16_1st')
                rmsV = 0.0122; %laser 9-19 (1st)
                offsetV = -0.0565;
            end
        elseif strcmp(type,'Background')
            if strcmp(date,'9-19-16')
                rmsV = 0.0029; %back 9-19-16
                offsetV = -0.0030;
            elseif strcmp(date,'2-28-17')
                rmsV = 0.00063; %back 9-19-16
                offsetV = -0.00096;
            elseif strcmp(date,'3-1-17')
                rmsV = 0.0011; %back 9-19-16
                offsetV = -0.00098;                
            end
        elseif strcmp(type,'Fe55')
            if strcmp(date,'2-23-17_pre_DD')
                rmsV = 0.00064;
                offsetV = -0.00083;         
            elseif strcmp(date,'2-23-17_post_DD')
                rmsV = 0.00064;
                offsetV = -0.00085;
            elseif strcmp(date,'2-25-17_pre_DD_Cathode')
                rmsV = 0.00064;
                offsetV = -0.00094;
            elseif strcmp(date,'2-25-17_post_DD_Cathode')
                rmsV = 0.00064;
                offsetV = -0.00062;                
            elseif strcmp(date,'2-25-17_pre_DD_GEM')
                rmsV = 0.00057;
                offsetV = -0.00097;
            elseif strcmp(date,'2-28-17')
                rmsV = 0.00064;
                offsetV = -0.0011;
            elseif strcmp(date,'3-1-17_pre_Background')
                rmsV = 0.00078;
                offsetV = -0.0011;
            elseif strcmp(date,'3-1-17_post_Background')
                rmsV = 0.00061;
                offsetV = -0.00078;
            elseif strcmp(date,'3-8-17_pre_DD')
                rmsV = 0.00041;
                offsetV = -0.0011;
            elseif strcmp(date,'3-8-17_post_DD')
                rmsV = 0.00041;
                offsetV = -0.0009;
            elseif strcmp(date,'3-9-17_pre_DD')
                rmsV = 0.00042;
                offsetV = -0.0014; 
            elseif strcmp(date,'3-9-17_post_DD')
                rmsV = 0.00053;
                offsetV = -0.0009;
            elseif strcmp(date,'3-13-17_pre_Co60')
                rmsV = 0.00044;
                offsetV = -0.0016;
            elseif strcmp(date,'3-13-17_post_Co60')
                rmsV = 0.00040;
                offsetV = -0.0012;
            elseif strcmp(date,'3-14-17_pre_Co60')
                rmsV = 0.00040;
                offsetV = -0.0012;  
            elseif strcmp(date,'3-14-17_post_Co60')
                rmsV = 0.00040;
                offsetV = -0.0010;                
            end
        elseif strcmp(type,'Co60')
            if strcmp(date,'9-20-16')
                rmsV = 0.0071; %Co60 9-20-16
                offsetV = -0.0137;
            elseif strcmp(date,'3-13-17')
                rmsV = 0.00043;
                offsetV = -0.0014;                
            end
        end
    rmsI = rmsV;
    end 
end