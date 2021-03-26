function [triggerValues, triggerTimes] = BST_tDCS_eegTriggers_accountFor_expErrors(subjNum, blockNum, blockTypeStr, eegDataDir, triggerValues, triggerTimes, vars)
%% Prune the trigger data by accounting for experimental errors, primarily from 2 sources:
%   1. Sometimes unknown triggers are sent 1 sample before set triggers 
%      - remove these false triggers
%   2. For discont blocks, the last imgPres of each trial ends before the set 1.5sec is up (because of ePrime settings)
%      - remove data for the last imgPres of each discont trial

%%

% delete the trigger values that were sent unintentionally by the EEG system
    % all subjects >= 12 use a different trigger value for blankOff times
if strcmp(blockTypeStr, 'ambig')
    invalidTrigInds = arrayfun(@(x) ~any(x == vars.validTrigValues), triggerValues); % first get all trigger values that weren't intended
elseif strcmp(blockTypeStr, 'discont')
    if subjNum < 12
        invalidTrigInds = arrayfun(@(x) ~any(x == vars.validTrigValues), triggerValues);
    elseif subjNum >= 12
        validTrigValsPostSub11 = [vars.validTrigValues(vars.validTrigValues ~= 2) 4]; % exclude imgOff triggers because blank durations are determined by blankOff trigger times and not imgOff triggers
        invalidTrigInds = arrayfun(@(x) ~any(x == validTrigValsPostSub11), triggerValues); 
    end
end

triggerValues(invalidTrigInds) = [];
triggerTimes(invalidTrigInds) = [];


% for discont blocks, delete the last imgPres of each trial because it is cut off early (ePrime presents as many imgs as possible in 60s)
if strcmp(blockTypeStr, 'discont')
    invalidImgPresInds = cat(1, find(diff(triggerValues) == 0) ...
                              , find(diff(triggerValues) == vars.(['trig' capitalize_firstChar(blockTypeStr) 'BlockEnd']) - vars.trigImgOn));
        % for debugging:
        % diff(triggerValues) == 0 represents the end of every trial when the blank doesn't come on after the imgPres, so 2 imgPres triggers are sent consecutively
        % diff(triggerValues) == vars.trigBlockEnd - vars.trigImgOn represents the end of the block when no blank is presented so the last trigger is imgOn
    
    triggerValues(invalidImgPresInds) = [];
    triggerTimes(invalidImgPresInds) = [];
end

% for sub17 sess3 block01 - the pre-tDCS recording started saving after block 1 started, so need to add the trigger for ambigBlockStart manually
accountForType = 'blockStartTrigger';
BST_tDCS_accountFor_falseTriggers_and_otherErrors


end




