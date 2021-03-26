function [chanNums] = BST_tDCS_get_chanNumsFromStrs(eegDataChansStrs, chanStrs)
%%

%%
chanNums = nan(1,length(chanStrs));

for chanStrNum = 1:length(chanStrs)
    badChanNum = find(strcmp(chanStrs{chanStrNum}, eegDataChansStrs));
    if ~isempty(badChanNum)
        chanNums(chanStrNum) = badChanNum;
    end
end

chanNums(isnan(chanNums)) = [];



