function [ledge,redge] = findPeakEdges(data, maxIndex, aIThr)
    ledge = ones(size(aIThr));
    redge = ones(size(aIThr));
    sizeData = length(data);
    edgeTime = 1;
    n = 1;
    while n <= length(aIThr)
        for j =-1:2:2
            i = 0;
            thrhold = aIThr(n);
            while true
                Index = maxIndex+i;
                if and(Index>=0, Index<sizeData)
                    try
                        value = data(Index);
                    catch
    %                     warning('Edge Not Found!')
                        return;
                    end
                    i = i+j;
                    if value < thrhold
                        edgeTime = Index;
                        break;
                    end
                else
                    break;
                end
            end
            if j==-1
                ledge(n) = int32(edgeTime);
            else
                redge(n) = int32(edgeTime);
            end
            edgeTime = 1;
        end
        n = n+1;
    end
    return;
end