function data = BVA2Matlab(filename)
%   
%   Import data preprocessed in Brain Vision Analyzer to MATLAB for use in Fieldtrip.
%
%   INPUT:
%
%       filename    =     'File location' character string indexing the location at which data was exported to from BVA (Example: 'C:\BVA\Export').
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

if length(findTrial) == 1
trialLength = size(dat.dataset,2)/(vhdr.Fs);                                % Check if the data is 1 trial long (ERP), or greater than 1 trial long  
else                                                                        % (time-frequency analyses).
trialLength = findTrial(2) - findTrial(1);                                  
end

StartTime = -(findTime(1) - 1)/vhdr.Fs;                                     
EndTime = StartTime + (trialLength/vhdr.Fs);                                % Define the length of each trial, the start time, the end time, and 
numTrial = size(dat.dataset,2)/trialLength;                                 % the number of trials.

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
