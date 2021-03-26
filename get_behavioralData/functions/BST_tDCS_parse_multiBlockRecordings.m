function [recordingListFNamesOutput, eegFileSaveType] = BST_tDCS_parse_multiBlockRecordings(recordingListFNamesInput, eegDataDir, vars)
%% This function returns a cell with the name of the file that contains the eeg data for each individual block.
    

%% Must first determine whether a recording file contains data for multiple blocks or only a single block.
% In general, the fist few subjects had their data for each block saved in a different file, 
% while the rest of the subjects had data for all blocks saved in a single file.

if length(recordingListFNamesInput) < 6 % if multiple blocks were saved in a single recording file as opposed to a separate recording file for each block
    eegFileSaveType = 'combinedBlocks'; % mark that multiple blocks were saved in at least one recording file
    fileBlockNums = cellfun(@(x) str2double(x(9:10)), recordingListFNamesInput);
    recordingListFNamesTemp = cell(1, length(vars.allBlocksLoop)); % new cell with adjusted file names used for each block
    
    for blockNum = vars.allBlocksLoop 
        if ~any(blockNum == fileBlockNums) 
            if strcmp(recordingListFNamesInput{1}, 'sub13ECR.vhdr') % incorrect file name for sub13ECR (renaming causes problems with file header)
               multiBlockInds = cellfun(@(x) strcmp(x(10:end), 'allBlocks.vhdr'), recordingListFNamesInput); 
            else
                multiBlockInds = cellfun(@(x) strcmp(x(end-13:end-5), 'allBlocks'), recordingListFNamesInput);
            end
            recordingListFNamesTemp{blockNum} = recordingListFNamesInput{multiBlockInds};
        else
            recordingListFNamesTemp{blockNum} = recordingListFNamesInput{blockNum == fileBlockNums};
        end
    end
    recordingListFNamesOutput = recordingListFNamesTemp;
    
else % if each block was saved in a separate file:
    eegFileSaveType = 'separateBlocks';
    recordingListFNamesOutput = recordingListFNamesInput;
end

% sub18_session2_post-tDCS went to bathroom after 1st block so all data for blocks 2-6 were saved in a separate file
accountForType = 'savingMultipleFiles';
BST_tDCS_accountFor_falseTriggers_and_otherErrors



end




