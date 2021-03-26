function [largeVarTrialNums] = BST_tDCS_find_largeVarTrials_recursive(allTrialsEegData, trialDataTms, initValidTrialNums, largeZVarThresh)
%%

%%

% trials should be 2nd dimension
if length(size(trialDataTms)) == 2
    if size(trialDataTms, 2) > size(trialDataTms, 1)
        trialDataTms = trialDataTms';
    end
    
% create vectors of trialNums
    allTrialNums = 1:size(trialDataTms, 2);
    largeVarTrialNums = setdiff(allTrialNums, initValidTrialNums); % initiate to channels that are invalid to begin with
    validTrialNums = initValidTrialNums;
    
% get variance across time recursively
    varAcrossTimePerChan = var(trialDataTms,[],1);
    [vals,inds] = sort(abs(zscore(varAcrossTimePerChan(initValidTrialNums))));
    
    while max(vals) > largeZVarThresh
        largeVarTrialNums = [largeVarTrialNums; validTrialNums(inds(vals>largeZVarThresh))'];
        validTrialNums = setdiff(allTrialNums,largeVarTrialNums);
        [vals,inds] = sort(abs(zscore(varAcrossTimePerChan(validTrialNums))));
    end
    
    if ~exist('largeVarTrialNums', 'var')
        largeVarTrialNums = nan;
    end
end



end



