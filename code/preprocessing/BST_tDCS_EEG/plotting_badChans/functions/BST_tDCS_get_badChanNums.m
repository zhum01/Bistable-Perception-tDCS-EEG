function [chanNums] = BST_tDCS_get_badChanNums(eegDataChansStrs, findChansStrs)
%%

%%
chanNums = nan(1,length(findChansStrs));

for chanStrNum = 1:length(findChansStrs)
    badChanNum = find(strcmp(findChansStrs{chanStrNum}, eegDataChansStrs));
    if ~isempty(badChanNum)
        chanNums(chanStrNum) = badChanNum;
    end
end

chanNums(isnan(chanNums)) = [];



