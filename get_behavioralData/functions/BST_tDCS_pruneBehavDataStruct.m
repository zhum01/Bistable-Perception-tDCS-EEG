function prunedBehavData = BST_tDCS_pruneBehavDataStruct(rawBehavData, vars)
%% This function removes consecutive button presses of the same type from rawBehavData 


%%
prunedBehavData = rawBehavData;

for subjNum = vars.validSubjs
    for tDCSsessionNum = 1:length(vars.tDCSsessions{subjNum})
        for taskTypeNum = 1:length(vars.taskTypes)
     % set variables that will be used as field names
            vars.tDCSsessionNum = tDCSsessionNum;
            vars.taskTypeCur = vars.taskTypes{taskTypeNum};
            vars.taskTypeFieldStr = vars.taskTypeCur;
            vars.taskTypeFieldStr(vars.taskTypeFieldStr == '-') = []; % get rid of hyphen for using as field name
            
     % remove button series and trigger series to save storage space
            prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block = ...
                arrayfun(@(x) rmfield(x, 'triggerSeries'), prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block);
            prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block = ...
                arrayfun(@(x) rmfield(x, 'buttonSeries'), prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block);

            
            for blockNum = vars.allBlocksLoop
                numTrials = length(rawBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial);
                
                for trialNum = 1:numTrials
                    trial = rawBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum);
                    numPresses = length(trial.perceptTimes);
                    
                    if numPresses > 1
                        for pressNum = 2:numPresses
                            if trial.perceptType(pressNum-1) == trial.perceptType(pressNum)
                                trial.perceptTimes(pressNum) = nan;
                            end
                        end
                        validPress = ~isnan(trial.perceptTimes);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).buttonTimes     =   trial.buttonTimes(validPress);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).buttonTypes     =   trial.buttonTypes(validPress);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).perceptTimes    =   trial.perceptTimes(validPress);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).perceptType     =   trial.perceptType(validPress);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).buttonPre       =   trial.buttonPre(validPress);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).perceptPre      =   trial.perceptPre(validPress);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).buttonPost      =   trial.buttonPost(validPress);
                        prunedBehavData(subjNum).tDCSsessionNum(vars.tDCSsessionNum).(vars.taskTypeFieldStr).block(blockNum).trial(trialNum).perceptPost     =   trial.perceptPost(validPress);
                    end
                end
            end
        end
    end
end




end







