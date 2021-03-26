function [postProcessedEegData] = BST_tDCS_postProcessing_BPfilter_butter(preProcessedEegData, subjNum, vars)

cfg = [];
cfg.bpfilter = 'yes';
cfg.bpfreq = vars.bpFreqs;
cfg.bpfiltord  = 3;
cfg.bpfilttype = 'but';

postProcessedEegData  = ft_preprocessing(cfg, preProcessedEegData);

% % check the filter - plot the data after filtering
% pwelchSegLength = 2^12;
% [powerData, freqs] = pwelch(postProcessedEegData.trial{1}', hamming(pwelchSegLength),[], pwelchSegLength, vars.eegFs);
% 
% figure('units', 'normalized', 'outerposition', [0 0 .9 .9])
% plot(freqs, powerData);
% xlim([0,55])

end