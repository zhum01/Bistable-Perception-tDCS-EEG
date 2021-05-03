function icaRemovedData = BST_tDCS_preProcessing_rejectICA_default_EEG(subjNum, tDCSsessionNum, blockNum, vars)
%% Reject ICA components and output the rejected data struct

%%

BST_tDCS_setAllDirectories;
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums

icaDataDir = [vars.BST_tDCS_preProcessedDataDir 'default_EEG/sub' subjNumStr '/'];
icaDataFName = ['Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_' vars.blockNumStr '_componentData_default_EEG.mat'];

load([icaDataDir icaDataFName]); % get icaComponentStruct from the saved preprocessed files

cfg = [];

if strcmp(vars.taskOrECR, 'task') 
    allSubjsICA = BST_tDCS_ICAstandard_compsToReject_separateBlocks;
    cfg.component = allSubjsICA(subjNum).tDCSsessionNum(tDCSsessionNum).blockNum(blockNum).componentsToReject; % components to reject
elseif strcmp(vars.taskOrECR, 'ECR')
    allSubjsICA = BST_tDCS_ICAstandard_compsToReject_ECR;
    cfg.component = allSubjsICA(subjNum).tDCSsessionNum(tDCSsessionNum).componentsToReject; 
end

icaRemovedData = ft_rejectcomponent(cfg, icaComponentStruct);
    



end
