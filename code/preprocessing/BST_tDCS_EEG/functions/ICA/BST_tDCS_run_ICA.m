function [icaComponentStruct] = BST_tDCS_run_ICA(finalPreprocessedEegStruct, preProcessingSettingsName)
%%

%% Do ICA (optional)

preProcessingFunction = str2func(['BST_tDCS_preProcessingSettings_' preProcessingSettingsName]);
preProcessingSettings = preProcessingFunction(preProcessingSettingsName);

cfg = preProcessingSettings.BST_ICA.cfg;
eegDataRank = rank(finalPreprocessedEegStruct.trial{1});
cfg.numcomponent = eegDataRank; %%%%%%% to prevent getting complex numbers

icaComponentStruct = ft_componentanalysis(cfg, finalPreprocessedEegStruct);


end




