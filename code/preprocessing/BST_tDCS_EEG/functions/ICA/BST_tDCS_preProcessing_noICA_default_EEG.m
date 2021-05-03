function outputData = BST_tDCS_preProcessing_noICA_default_EEG(subjNum, tDCSsessionNum, vars)
%% This function loads the preprocessed EEG data and DOES NOT reject ICA comps

%%

BST_tDCS_setAllDirectories;
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums

loadDataDir = [vars.BST_tDCS_preProcessedDataDir 'default_EEG/sub' subjNumStr '/'];
loadDataFName = ['Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_' vars.blockNumStr '_noICA_default_EEG.mat'];

load([loadDataDir loadDataFName]);

cfg = [];

outputData = combinedPreProcessedEegStruct;
    



end
