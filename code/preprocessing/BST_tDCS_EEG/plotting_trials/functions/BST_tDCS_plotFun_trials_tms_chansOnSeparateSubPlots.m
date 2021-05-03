function [axesH] = BST_tDCS_plotFun_trials_tms(currTrialData, ambigTrialsCurrSess, subjNumInd, sessionInd, numChans, vars)
%%

%%

figCounter = 0;

vars.nSubRows = 8;
vars.nSubCols = 8;
lineColor = vars.colorOrder{sessionInd}(1:3);

for chanNum = 1:numChans
    
% create a new figure after all subplots have been used
    if chanNum == vars.nSubRows*vars.nSubCols + 1
        figure('units','normalized','outerposition', [0 0 .9 .9])
        figCounter = figCounter + 1;
    end
    subplotInd = chanNum - figCounter*(vars.nSubRows*vars.nSubCols);
    
% plot
    subH(chanNum) = subplot(vars.nSubRows, vars.nSubCols, subplotInd);
    plot(currTrialData(:, chanNum), 'color', lineColor)
    
    hold(subH(chanNum), 'on')
    axesH{subjNumInd}(chanNum) = gca;
    
% plot labels
    title([ambigTrialsCurrSess(1).chanNames{chanNum}])
    set(gca, 'xlim', [0, sum(vars.trialsPrePost)]);
    maxAbsVal = max(abs([min(currTrialData), max(currTrialData)]));
    set(gca, 'ylim', [-ceil(maxAbsVal), ceil(maxAbsVal)]);
    
    set(gca, 'xtick', sort([get(gca,'xtick'), vars.trialsPrePost(1)]))
    xTickLabs = get(gca, 'xticklabel');
    zeroedXTicks = [str2double(xTickLabs) - vars.trialsPrePost(1)];
    zeroedXTickLabs = arrayfun(@(x) num2str(round(x/1000,1)), zeroedXTicks, 'uniformoutput', false);
    set(gca, 'xticklabel', zeroedXTickLabs)
    
    axPos = get(gca, 'position');
    
    if axPos(1) < .15 && axPos(2) <.15
        xlabel('Time Around Button Press (s)', 'fontsize', 14)
    end
    
    if subplotInd == vars.nSubRows/2*vars.nSubCols + 1
        ylabel('Channel Amplitude ({\mu}V)', 'fontsize', 14)
    end
end
    
end



