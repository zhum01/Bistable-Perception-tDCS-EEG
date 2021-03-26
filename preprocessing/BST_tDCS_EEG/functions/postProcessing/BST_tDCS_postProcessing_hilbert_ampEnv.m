function [hilbertEeg] = BST_tDCS_postProcessing_hilbert_ampEnv(preProcessedEegData, subjNum, vars)

cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = vars.bpFreqs;
cfg.bpfiltord  = 3;
cfg.bpfilttype = 'but';

cfg.hilbert = 'abs';

hilbertEeg = ft_preprocessing(cfg, preProcessedEegData);

% % check the amplitude envelope - plot the envelope over the filtered signal
% plotChanNums = 43;
% plotTms = [100000:105000];
% 
% filteredData = BST_tDCS_postProcessing_BPfilter_butter(preProcessedEegData, subjNum, vars);
% 
% figure('units','normalized','outerposition', [0 0 .9 .9])
% plot(filteredData.trial{1}(plotChanNums, plotTms)', 'color', 'k');
% hold on
% plot(hilbertEeg.trial{1}(plotChanNums, plotTms)', 'color', 'r');
% 
% % plotting loaded data
% % plot(postProcessedEegData.trial{1}(plotChanNums, plotTms)', 'color', 'r');


end