function [blockData] = BST_tDCS_get_numImgPres_and_blankDurs_perTrial(blockTypeStr, buttonDataDir, buttonDataFName, eprimeData, blockData, vars)
%% Get the number of images presented in each trial.
    % Mainly used for discont blocks in which there are 6 trials per block but a
    % different number of image presentations per trial depending on the
    % blank duration used in the trial.

%%

buttonData = importdata([buttonDataDir buttonDataFName], '\t');
numImgPres = length(find(strcmp(buttonData, 'Trial')));


for imgPresNum = 1:numImgPres
% store image type, blank duration, trialNum, and imgPresNum in each trial
    if strcmp(blockTypeStr, 'ambig')
        blockData.trial(imgPresNum).trialImgPresNum = eprimeData.Block{imgPresNum} - 1; % -1 because of how the task was coded in ePrime
        blockData.trial(imgPresNum).trialNum = eprimeData.Block{imgPresNum} - 1; % -1 because of how the task was coded in ePrime
    elseif strcmp(blockTypeStr, 'discont')
        blockData.trial(imgPresNum).trialImgPresNum = eprimeData.Trial{imgPresNum};
        blockData.trial(imgPresNum).trialNum = eprimeData.trialListSample{imgPresNum};
    end
end

% get number of image presentations per trial and the start/end indices of each trial
imgPresNumData = [blockData.trial.trialImgPresNum];
blockData.trialEndInds = [find(diff([blockData.trial.trialNum]) == 1), length(imgPresNumData)];
blockData.trialStartInds = [1, blockData.trialEndInds(1:end-1) + 1];
blockData.numImgPresPerTrial = imgPresNumData(blockData.trialEndInds);




end