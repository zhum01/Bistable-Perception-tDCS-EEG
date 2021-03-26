function [eprimeData] = BST_tDCS_load_eprimeBehavData(ePrimeDataDirF, vars)
%% This function loads the eprime spreadsheets with the behavioral data for each block.
    % The data for all blocks are stored in the struct 'eprimeData'.

%%

eprimeData = struct; % will contain data from excel sheets

for blockNum = vars.allBlocksLoop % Make sure Excel file contains sheets in order of blocks
    [~, ~, eprimeData(blockNum).allData] = xlsread(ePrimeDataDirF, ['Sheet' num2str(blockNum)]);
    
    eprimeData(blockNum).headers = {eprimeData(blockNum).allData{1,:}};
    eprimeData(blockNum).allData(2,:) = []; % delete first row of data because it corresponds to the response map confirmation and not the task

    %%%%%%%% check that the data in the spreadsheet is for the correct blockNum
    blockNumColumnInd = strcmp(eprimeData(blockNum).headers, 'Session');
    if eprimeData(blockNum).allData{2, blockNumColumnInd} ~= blockNum
        disp(['Block ' num2str(blockNum) ': data in the excel spreadsheet is for a blockNum different from what it is being stored as'])
    end
    %%%%%%%%
    
% Extract useful data from eprime worksheets, and assign the data to variable names
    for headerNum = 1:length(vars.usefulEprimeHeaders)
        columnName = vars.usefulEprimeHeaders{headerNum};
        columnInd = strcmp(eprimeData(blockNum).headers, columnName);
        if any(columnName == '.') % if there are any periods, change the column name so it can be used as a field name
            columnName(columnName == '.') = [];
        end
        eprimeData(blockNum).(columnName) = {eprimeData(blockNum).allData{2:end,columnInd}}'; % reorganize spreadsheet by turning column names into field names
    end
end




end