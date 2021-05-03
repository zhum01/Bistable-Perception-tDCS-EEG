function [postProcessedEegData] = BST_tDCS_postProcessing_LP58_butter(preProcessedEegData, subjNum, vars)

cfg = [];
cfg.lpfilter = 'yes';
cfg.lpfreq = 58;
cfg.lpfiltord  = 3;
cfg.lpfilttype = 'but';

postProcessedEegData  = ft_preprocessing(cfg, preProcessedEegData);




end