

%% x and y lims

set(gca, 'ylim', vars.singlePlotYLims);
set(gca, 'xlim', [0, 60000]);
        
%% x and y labels

xlabel('Time (ms)', 'fontsize', 14)
ylabel('Channel Amplitude ({\mu}V)', 'fontsize', 14)
    

%% titles

title(['sub' num2str(subjNum) ' ECR All Sessions'], 'fontsize', 18)
    

%% legend

% legend for blocks
axPos = get(gca, 'position');
for colorNum = 1:length(vars.sessionNumsToPlot)
    colorsH(colorNum) = plot(0,0, 'color', vars.colorOrder{colorNum}(1:3), 'linewidth', 3);
end

legStrs = vars.targetRegions{1};
legH = legend(colorsH, legStrs);
set(legH, 'fontsize', 16, 'location', 'northeastoutside')
set(gca, 'position', axPos)







