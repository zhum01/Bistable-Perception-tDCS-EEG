function behavDataSingleSession = BST_tDCS_load_all_behavFiles_and_store_behavData(subjNum, dirsStruct, vars)
%% This function loads the necessary data files for parsing the behavioral data
% and then stores the parsed data in a behavData struct.

% 3 components to load:
    % 1. eprime data (.xls spreadsheets) - contains data including blockType, imgType, blank durations, etc. 
    % 2. button response data (text files) - contains data for time of each button press, type, and duration
    % 3. trigger data (EEG (.vmrk) files) - contains data for trigger times of blockStarts and imm onsets
    
% Inputs:
%   1. subjNum - subject number to load data for
%   2. dirsStruct - struct containing strs for all directories to load data from
%   3. vars - struct containing experimental parameters (BST_tDCS_setVars)

% Outputs:
%   1. behavDataSingleSession - struct containing the parsed beavioral data for a single session of subjNum
    
%% Initialize

behavDataSingleSession = struct;

%% Load EPrime behavioral data from excel sheets

% make sure Excel file ePrimeFilename contains sheets in order of filenames
[eprimeData] = BST_tDCS_load_eprimeBehavData(dirsStruct.eprimeDataDirF, vars);

%% Store all data from trigger files and button press files in a behavData struct

for blockNum = vars.allBlocksLoop
    
    blockTypeStr = BST_tDCS_get_blockTypeStr(blockNum, vars);
        
%% get the trigger file name corresponding to current block
    [~, triggerFName, ~] = BST_tDCS_get_eegFileName_combOrSepBlocks(dirsStruct.eegDataDir, blockNum, 'task', vars);
    

%% load the trigger data and get the times of blockStarts and trialStarts
    if str2double(triggerFName(10)) == blockNum || strcmp(triggerFName(end-13:end-5), 'allBlocks') || strcmp(triggerFName(1:end), 'sub18pos_allBlocks_02-06.vmrk')

        [triggerValues, triggerTimes] = BST_tDCS_get_eegTriggers_singleBlock(blockNum, dirsStruct.eegDataDir, triggerFName, vars);
        [triggerValues, triggerTimes] = BST_tDCS_eegTriggers_accountFor_expErrors(subjNum, blockNum, blockTypeStr, dirsStruct.eegDataDir, triggerValues, triggerTimes, vars);

        trigTimesStruct.blockStartTime = triggerTimes(triggerValues == vars.(['trig' capitalize_firstChar(blockTypeStr) 'BlockStart']));
        trigTimesStruct.blockEndTime = triggerTimes(triggerValues == vars.(['trig' capitalize_firstChar(blockTypeStr) 'BlockEnd']));
        
        if length(trigTimesStruct.blockStartTime) > 1 % check for abnormalities
            disp('More than one blockStart trigger found%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
        end
        
% realign triggers so t = 0 is at time of the start of blocks
        [trigTimesStruct.imgOnTimes, trigTimesStruct.imgOffTimes, trigTimesStruct.blankOnTimes, trigTimesStruct.blankOffTimes, blankDurs] ...
            = BST_tDCS_realign_triggers_to_zeroAtBlockStarts(subjNum, blockTypeStr, trigTimesStruct.blockStartTime, triggerValues, triggerTimes, vars);
        
%% load the button press data and then store in a behavData struct
        
        [buttonDataFName] = BST_tDCS_get_buttonTextData_fileName(blockNum, blockTypeStr, dirsStruct.buttonDataDir, vars);
        
        [behavDataSingleSession.block(blockNum)] = BST_tDCS_store_buttonPressData...
            (blockNum, blockTypeStr, dirsStruct.buttonDataDir, buttonDataFName, trigTimesStruct, blankDurs, eprimeData, vars);
    
    end
end


end







