function dVdt = centralDiff(data,fs)
    delta = 1/fs;
    sizeD = length(data);
    dVdt = zeros(sizeD,1);
    for i=1:sizeD
        value = 0;
        if (i==1) 
            value = (data(i+1)-data(i))/delta;
        elseif (i>= sizeD-1) 
            value = (data(i)-data(i-1))/delta;
        else
            value = (data(i+1)-data(i-1))/(2*delta);
        end
        dVdt(i) = value;
    end
    return;
end
    