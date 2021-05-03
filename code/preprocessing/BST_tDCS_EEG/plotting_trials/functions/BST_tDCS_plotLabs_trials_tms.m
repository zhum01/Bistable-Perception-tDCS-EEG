

%% x and y lims

set(gca, 'ylim', vars.singlePlotYLims);
set(gca, 'xlim', [0, sum(vars.trialsPrePost)]);
    
xTickLabs = get(gca, 'xticklabel');
zeroedXTicks = [str2double(xTickLabs) - vars.trialsPrePost(1)];
zeroedXTickLabs = arrayfun(@(x) num2str(round(x/1000,1)), zeroedXTicks, 'uniformoutput', false);
set(gca, 'xticklabel', zeroedXTickLabs)
    
%% x and y labels

xlabel('Time Around Button Press (s)', 'fontsize', 14)
ylabel('Abs(Channel Amplitude) ({\mu}V)', 'fontsize', 14)
    

%% titles

title(['sub' num2str(subjNum) ' Session' num2str(tDCSsessionNum) ' (n = ' num2str(numTrials) ' trials total, ' ...
    num2str(length(largeVarTrialNums)) ' bad trials)'], 'fontsize', 18)
    

%% legend

% legend for blocks
for colorNum = 1:length(vars.blockNumsToPlot)
    colorsH(colorNum) = plot(0,0, 'color', vars.colorOrder{colorNum}(1:3), 'linewidth', 3);
    legStrs{colorNum} = ['block' num2str(vars.blockNumsToPlot(colorNum))];
end

colorsH(colorNum+1) = plot(0,0, 'color', vars.colorOrder{length(vars.blockNumsToPlot) + 1}, 'linewidth', 3);
legStrs{colorNum+1} = ['bad trial'];

colorsH(colorNum+2) = plot(0,0, 'color', [0 0 0], 'linewidth', 3);
legStrs{colorNum+2} = ['mean across all trials'];

legH = legend(colorsH, legStrs);
set(legH, 'fontsize', 16)

    
% % legend for sessions
%     for colorNum = 1:length(vars.sessionNumsToPlot)
%         colorsH(colorNum) = plot(0,0, 'color', vars.colorOrder{colorNum}(1:3), 'linewidth', 3);
%         legStrs{colorNum} = vars.targetRegions{subjNum}{colorNum};
%     end
%     
%     legH = legend(colorsH, legStrs);
%     set(legH, 'fontsize', 16)




