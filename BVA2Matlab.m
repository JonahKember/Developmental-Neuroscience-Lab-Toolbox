function data = BVA2Matlab(filename)
%   
%   Import data preprocessed in Brain Vision Analyzer for use in MATLAB and Fieldtrip.
%
%   INPUT:
%
%       filename    =     'File location' character string indexing the export location (Example: 'C:\BVA\Export').
%
%   OUTPUT:
%
%       data        =     Fieltrip structure obtained from ft_preprocessing.
%
%%

seg = [filename,'.seg'];                                                    % Read the data, header, and marker file.
vhdr = ft_read_header([filename,'.vhdr']);
vmrk = ft_read_event([filename,'.vmrk']);

dat.dataset = ft_read_data(seg,'header', vhdr);
dat.label = vhdr.label;

findTrial = [];
findTime = [];

for n = 1:length(vmrk)
t = vmrk(n).type;                                                           % Examine the marker file to find the length of each trial
    if strcmp(t,'New Segment')                                              % and the start/end time.
    findTrial = [findTrial;vmrk(n).sample]; %#ok<AGROW>
    end
    if strcmp(t,'Time 0')
    findTime = [findTime;vmrk(n).sample]; %#ok<AGROW>
    end    
end

trialLength = findTrial(2) - findTrial(1);                                  % Define the length of each trial, the start time, the end time,
StartTime = -(findTime(1) - 1)/vhdr.Fs;                                     % and the number of trials.
EndTime = StartTime + (trialLength/vhdr.Fs);                                
numTrial = size(dat.dataset,2)/trialLength;                                 

ftTime = [];
ftTrial = [];
time = StartTime:(1/vhdr.Fs):(EndTime - (1/vhdr.Fs)); 

for t = 1:numTrial
    trl = dat.dataset(:,(1 + trialLength*(t-1)):trialLength*t);             % Match the time and trials with Fieldtrip's format.
    ftTrial{1,t} = trl;  %#ok<AGROW>
    ftTime{1,t} = time; %#ok<AGROW>
end
                                                                            % Create a data structure with all the relevant fields.
dat.time = ftTime;
dat.trial = ftTrial;
data = ft_preprocessing([], dat);                                           % Run the data structure through fieldtrip's preprocessing function.
