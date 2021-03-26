function [rawDataFName, triggerFName, eegFileSaveType] = BST_tDCS_get_eegFileName_combOrSepBlocks(subjEegDataDir, blockNum, vars)
%% Get the correct name of the file that conatins data for the input subject and blockNum.

%%
initDir = pwd;

cd(subjEegDataDir);
rawDataList = dir([subjEegDataDir '*.vhdr']);
rawDataFNamesList = {rawDataList.name};

% for recording files with multiple blocks in one file, reorganize into a cell for loading each block individually
[rawDataFNamesList, eegFileSaveType] = BST_tDCS_parse_multiBlockRecordings(rawDataFNamesList, subjEegDataDir, vars);

% get the file name corresponding to current block
if strcmp(eegFileSaveType, 'separateBlocks') % if recording for every block was saved as a separate file
    filesBlockNums = cell2mat(cellfun(@(x) x(10),rawDataFNamesList, 'uniformoutput', false)); % make sure the correct block num is loaded
    rawDataFName = rawDataFNamesList{filesBlockNums == num2str(blockNum)};
elseif strcmp(eegFileSaveType, 'combinedBlocks')
    rawDataFName = rawDataFNamesList{blockNum};
end

triggerFName = [rawDataFName(1:end-4) 'vmrk'];


cd(initDir)

end




    