function rSquaredAdjusted = rSquaredAdjusted(y,predictedY,p)
TSS = [];
    for n = 1:length(y)
        SS = (y(n) - mean(y))^2;
        TSS = [TSS;SS];
    end
TSS = sum(TSS);
SSE = [];
    for n = 1:length(y)
        SE = (y(n) - predictedY(n))^2; 
        SSE = [SSE;SE];
    end
SSE = sum(SSE);
n = length(y);
rSquaredAdjusted = 1 - ((n - 1)/(n - p))*(SSE/TSS);
end
