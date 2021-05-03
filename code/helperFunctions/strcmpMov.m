function [anyTrue, trueInds] = strcmpMov(tokenStr, strToSearchIn)
%% Use a sliding window to search if tokenStr appears anywhere in strToSearchIn

%%

% if a cell vector with multiple strings is inputted, break it up and do strcmpMov one string at a time
if iscell(strToSearchIn) && length(strToSearchIn) > 1
    searchInStrCell = strToSearchIn;
    anyTrue = nan(size(strToSearchIn));
    trueInds = cell(size(strToSearchIn));
else
    searchInStrCell = {strToSearchIn};
end

% element-wise strcmpMov
for searchInStrNum = 1:length(searchInStrCell)
    strToSearchIn = searchInStrCell{searchInStrNum};
    searchStrLength = length(tokenStr);
    
    allStrcmps = nan(1, length(strToSearchIn) - searchStrLength + 1);
    
    for searchInStrInd = 1:length(strToSearchIn) - searchStrLength + 1
        allStrcmps(searchInStrInd) = strcmp(strToSearchIn(searchInStrInd:searchInStrInd + searchStrLength - 1), tokenStr);
    end
    
    if exist('trueInds', 'var') && iscell(trueInds)
        anyTrue(searchInStrNum) = any(allStrcmps);
        trueInds{searchInStrNum} = find(allStrcmps == 1):find(allStrcmps == 1) + searchStrLength - 1;
    else
        anyTrue = any(allStrcmps);
        trueInds = find(allStrcmps == 1):find(allStrcmps == 1) + searchStrLength - 1;
    end
end


end