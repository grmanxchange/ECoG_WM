%This function extracts the available number of trials for a specific
%condition of interest
%Project: ECoG_WM
%Author: D.T.
%Date: 15 March 2019

function my_count = ECoG_getTrialCount(data, condition)

if strcmp(condition, 'rule')
    my_count = zeros(1, 2);
    %my_count(1) = sum((data(:, 1) == 0) & (data(:, end-1) ~= 0) & ~isnan((data(:, end))));
    my_count(1) = sum((data(:, 1) == 0) & (data(:, end) ~= 0));
    my_count(2) = sum((data(:, 1) == 1) & (data(:, end) ~= 0));
elseif strcmp(condition, 'load')
    my_count = zeros(1, 3);
    my_count(1) = sum((data(:, 1) == 1) & (data(:, end) ~= 0));
    my_count(2) = sum((data(:, 1) == 2) & (data(:, end) ~= 0));
    my_count(3) = sum((data(:, 1) == 4) & (data(:, end) ~= 0));
elseif strcmp(condition, 'stimID')
    my_count = zeros(1, 10);
        
    for eventi = 1 : 10
        my_count(eventi) = sum(((data(:, 1) == eventi-1 & data(:, end) ~= 0)) | ...
            ((data(:, 2) == eventi-1 & data(:, end) ~= 0)) | ...
            ((data(:, 3) == eventi-1 & data(:, end) ~= 0)) | ...
            ((data(:, 4) == eventi-1 & data(:, end) ~= 0)));
    end

elseif strcmp(condition, 'rule_stimID')
    my_count = zeros(2, 10);
    
    for rulei = 1 : 2
        for eventi = 1 : 10
            my_count(rulei, eventi) = sum(((data(:, 1) == rulei-1 & data(:, 2) == eventi-1 & data(:, end) ~= 0)) | ...
                ((data(:, 1) == rulei-1 & data(:, 3) == eventi-1 & data(:, end) ~= 0)) | ...
                ((data(:, 1) == rulei-1 & data(:, 4) == eventi-1 & data(:, end) ~= 0)) | ...
                ((data(:, 1) == rulei-1 & data(:, 5) == eventi-1 & data(:, end) ~= 0)));
        end
    end
end
end

