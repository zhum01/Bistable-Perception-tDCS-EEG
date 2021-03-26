function [subjNumStr] = add_0_before_singleDigit_subjNums(subjNum)
%%


%% subjects 1-9 have a 0 placeholder before subjNum in filenames
if length(num2str(subjNum)) == 1 || (mod(subjNum, 1) ~= 0 && floor(subjNum) < 10) % second clause is for dropped subjects
    subjNumStr = ['0' num2str(subjNum)];
else
    subjNumStr = num2str(subjNum);
end

end