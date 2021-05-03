function [imgOnTimes, imgOffTimes, blankOnTimes, blankOffTimes, blankDurs] ...
    = BST_tDCS_realign_triggers_to_zeroAtBlockStarts(subjNum, blockTypeStr, blockStartTime, triggerValues, triggerTimes, vars)
%% Realign all triggers so time t = 0 is the start of the block.
    % Most analyses only use data after the block starts.

%% Subtract the block start from each trigger time so all times are zeroed to the start of the block

imgOnTimes = triggerTimes(triggerValues == vars.trigImgOn) - blockStartTime;

if strcmp(blockTypeStr, 'ambig')
    imgOffTimes = triggerTimes(triggerValues == vars.trigImgOff) - blockStartTime;
    
    blankOnTimes = nan;
    blankOffTimes = nan;
    blankDurs = nan;
    
% for discont blocks, also need to realign times of blankOn and blankOff triggers
elseif strcmp(blockTypeStr, 'discont')
    [imgOffTimes, blankOnTimes, blankOffTimes, blankDurs] ...
        = BST_tDCS_discont_realign_blankTriggers(subjNum, blockStartTime, imgOnTimes, triggerValues, triggerTimes, vars);
end



end

