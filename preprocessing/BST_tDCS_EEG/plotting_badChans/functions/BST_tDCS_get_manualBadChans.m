function [finalBadChansStrs] = BST_tDCS_get_manualBadChans(subjNum, tDCSsessionNum, blockNum, autoBadChansStrs, manualBadChansExcel, vars)
%%

%%
falsePosColNum = 5;
addBadChansColNum = 6;

blocksPerSubj = 3*6;
totBlockInd = (subjNum - 1)*blocksPerSubj + (tDCSsessionNum-1)*6 + blockNum; % used to get the correct row number in the excel sheet


% format text in excel into cell for matlab
manualBadChansCurrBlock = cell(addBadChansColNum, 1);
for colNum = [falsePosColNum, addBadChansColNum]
    chansList = upper(manualBadChansExcel(totBlockInd, colNum));
    if strcmp(chansList, 'NONE')
        manualBadChansCurrBlock{colNum} = '';
    else
        manualBadChansCurrBlock{colNum} = strsplit(chansList{1}, ',');
    end
    
% change 'z's to lower case so ft functions can correctly detect channel names
    if ~strcmp(manualBadChansCurrBlock{colNum}, '')    
        for manualChanNum = 1:length(manualBadChansCurrBlock{colNum})
            if strcmp(manualBadChansCurrBlock{colNum}{manualChanNum}(end),'Z')
                manualBadChansCurrBlock{colNum}{manualChanNum}(end) = lower(manualBadChansCurrBlock{colNum}{manualChanNum}(end));
            end
        end
    end
    
end

falsePosChansStrs = manualBadChansCurrBlock{falsePosColNum};
addBadChansStrs = manualBadChansCurrBlock{addBadChansColNum};

manualBadChansStrs = setdiff(autoBadChansStrs, falsePosChansStrs);
finalBadChansStrs = [manualBadChansStrs addBadChansStrs];



end


