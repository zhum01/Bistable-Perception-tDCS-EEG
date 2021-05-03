function [axesH] = BST_tDCS_plotFun_trials_tms_ECR(allChansEegData, subjNum, tDCSsessionNum, vars)
%%

%%

% get stim/sham region for currSess and choose line color accordingly
BST_tDCS_set_tDCSsessions_perSubj % get which sessNum correspond to which stim/sham regions
for orderedByRegInd = 1:length(vars.tDCSsessions{subjNum})
    if tDCSsessionNum == str2double(vars.tDCSsessions{subjNum}{orderedByRegInd}(end))
        colorOrderInd = orderedByRegInd;
    end
end

% shift y axis of session tms
if colorOrderInd == 2
    yShift = 3;
elseif colorOrderInd == 3
    yShift = -3;
else 
    yShift = 0;
end


lineColor = vars.colorOrder{colorOrderInd}(1:3);
    
% plot
    lineH = plot(mean(allChansEegData, 1) + yShift, 'color', lineColor);
    hold on
    
    axesH{subjNum}(tDCSsessionNum) = gca;
    
% plot labels
    BST_tDCS_plotLabs_trials_tms_ECR
    
    
end






