clear;clc
BST_tDCS_setAllDirectories
loadFName = 'BST_tDCS_behavData.mat'; % name of the behavioral data file
load([vars.BST_tDCS_behaviorDir loadFName]);


%% set parameters

clearvars -except rawBehavData prunedBehavData;clc
BST_tDCS_setVars
BST_tDCS_setAllDirectories;

vars.taskOrECR = 'ECR'; % 'task' 'ECR'
vars.doICA = 'yes'; % 'yes' 'no'
preProcessingSettingsName = 'default_EEG';
vars.ICAsaveDir = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/'];
vars.blocksLoop = [1:6]; % data for these blocks will be preprocessed
if strcmp(vars.taskOrECR, 'ECR') % only 1 eyes-closed recording per session
    vars.blocksLoop = 1;
end
vars.icaBlocks = 'combBlocks'; % 'sepBlocks' 'combBlocks'
vars = BST_tDCS_set_blockVars(1, vars); % set some variables used for naming files
vars.saveDir = [vars.BST_tDCS_preProcessedDataDir '/RichardBadChannels/ECR/'];

%% detect bad channels

tic

for subjNum = [1:2,4:24]
    for tDCSsessionInd = 1:length(vars.tDCSsessions{subjNum})
        tDCSsessionNum = str2double(vars.tDCSsessions{subjNum}{tDCSsessionInd}(end));
        
        BST_tDCS_preProcessing_getBadChannelStats(subjNum, tDCSsessionNum, vars);
    end
end

runTime = toc






