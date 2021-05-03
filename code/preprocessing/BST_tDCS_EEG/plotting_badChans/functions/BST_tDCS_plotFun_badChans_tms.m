function [axesH, textH] = BST_tDCS_plotFun_badChans_tms(eegData, allChansStrs, badChansStrs, badChansStats, subjNumStr, tDCSsessionNum, blockNum, vars)
%%

%%

badChanNums = BST_tDCS_get_chanNumsFromStrs(eegData.label, badChansStrs);
goodChanNums = BST_tDCS_get_chanNumsFromStrs(eegData.label, setdiff(allChansStrs, badChansStrs));

zVarsAllChans = round(zscore(badChansStats.varianceChannels), 2); % z-scored variance will be included in titles of channels
saturatedChanNums = find(badChansStats.percentageSaturated(1:64) > 10 | badChansStats.percentageFlat(1:64) > 10);    

for chanNum = 1:length(eegData.label)
    subplot(9,8,chanNum)
    if strcmp(vars.rawOrProc, 'raw')
        plot(eegData.trial{1}(chanNum,:)')
    elseif strcmp(vars.rawOrProc, 'processed')
        plot(eegData.trial{blockNum}(chanNum,:)')
    end
    
    if any(chanNum == saturatedChanNums)
        plotTit = title([eegData.label{chanNum}  ', ' num2str(zVarsAllChans(chanNum)) ', sat']);
    else
        plotTit = title([eegData.label{chanNum}  ', ' num2str(zVarsAllChans(chanNum))]);
    end
    
% label bad channels red
    if any(chanNum == badChanNums)
        set(plotTit, 'color', [1 0 0])
    end
        
    set(gca, 'xlim', vars.xLims)
    set(gca, 'xtick', xlim)
    
    if chanNum == 1
        leftMargText = sprintf([num2str(length(badChansStrs)) ' badChans\n\n' ...
            'numbers in titles\n' ...
            'are z-scored\n' ...
            'variance']);
        xLims = xlim;
        yLims = ylim;
        
        textH = text(xLims(1) - abs(xLims(2)*1.5), yLims(1), leftMargText, 'fontsize', 14);
    end
    
    
    axesH(chanNum) = gca;
end

supTit = suptitle(['sub' subjNumStr ' session' num2str(tDCSsessionNum) ' block' num2str(blockNum)]);
set(supTit, 'fontsize', 18)


end




