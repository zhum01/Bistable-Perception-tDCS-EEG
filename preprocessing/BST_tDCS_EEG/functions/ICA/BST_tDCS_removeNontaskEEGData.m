function eegStruct = BST_tDCS_removeNontaskEEGData(subjNum, blockNum, eegStruct, triggerFName, vars)
%% This function removes all blank datapoints and sets the fields correctly
%in fieldtrip

% Function assumes there is only one trial in the data

%% find times that are not part of the task

vars = BST_tDCS_set_blockVars(blockNum, vars);

eegData = eegStruct.trial{1};
eegDataDir = [pwd '/'];

[triggerValues, triggerTimes] = BST_tDCS_get_eeg_triggerTimes(subjNum, blockNum, eegDataDir, triggerFName, vars);

blockStartTime = triggerTimes(triggerValues == vars.trigBlockStart);
blockEndTime = triggerTimes(triggerValues == vars.trigBlockEnd);
if length(blockStartTime) > 1
    disp('More than one blockStart trigger found')
end


%% remove nontask periods

if ~isempty(blockStartTime)
    taskTime = blockStartTime:blockEndTime - 1;
    
    eegData = eegData(:,taskTime);
    eegStruct.trial = {eegData};
    
    eegTimes = eegStruct.time{1};
    eegStruct.time = {eegTimes(taskTime)};
    
    eegStruct.hdr.nSamples = length(taskTime);
    eegStruct.sampleinfo = [1 length(taskTime)];
end


end




