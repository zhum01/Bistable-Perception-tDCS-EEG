

%% x and y lims

set(gca, 'ylim', vars.subPlotsYLims)
set(gca, 'xlim', [0, sum(vars.trialsPrePost)])
    
if trialNum > vars.nSubCols*(vars.nSubRows - 1)
    xTickLabs = get(gca, 'xticklabel');
    zeroedXTicks = [str2double(xTickLabs) - vars.trialsPrePost(1)];
    zeroedXTickLabs = arrayfun(@(x) num2str(round(x/1000,1)), zeroedXTicks, 'uniformoutput', false);
    set(gca, 'xticklabel', zeroedXTickLabs)
else
    set(gca, 'xticklabel', [])
end
    
%% x and y labels
axPos = get(gca, 'position');

if axPos(1) < .15 && axPos(2) < .15
    xlabel('Time Around Button Press (s)', 'fontsize', 14)
end

if trialNum == (vars.nSubCols*vars.nSubRows/2 + 1)
    ylabel('Channel Amplitude ({\mu}V)', 'fontsize', 14)
end

%% titles

title(['trial' num2str(trialNum)])
    
%% legend

if mod(trialNum, vars.nSubRows*vars.nSubCols) == 0 % supertitle after last subplot
    
    suptit = suptitle(['sub' num2str(subjNum) ' Session' num2str(tDCSsessionNum) ' (n = ' num2str(numTrials) ' trials total, ' ...
        num2str(length(largeVarTrialNums)) ' bad trials)']);
    set(suptit, 'fontsize', 18)
end

if trialNum == 1
% legend for blocks
    for colorNum = 1:length(vars.blockNumsToPlot)
        colorsH(colorNum) = plot(0,0, 'color', vars.colorOrder{colorNum}(1:3), 'linewidth', 3);
        legStrs{colorNum} = ['block' num2str(vars.blockNumsToPlot(colorNum))];
    end
    
    colorsH(colorNum+1) = plot(0,0, 'color', vars.colorOrder{length(vars.blockNumsToPlot) + 1}(1:3), 'linewidth', 3);
    legStrs{colorNum+1} = ['bad trial'];
    
    legH = legend(colorsH, legStrs);
    set(legH, 'fontsize', 12, 'location', 'northwestoutside')
    set(gca, 'position', axPos)
end

    
% % legend for sessions
%     for colorNum = 1:length(vars.sessionNumsToPlot)
%         colorsH(colorNum) = plot(0,0, 'color', vars.colorOrder{colorNum}(1:3), 'linewidth', 3);
%         legStrs{colorNum} = vars.targetRegions{subjNum}{colorNum};
%     end
%     
%     legH = legend(colorsH, legStrs);
%     set(legH, 'fontsize', 16)




