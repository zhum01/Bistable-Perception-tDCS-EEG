function [buttonDataFName] = BST_tDCS_get_buttonTextData_fileName(blockNum, blockTypeStr, buttonDataDir, vars)
%% Determine the name of the text file that contains the button press data corresponding to a specific block.

%%
    cd(buttonDataDir)
    if strcmp(blockTypeStr, 'ambig')
        buttonDataFNamesToken =  '*ambig*';
    elseif strcmp(blockTypeStr, 'discont')
        buttonDataFNamesToken =  '*discontImgOn*';
    end 
    
    allButtonDataTxts = dir(buttonDataFNamesToken);
    buttonDataFNamesLoop = {allButtonDataTxts.name};
    allFilesBlockNums = cell2mat(cellfun(@(x) str2double(x(20)),buttonDataFNamesLoop, 'uniformoutput', false)); % get a vector of the blockNums based on the files in the directory
    buttonDataFNameCurrBlock = blockNum == allFilesBlockNums; % get the index corresponding to the buttonDataFName for the current block of the loop
    buttonDataFName = buttonDataFNamesLoop{buttonDataFNameCurrBlock};
    % if error occurs at the last line, check that the filenames of the buttonData text files are formatted correctly (should be eg. sub20_task01_block01_ambig.txt) 
    
       
end





