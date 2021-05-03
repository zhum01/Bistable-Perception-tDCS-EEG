function [] = BST_tDCS_segmentTrials_V1_discontinuous(subjNum, tDCSsessionNum, eegData, preProcessingSettingsName, postProcessingSettingsName, prunedBehavData, vars)
%%

%%
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums
discontBlankTrialsData = struct;


allBlocksData = prunedBehavData(subjNum).tDCSsessionNum(tDCSsessionNum).posttDCS.block;
discontTrialCounter = 0; % count number of imgPres across all trials and all blocks

for blockNum = vars.blocksLoop
    if allBlocksData(blockNum).runType == vars.discontBlockID
        trialDataCurBlock = allBlocksData(blockNum).trial;
        
        for trialNum = 1:vars.discontNumTrials
            numImgPresCurTrial = allBlocksData(blockNum).numImgPresPerTrial(trialNum);
            for imgPresNum = 1:numImgPresCurTrial - 1
                discontTrialCounter = discontTrialCounter + 1;
                % this counter is used to index the discont trials that will be stored
                imgPresNumAcrossTrials = imgPresNum + sum(allBlocksData(blockNum).numImgPresPerTrial(1:trialNum - 1));
                % this counter is used to index data from the behavData struct
                    % takes into account that the last imgPres of every trial is skipped because there is no following
                    % imgPres (which is necessary for defining a trial in this script)
                discontBlankTrialsData(discontTrialCounter).blankDur = trialDataCurBlock(imgPresNumAcrossTrials).blankDur;
                discontTrialImgDur = trialDataCurBlock(imgPresNumAcrossTrials).imgOffTimes - trialDataCurBlock(imgPresNumAcrossTrials).imgOnTimes;
                discontTrialEndTime = trialDataCurBlock(imgPresNumAcrossTrials).imgOnTimes + discontTrialImgDur ...
                    + discontBlankTrialsData(discontTrialCounter).blankDur + discontTrialImgDur - 1;
                trialTms = trialDataCurBlock(imgPresNumAcrossTrials).imgOnTimes:discontTrialEndTime;
                
                discontBlankTrialsData(discontTrialCounter).eegData                       = eegData.trial{blockNum}(vars.capChanNumsRemovedTP9_10,trialTms);
                discontBlankTrialsData(discontTrialCounter).blockNum                      = blockNum;
                discontBlankTrialsData(discontTrialCounter).trialNum                      = trialNum;
                discontBlankTrialsData(discontTrialCounter).imgPresNumAcrossTrials        = discontTrialCounter;
                discontBlankTrialsData(discontTrialCounter).hand                          = allBlocksData(blockNum).hand;
                discontBlankTrialsData(discontTrialCounter).imgType                       = trialDataCurBlock(imgPresNumAcrossTrials).imgType;
                discontBlankTrialsData(discontTrialCounter).perceptTimes                  = trialDataCurBlock(imgPresNumAcrossTrials).perceptTimes - trialDataCurBlock(imgPresNumAcrossTrials).imgOnTimes;
                discontBlankTrialsData(discontTrialCounter).perceptType                   = trialDataCurBlock(imgPresNumAcrossTrials).perceptType;
                discontBlankTrialsData(discontTrialCounter).chanNames                     = eegData.label(vars.capChanNumsRemovedTP9_10);
                
                discontBlankTrialsData(discontTrialCounter).imgOnTimes                    = 1;
                discontBlankTrialsData(discontTrialCounter).imgOffTimes                   = trialDataCurBlock(imgPresNumAcrossTrials).imgOffTimes - trialDataCurBlock(imgPresNumAcrossTrials).imgOnTimes;
                discontBlankTrialsData(discontTrialCounter).blankOnTimes                  = trialDataCurBlock(imgPresNumAcrossTrials).blankOnTimes - trialDataCurBlock(imgPresNumAcrossTrials).imgOnTimes;
                discontBlankTrialsData(discontTrialCounter).blankOffTimes                 = trialDataCurBlock(imgPresNumAcrossTrials).blankOffTimes - trialDataCurBlock(imgPresNumAcrossTrials).imgOnTimes;
                
                if ~isempty(trialDataCurBlock(imgPresNumAcrossTrials).perceptType)
                    discontBlankTrialsData(discontTrialCounter).prePercept    = trialDataCurBlock(imgPresNumAcrossTrials).perceptType(end);
                else
                    discontBlankTrialsData(discontTrialCounter).prePercept    = nan;
                end
                if ~isempty(trialDataCurBlock(imgPresNumAcrossTrials + 1).perceptType)
                    discontBlankTrialsData(discontTrialCounter).postPercept   = trialDataCurBlock(imgPresNumAcrossTrials+1).perceptType(1);
                else
                    discontBlankTrialsData(discontTrialCounter).postPercept   = nan;
                end
            end
        end
    end
end

saveDir = [vars.saveDirTrialData 'discont/' vars.freqBandStr];
if ~exist(saveDir,'dir')
    mkdir(saveDir);
end
saveFName = ['subject' subjNumStr '_session' num2str(tDCSsessionNum) '_post-tDCS_discontTrials.mat'];

save([saveDir saveFName],'discontBlankTrialsData', '-v7.3');



end