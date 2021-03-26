function postProcessedEegData = BST_tDCS_rejectICA_and_postProcessing(subjNum, tDCSsessionNum, blockNum, eegPreProcessingFunction, eegPostProcessingFunction, vars)
%% Remove ICA components, postprocess the data after removing, and then save the postprocessed struct


%%

% remove ICA components
preProcessedEegData = eegPreProcessingFunction(subjNum, tDCSsessionNum, blockNum, vars);

% common average rereference
cfg = [];
cfg.continuous  = 'yes';
cfg.reref = 'yes';
cfg.refchannel = {'all', '-VEOG_Inf', '-VEOG_Sp', '-HEOG_L', '-HEOG_R'};
avgRerefEegData = ft_preprocessing(cfg, preProcessedEegData);    

% additional processing (eg. filters)
postProcessedEegData = eegPostProcessingFunction(avgRerefEegData, subjNum, vars);


end






