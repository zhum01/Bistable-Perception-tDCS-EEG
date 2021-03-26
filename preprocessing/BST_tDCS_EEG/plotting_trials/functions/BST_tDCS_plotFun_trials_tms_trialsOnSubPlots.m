function [axesH] = BST_tDCS_plotFun_trials_tms_trialsOnSubPlots(allTrialsEegData, largeVarTrialNums, subjNum, tDCSsessionNum, blockNum, trialNum, numTrials, vars)
%%

%%

%%%%%%%%%% used for color coding by sessionNum
% % get stim/sham region for currSess and choose line color accordingly
% BST_tDCS_set_tDCSsessions_perSubj % get which sessNum correspond to which stim/sham regions
% for orderedByRegInd = 1:length(vars.tDCSsessions{subjNum})
%     if tDCSsessionNum == str2double(vars.tDCSsessions{subjNum}{orderedByRegInd}(end))
%         colorOrderInd = orderedByRegInd;
%     end
% end
lineColor = vars.colorOrder{blockNum == vars.blockNumsToPlot};
    
% plot
currTrialData = squeeze(allTrialsEegData(:,:,trialNum))';
if strcmp(vars.absValOrRaw, 'absVal')
    lineH = plot(mean(abs(currTrialData), 2), 'color', lineColor(1:3));
elseif strcmp(vars.absValOrRaw, 'raw')
    lineH = plot((mean(currTrialData, 2)+5)*4, 'color', lineColor(1:3));
end
% thicker lines for bad trials
if any(trialNum == largeVarTrialNums)
    set(lineH, 'color', vars.colorOrder{length(vars.blockNumsToPlot) + 1}(1:3))
end
hold on

% plot labels
BST_tDCS_plotLabs_trials_tms_trialsOnSubPlots

axesH{subjNum}(trialNum) = gca; 
    
    
end



