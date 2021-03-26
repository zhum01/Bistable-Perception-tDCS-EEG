function BST_tDCS_segmentTrials_V1_ambiguous(subjNum, tDCSsessionNum, eegData, preProcessingSettingsName, postProcessingSettingsName, prunedBehavData, vars)
%%

%%
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums
ambigButtonTrialsData = struct;


allBlocksData = prunedBehavData(subjNum).tDCSsessionNum(tDCSsessionNum).posttDCS.block;
buttonPressCounter = 0; % count number of button presses across all trials and all blocks

for blockNum = vars.blocksLoop
    if allBlocksData(blockNum).runType == vars.ambigBlockID
        trialDataCurBlock = allBlocksData(blockNum).trial;
        
        for trialNum = 1:length(trialDataCurBlock)
            for buttonPressNum = 1:length(trialDataCurBlock(trialNum).perceptType)
                buttonPressCounter = buttonPressCounter + 1;
                
                perceptSwitchTime = trialDataCurBlock(trialNum).perceptTimes(buttonPressNum);
                perceptPreTime = trialDataCurBlock(trialNum).perceptPre(buttonPressNum);
                perceptPostTime = trialDataCurBlock(trialNum).perceptPost(buttonPressNum);
                trialTms = perceptSwitchTime - perceptPreTime: perceptSwitchTime + perceptPostTime;
                
                ambigButtonTrialsData(buttonPressCounter).eegData = eegData.trial{blockNum}(vars.capChanNumsRemovedTP9_10,trialTms);
                ambigButtonTrialsData(buttonPressCounter).blockNum = blockNum;
                ambigButtonTrialsData(buttonPressCounter).trialNum = trialNum;
                ambigButtonTrialsData(buttonPressCounter).hand = allBlocksData(blockNum).hand;
                ambigButtonTrialsData(buttonPressCounter).imgType = trialDataCurBlock(trialNum).imgType;
                ambigButtonTrialsData(buttonPressCounter).perceptPre = trialDataCurBlock(trialNum).perceptPre(buttonPressNum);
                ambigButtonTrialsData(buttonPressCounter).perceptPost = trialDataCurBlock(trialNum).perceptPost(buttonPressNum);
                ambigButtonTrialsData(buttonPressCounter).perceptTimes = trialDataCurBlock(trialNum).perceptTimes(buttonPressNum);
                ambigButtonTrialsData(buttonPressCounter).chanNames = eegData.label(vars.capChanNumsRemovedTP9_10);
                
                if buttonPressNum > 1
                    ambigButtonTrialsData(buttonPressCounter).perceptTypePre = trialDataCurBlock(trialNum).perceptType(buttonPressNum-1);
                else
                    ambigButtonTrialsData(buttonPressCounter).perceptTypePre = nan;
                end
                ambigButtonTrialsData(buttonPressCounter).perceptTypePost = trialDataCurBlock(trialNum).perceptType(buttonPressNum);
            end
        end
    end
end


saveDir = [vars.saveDirTrialData 'ambig/' vars.freqBandStr];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
saveFName = ['subject' subjNumStr '_session' num2str(tDCSsessionNum) '_post-tDCS_ambigTrials.mat'];

save([saveDir saveFName],'ambigButtonTrialsData', '-v7.3');



end

