function [lat,amp] = fractionalAreaLatency(erp,peakDetect,channels,ampBound,componentDir,ampWindowSize)
 
data = erp.avg(channels,peakDetect(1):peakDetect(2));                       % Select the appropriate data.

if length(channels) > 1                                                     % If more than one channel is being used, average across channels.
    data = mean(data,1);
end

if contains(componentDir,'neg')                                             % If the component is negative, look at data under the amplitude boundary. 
    curve = data(data < ampBound);
elseif contains(componentDir,'pos')                                         % If the component is positive, look at data above the amplitude boundary. 
    curve = data(data > ampBound);
end

if isempty(curve)
    fprintf('\n Error: No data exists above/below amplitude boundary! \n')
    lat = nan; amp = nan;
    return
end

latency = find(cumsum(curve) <= sum(curve)/2, 1);                           % Find the point that divides the area under the curve in two.

if ampWindowSize > latency
    amp = mean(data(1:(latency + ampWindowSize)));                          % Using the surrounding time window ('ampWindowSize'), calculate the mean amplitude.
    elseif ampWindowSize < latency                                          % If the latency extends beyond the start (or end) of the time window used in the 
    amp = mean(data((latency - ampWindowSize):end));                        % calculation, use the start (or end) of the time window as an edge instead.
    else
    amp = mean(data((latency - ampWindowSize):(latency + ampWindowSize)));      
end

lat = erp.time(latency + peakDetect(1))*1000;
fprintf('\n 50%% Fractional Area Latency: \n %3.0f ms \n\n Mean Amplitude with %2.f ms Window: \n %2.3f uV \n',lat,ampWindowSize,amp)

end