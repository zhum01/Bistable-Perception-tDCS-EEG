function BST_tDCS_save_ECRdata_mat(subjNum, tDCSsessionNum, eegData, preProcessingSettingsName, postProcessingSettingsName, prunedBehavData, vars)
%%

%%
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums

ECRdata = struct;

ECRdata.eegData = eegData.trial{1}(vars.capChanNumsRemovedTP9_10,trialTms);
ECRdata.chanNames = eegData.label(vars.capChanNumsRemovedTP9_10);

saveDir = [vars.saveDirTrialData 'ECR/' vars.freqBandStr];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
saveFName = ['subject' subjNumStr '_session' num2str(tDCSsessionNum) '_ECR.mat'];

save([saveDir saveFName], 'ECRdata', '-v7.3');



end

