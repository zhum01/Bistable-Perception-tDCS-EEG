%% set parameters

clearvars -except rawBehavData prunedBehavData;clc
BST_tDCS_setVars
BST_tDCS_setAllDirectories;

vars.taskOrECR = 'task'; % 'task' 'ECR'
preProcessingSettingsName = 'default_EEG';
vars.ICAsaveDir = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/'];
vars.initBlocksLoop = [1:6]; % data for these blocks will be preprocessed
vars = BST_tDCS_set_blockVars(1, vars); % set some variables used for naming files

%% Make and save presentations

blocksLoopBase = vars.initBlocksLoop;

tic

for subjNum = 2:24%vars.validSubjs
    
    for tDCSsessionNum = 1:length(vars.tDCSsessions{subjNum})
        
        for blockNum = blocksLoopBase
            vars.blocksLoop = blockNum;
            vars = BST_tDCS_set_blockVars(1, vars);
            
            BST_tDCS_make_ICA_goodBadComps_presentation(subjNum, tDCSsessionNum, preProcessingSettingsName, vars)
            
            disp(['Completed Subj ' num2str(subjNum) ' Session ' num2str(tDCSsessionNum) ' ' vars.blockNumStr])

        end
    end
end


runtime = toc
