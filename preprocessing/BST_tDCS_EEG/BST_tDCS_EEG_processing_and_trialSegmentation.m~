%% This script does all processing steps of the EEG data from raw data to trial segmented data.
% ICA is done on each block separately in this script
% The first section does preprocessing (filtering, removing bad channels, ICA) and saves the ICAdata struct and slides of the components.
% After deciding which components will be removed, the second section removes those components and then
    % does any post processing and trial segmentation.
    
%% load behavioral data
clear;clc
BST_tDCS_setAllDirectories
loadFName = 'BST_tDCS_prunedBehavData.mat'; % name of the behavioral data file
load([vars.BST_tDCS_behaviorDir loadFName]);    
  
%% set parameters

clearvars -except rawBehavData prunedBehavData;clc
BST_tDCS_setVars
BST_tDCS_setAllDirectories;

doICA = 'yes'; % 'yes' 'no'
preProcessingSettingsName = 'default_EEG';
saveDataBaseDir = vars.BST_tDCS_preProcessedDataDir;
preprocBlocksLoop = [1:6]; % data for these blocks will be preprocessed

%% use ftpreprocessing, run ICA, and then make slides with tms, topo, and powerSpectrum of each comp

for subjNum = vars.validSubjs
    subjNumStr = add_0_before_singleDigit_subjNums(subjNum);
    
    for tDCSsessionNum = 1:length(vars.tDCSsessions{subjNum})
        runTime = [];
        
        for blockNum = preprocBlocksLoop
            tic
            
       % filtering and interploate bad channels
            processedDataStruct = BST_tDCS_preProcessing_filter_removeBadChans(preProcessingSettingsName, subjNum, tDCSsessionNum, blockNum, vars);
            
            if strcmp(doICA, 'yes')
           % run ICA
                processedDataStruct = BST_tDCS_run_ICA(processedDataStruct, preProcessingSettingsName);
                
           % plot the ICA topo, power spectrum, and time series data
                vars = BST_tDCS_make_ICA_figures(subjNum, tDCSsessionNum, blockNum, preProcessingSettingsName, vars);
                
           % make slides with figures from previous function
                BST_tDCS_make_ICA_presentation(subjNum, tDCSsessionNum, blockNum, preProcessingSettingsName, vars.numIcaComps, vars)
            end
            
       % save processed data
            if strcmp(doICA, 'yes')
                saveFName = ['Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_' blockNumStr '_componentData_' preProcessingSettings.BST_PreProcessingName '.mat'];  
            else
                saveFName = ['Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_' blockNumStr '_noICA_' preProcessingSettings.BST_PreProcessingName '.mat'];
            end
            
            saveProcessedDataDir = [saveDataBaseDir preProcessingSettingsName '/sub' subjNumStr '/'];
            if ~exist(saveProcessedDataDir,'dir')
                mkdir(saveProcessedDataDir);
            end
            save([saveProcessedDataDir saveFName] , 'processedDataStruct', 'cfg', 'preProcessingSettings','-v7.3');
            
            
            disp(['Completed Subj ' num2str(subjNum) ' Session ' num2str(tDCSsessionNum) ' block' num2str(blockNum)])
            runTime(blockNum) = toc/60

        end
    end
end


%% reject ICA comps, postProcessing (eg. filtering), and trial segmentation

clearvars -except rawBehavData prunedBehavData;clc
BST_tDCS_setVars
BST_tDCS_setAllDirectories

vars.doICA = 'yes'; % 'yes' 'no'
vars.postprocBlocksLoop = [1:6]; % data for these blocks will be processed
% vars = BST_tDCS_set_blockVars(1, vars); % set some variables used for naming files
vars.preProcessingSettingsName = 'rejectICA_default_EEG';
vars.postProcessingSettingsName = 'hilbert_ampEnv'; % 'LP35_butter' 'LP58_butter' 'BPfilter_butter' 'hilbert_ampEnv'
if strcmp(vars.postProcessingSettingsName, 'BPfilter_butter') || strcmp(vars.postProcessingSettingsName, 'hilbert_ampEnv')
    freqBandsLoop = {[1 4], [4 8], [8 13], [13 30], [30 55]};
	freqBandsStrsLoop = {'hilbert_1-4_Hz/', 'hilbert_4-8_Hz/', 'hilbert_8-13_Hz/', 'hilbert_13-30_Hz/', 'hilbert_30-55_Hz/'}; % 'hilbert_8-13_Hz/' 'BP_0.5-45_Hz/'
else
    freqBandsLoop = {[]};
    freqBandsStrsLoop = {''};
end
vars.saveDirPostProcBlockData = [vars.BST_tDCS_EEGpostProcessedDataDir vars.preProcessingSettingsName '/' vars.postProcessingSettingsName '/'];
vars.saveDirTrialData = [vars.BST_tDCS_trialDataDir vars.preProcessingSettingsName '/' vars.postProcessingSettingsName '/'];


if ~exist('prunedBehavData', 'var') % load behavioral data if not already loaded
    load([vars.BST_tDCS_behaviorDir 'BST_tDCS_behavData.mat'])
end

eegPreProcessingFunction = str2func(['BST_tDCS_preProcessing_' vars.preProcessingSettingsName]);
eegPostProcessingFunction = str2func(['BST_tDCS_postProcessing_' vars.postProcessingSettingsName]);

for freqBandNum = 1:length(freqBandsLoop)
    vars.bpFreqs = freqBandsLoop{freqBandNum};
    vars.freqBandStr = freqBandsStrsLoop{freqBandNum};
    filterTypeTimer = tic;
    
    for subjNum = vars.validSubjs
        subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums
        
        for tDCSsessionNum = 1:length(vars.tDCSsessions{subjNum})
            sessionsTimer = tic;
            postProcessedCell = cell(1, length(vars.postprocBlocksLoop));
            
            saveDirPostProcBlockData = [vars.saveDirPostProcBlockData vars.freqBandStr];
            saveFName = ['Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_allBlocks_postProcessedData_' vars.postProcessingSettingsName '.mat'];
            if ~exist(saveDirPostProcBlockData, 'dir')
                makeDirFun(saveDirPostProcBlockData)
            end
            
            % load postProcessed data if it was saved already
            if exist([saveDirPostProcBlockData, saveFName], 'file')
                clear postProcessedEegData
                load([saveDirPostProcBlockData, saveFName]);
                
                % if data not already saved, for each block, remove noisy ICA components and do postProcessing
            else
                for blockNum = vars.postprocBlocksLoop
                    % skip processing for very noisy blocks
                    if subjNum == 1 && tDCSsessionNum == 2 && blockNum == 1 ...
                        || subjNum == 4 && tDCSsessionNum == 1 && (blockNum == 3 || blockNum == 4) ...
                        || subjNum == 21 && tDCSsessionNum == 2 && (blockNum == 3 || blockNum == 4 || blockNum == 5))
                        
                        postProcessedCell{blockNum}.time = {nan}; postProcessedCell{blockNum}.trial = {nan}; postProcessedCell{blockNum}.sampleinfo = [nan, nan];
                        continue
                    end
                    
                    blocksTimer = tic;
                    vars.blockNumStr = ['block' num2str(blockNum)];
                    
                    % remove ICA components and do any postProcessing (eg. filtering and common average rereference)
                    postProcessedCell{blockNum} = BST_tDCS_rejectICA_and_postProcessing(subjNum, tDCSsessionNum, blockNum, eegPreProcessingFunction, eegPostProcessingFunction, vars);
                    
                    % at last block, combine processed data for each block into a single struct and then save
                    if blockNum == vars.postprocBlocksLoop(end)
                        postProcessedEegData = BST_tDCS_combineEegStructs(postProcessedCell, vars);
                        save([saveDirPostProcBlockData, saveFName] , 'postProcessedEegData', '-v7.3');
                    end
                    
                    disp(['Completed Saving Subj ' subjNumStr ' Session ' num2str(tDCSsessionNum) ' ' vars.blockNumStr])
                    [num2str(toc(blocksTimer)/60) ' min']
                end
            end
            
            % do trial segmentation
            vars.blocksLoop = vars.postprocBlocksLoop;
            accountForType = 'adjustBlockInds';
            BST_tDCS_accountFor_falseTriggers_and_otherErrors % fix indexing errors
            
            if strcmp(vars.taskOrECR, 'task')
                % segment Ambiguous blocks
                % Each trial contains percept duration BEFORE AND AFTER each button press
                BST_tDCS_segmentTrials_V1_ambiguous(subjNum, tDCSsessionNum, postProcessedEegData, vars.preProcessingSettingsName, vars.postProcessingSettingsName, prunedBehavData, vars);
                
                % segment Discontinuous blocks
                % Each trial contains a blank period surrounded by an image onset on either side
                BST_tDCS_segmentTrials_V1_discontinuous(subjNum, tDCSsessionNum, postProcessedEegData, vars.preProcessingSettingsName, vars.postProcessingSettingsName, prunedBehavData, vars);
                
            elseif strcmp(vars.taskOrECR, 'ECR')
                % save the eyes-closed rest data in a struct
                BST_tDCS_save_ECRdata_mat(subjNum, tDCSsessionNum, postProcessedEegData, vars.preProcessingSettingsName, vars.postProcessingSettingsName, prunedBehavData, vars)
            end
            
            disp(['sub' subjNumStr 'sess' num2str(tDCSsessionNum) ': ' num2str(toc(sessionsTimer)/60) 'min'])
            
        end
    end
    
    disp(['Completed ' vars.freqBandStr ': ' num2str(toc(filterTypeTimer)/60) 'min'])
    
end


figure('units', 'normalized', 'outerposition', [0 0 .9 .9])



