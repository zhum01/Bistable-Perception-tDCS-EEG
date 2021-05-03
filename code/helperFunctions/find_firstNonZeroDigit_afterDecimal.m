function [firstNonZeroDigit, ind] = find_firstNonZeroDigit_afterDecimal(inputNum)
%%

%%

inputNumDec = inputNum - round(inputNum); % get rid of digits before decimal
inputNumStr = num2str(inputNumDec);
isZeroInds = [arrayfun(@(x) 0 == str2double(x), inputNumStr)];
[~, nonZeroInds] = find(isZeroInds == 0);
ind = nonZeroInds(2) - 2; % first nonZeroInd is always the decimal, -2 so index starts at first digit after decimal
firstNonZeroDigit = str2double((inputNumStr(ind)));




end



