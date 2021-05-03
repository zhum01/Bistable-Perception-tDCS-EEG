function [triggerValues, triggerTimes] = BST_tDCS_get_eeg_triggerTimes(subjNum, blockNum, eegDataDir, triggerFName, vars)
%%

%% get trigger times and button press times 

[triggerValues, triggerTimes] = BST_tDCS_get_eegTriggers_singleBlock(blockNum, eegDataDir, triggerFName, vars);

[triggerValues, triggerTimes] = BST_tDCS_eegTriggers_accountFor_expErrors(triggerValues, triggerTimes, vars);

end





