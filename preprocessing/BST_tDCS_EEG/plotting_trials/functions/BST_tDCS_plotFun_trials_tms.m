function [axesH] = BST_tDCS_plotFun_trials_tms(allTrialsEegData, largeVarTrialNums, subjNum, tDCSsessionNum, blockNum, trialNum, numTrials, vars)
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
    lineH = plot(mean(abs(currTrialData), 2), 'color', lineColor);
 % thicker lines for bad trials
    if any(trialNum == largeVarTrialNums)
        set(lineH, 'color', vars.colorOrder{length(vars.blockNumsToPlot) + 1}, 'linewidth', 2)
    end
    hold on
    
    axesH{subjNum}(trialNum) = gca;
    
% plot labels and plot mean across trials for current session 
if trialNum == numTrials
    plot(mean(mean(abs(allTrialsEegData), 3), 1), 'color', [0 0 0], 'linewidth', 3)
    
    % plot labels
    BST_tDCS_plotLabs_trials_tms
end
    

end



