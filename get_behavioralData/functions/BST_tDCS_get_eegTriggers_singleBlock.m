function [triggerValues, triggerTimes] = BST_tDCS_get_eegTriggers_singleBlock(blockNum, eegDataDir, triggerFName, vars)
%% Load in the eeg file that contains trigger data. Then get all trigger types and times of triggers for a single block.


%%

markersStruct = ft_read_event([eegDataDir triggerFName]);

% if all blocks are in one recording file, cut out triggers from other blocks
if strcmp(triggerFName(end-13:end-5), 'allBlocks') || strcmp(triggerFName(1:end), 'sub18pos_allBlocks_02-06.vmrk') % sub18 had one session with 5 blocks saved in one file
    allBlocksStartInds = find(strcmp({markersStruct.value},  ['S ' num2str(vars.trigAmbigBlockStart)]) | strcmp({markersStruct.value},  ['S ' num2str(vars.trigDiscontBlockStart)]));
    allBlocksEndInds = find(strcmp({markersStruct.value},  ['S ' num2str(vars.trigAmbigBlockEnd)]) | strcmp({markersStruct.value},  ['S ' num2str(vars.trigDiscontBlockEnd)]));
    allBlocksEndInds(diff(allBlocksEndInds) == 1) = []; % remove unwanted triggers that are sent one sample before end of block triggers  
    
    % adjust for false triggers due to unexpected experimental errors
    accountForType = 'falseTriggers';
    BST_tDCS_accountFor_falseTriggers_and_otherErrors
    
    % get triggers for start and end of the current block
    currBlockStartInd = allBlocksStartInds(blockNum);
    currBlockEndInd = allBlocksEndInds(blockNum);
    
    markersStruct = markersStruct(currBlockStartInd:currBlockEndInd);
end

triggerChannelStrs = {markersStruct.value};
validTriggerInds = false(1, length(triggerChannelStrs)); % create a vector of 0s that will be filled with some 1s after valid triggers are found

% get all valid trigger indices (using a for loop because cellfun runs into problems with empty cells)
for triggerDataInd = 1:length(triggerChannelStrs) 
    if ~isempty(triggerChannelStrs{triggerDataInd}) && strcmp(triggerChannelStrs{triggerDataInd}(1:2), 'S ')
        validTriggerInds(triggerDataInd) = 1;
    end
end

% get only the number values at each trigger
triggerValues = cellfun(@(x) str2double(x(end-1:end)), triggerChannelStrs(validTriggerInds))'; 
triggerTimes = [markersStruct(validTriggerInds).sample]';


end



