function [skewMat,skewArea,skewThr] = calcSkewness(data,pkInd)
    skewMat = 0;skewArea = 0;
%     calcRthMomCur = @(r,x,w,mxw) ((1.0/sum(w))*sum((x-mxw).^r).*w);
%     calcRthMomCur = @(x,w) (sum(((x-sum(x.*w)/sum(w)).^3).*w)./sum(w));
%     calcWMean = @(x,w) sum(x.*w)/sum(w);
    skewns = @(x,y) (sum(((x-sum(x.*y)/sum(y)).^3).*y)./sum(y))./((sum(((x-sum(x.*y)/sum(y)).^2).*y)./(sum(y)-1)).^1.5);
    x = 1:length(data);
    pkH = data(pkInd);
    skewThr = 0.2*pkH;
    [lInd,rInd] = findPeakEdges(data,pkInd,skewThr);
    if (lInd>=rInd || lInd==1)
        return;
    end
    data = (data-skewThr);
    data = data(lInd:rInd);
    x = x(1:length(lInd:rInd));
    midSkewIndex = round(length(x)/2);
    if midSkewIndex > 2
        lArea = trapz(x(1:midSkewIndex),data(1:midSkewIndex));
        rArea = trapz(x(midSkewIndex+1:end),data(midSkewIndex+1:end));
        skewArea = (lArea-rArea)/(lArea+rArea);
    end
    skewMat = skewns(x,data);
end