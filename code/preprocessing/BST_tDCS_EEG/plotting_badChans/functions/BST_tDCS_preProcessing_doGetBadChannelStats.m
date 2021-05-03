function BST_tDCS_preProcessing_doGetBadChannelStats(subjName, tDCSsessionNum,blockNum,eegStruct, vars)

%% Parameters

eegChans = 1:64;
EMGChans = 65:66;
EOGChans = 67:70;
MastChans = 71:72;
numChans = 72;
saturationThreshold = 3276.6;

%% Filtering Parameters

cfg = [];
cfg.demean = 'yes';
cfg.detrend = 'yes';
cfg.bsfilter   = 'yes';
cfg.bsfreq     = [58 62; 118 122; 178 182];
cfg.bsfiltord  = 4;
cfg.bsfilttype = 'but';
cfg.hpfilter = 'yes';
cfg.hpfreq = 0.5;
cfg.hpfiltord  = 3;
cfg.hpfilttype = 'but';
cfg.lpfilter = 'yes';
cfg.lpfreq = 58;
cfg.lpfiltord  = 3;
cfg.lpfilttype = 'but';
postProcessedEegData  = ft_preprocessing(cfg, eegStruct);

%%
stats = struct;
lengthBlock = size(eegStruct.trial{1},2);
stats.percentageSaturated = floor(100 * (sum(abs(eegStruct.trial{1})>saturationThreshold,2) / lengthBlock));
stats.percentageFlat =      floor(100 *(sum(diff(eegStruct.trial{1},1,2)==0,2) / lengthBlock));

figure;
plot(stats.percentageSaturated,'r')
hold on
plot(stats.percentageFlat,'k')
axis([0 73 0 100]);
refline(0,10);
numSaturated = nnz(stats.percentageSaturated > 10);
numFlat = nnz(stats.percentageFlat > 10);
legend({['% Saturated (n=' num2str(numSaturated) ')'], ...
    ['% Flat      (n=' num2str(numFlat)      ')']});
xlabel('Channel Number')
ylabel('Time (%)');
set(gcf,'position',[ 149         501        1628         361])
title([subjName ' Session ' num2str(tDCSsessionNum) ' Block ' num2str(blockNum)]);
saveas(gcf,[vars.saveDir 'Figures/' subjName '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_SaturatedFlat.png']);
close all

figure;
plot(1/1000:1/1000:lengthBlock/1000,eegStruct.trial{1}(MastChans(1),:),'r')
hold on
plot(1/1000:1/1000:lengthBlock/1000,eegStruct.trial{1}(MastChans(2),:),'k')
legend({['% Saturated (n=' num2str(numSaturated) ')'], ...
    ['% Flat      (n=' num2str(numFlat)      ')']});
xlabel('Channel Number')
ylabel('Time (%)');
[stats.MastR,stats.MastP] = corr(eegStruct.trial{1}(MastChans(1),:)',eegStruct.trial{1}(MastChans(2),:)');
legend({['Mast1 (r=' num2str(stats.MastR,2) ')'], ...
    ['Mast2 (p=' num2str(stats.MastP,2) ')']});

set(gcf,'position',[ 149         501        1628         361])
title([subjName ' Session ' num2str(tDCSsessionNum) ' Block ' num2str(blockNum)]);
saveas(gcf,[vars.saveDir 'Figures/' subjName '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_Mastoids.png']);
close all

%%
stats.varianceChannels = var(postProcessedEegData.trial{1},[],2);
stats.badChannels = find(stats.percentageSaturated(eegChans) > 10 | stats.percentageFlat(eegChans) > 10);
stats.goodChannels = setdiff(eegChans,stats.badChannels);
stats.badChanStrs = eegStruct.label(stats.badChannels);
stats.goodChanStrs = eegStruct.label(stats.goodChannels);
[vals,inds] = sort(abs((zscore(stats.varianceChannels(stats.goodChannels)))));

while max(vals) > 3
    stats.badChannels = [stats.badChannels; stats.goodChannels(inds(vals>3))'];
    stats.goodChannels = setdiff(eegChans,stats.badChannels);
    [vals,inds] = sort(abs((zscore(stats.varianceChannels(stats.goodChannels)))));
end

stats.varianceTime = var(postProcessedEegData.trial{1}(eegChans(stats.goodChannels),:));

if numel(stats.goodChannels) > 2
    figure
    subplot(2,1,1)
    plot(1/1000:1/1000:lengthBlock/1000,postProcessedEegData.trial{1}(stats.goodChannels,:)');
    title(['Good Channels ' subjName ' Session ' num2str(tDCSsessionNum) ' Block ' num2str(blockNum)]);
    xlabel('Time (seconds)');
    ylabel('Amplitude (microVolt)');
    subplot(2,1,2)
    plot(zscore(stats.varianceTime))
    xlabel('Time (seconds)');
    ylabel('zscore(variance Across Good Channels)');
    saveas(gcf,[vars.saveDir 'Figures/' subjName '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_VarianceGoodChannels.png']);
end

save([vars.saveDir 'Stats/' subjName '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_Stats.mat'],'stats');


end






