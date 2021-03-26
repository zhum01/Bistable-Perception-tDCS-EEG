function [postProcessedEegData] = BST_tDCS_postProcessing_LP35_butter(preProcessedEegData, subjNum, vars)

cfg = [];
cfg.lpfilter = 'yes';
cfg.lpfreq = 35;
cfg.lpfiltord  = 3;
cfg.lpfilttype = 'but';

postProcessedEegData  = ft_preprocessing(cfg, preProcessedEegData);




end