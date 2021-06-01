function rSquared = rSquared(y,predictedY)

SST = 0;
SSE = 0;
for n = 1:length(y)
    SST = SST + (y(n) - mean(y))^2;
    SSE = SSE + (y(n) - predictedY(n))^2; 
end
rSquared = 1 - (SSE/SST);
end
