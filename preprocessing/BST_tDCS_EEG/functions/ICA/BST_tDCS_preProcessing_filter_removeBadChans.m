function [finalPreprocessedEegStruct] = BST_tDCS_preProcessing_filter_removeBadChans(preProcessingSettingsName, subjNum, tDCSsessionNum, blockNum, vars)
%Function will preprocess data using settings defined in preProcessingSettings
%subjNum should be integer between 1 and 20 (number of subejcts
%recorded)
%PreProcessing settings contain the demean, detrend and filter settings used in ft_preprocessing


%% Parameters

preProcessingFunction = str2func(['BST_tDCS_preProcessingSettings_' preProcessingSettingsName]);
preProcessingSettings = preProcessingFunction(preProcessingSettingsName);

%% Find EEG raw data files for the recordings from a single subject
BST_tDCS_setAllDirectories;
rawDataSubjFolders = BST_tDCS_getRawDataSubjFolders;
subjEegDataDir = rawDataSubjFolders{subjNum}{tDCSsessionNum}{1};
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums

%% Loop through blocks and get correct file name for each block

% get the file name corresponding to current block
[rawDataFName, triggerFName, eegFileSaveType] = BST_tDCS_get_eegFileName_combOrSepBlocks(subjEegDataDir, blockNum, vars);

%% Load EEG data and do all preprocessing
if ~(strcmp(eegFileSaveType, 'combinedBlocks') && any(blockNum == vars.preprocBlocksLoop(2:end)))...
        || (subjNum == 18 && tDCSsessionNum == 2)
    % don't load the same data file multiple times when more the one block was saved in the same file
    % only exception is sub18_sess2, whose data for blocks 2-6 were saved in a separate file
    
    % Load EEG data
    cd(subjEegDataDir)
    cfg = [];
    cfg.continuous  = 'yes';
    cfg.dataset = [subjEegDataDir rawDataFName];
    cfg.channel = {'all', '-EMG_1', '-EMG_2'};
    eegStruct = ft_preprocessing(cfg);
end

% Remove non-task periods from beinning and end of recording
eegStructTrimmed = BST_tDCS_removeNontaskEEGData(subjNum, blockNum, eegStruct, triggerFName, vars);

% Run filters and other preprocessing steps
eegStructFiltered = ft_preprocessing(preProcessingSettings, eegStructTrimmed);

% load bad channels
badChannelsLoadDir = '/isilon/LFMI/VMdrive/Mike/bistable/BST_tDCS/data_files/processed_data/EEG_preProcessed/RichardBadChannels/task/Stats/';%[vars.BST_tDCS_preProcessedDataDir 'RichardBadChannels/task/Stats/'];
badChannelsFName = [subjNumStr '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_Stats.mat'];
load([badChannelsLoadDir badChannelsFName])
badChansStrs = vars.capChanNamesAll64(stats.badChannels);

% load neighboring channels that will be used to interpolate bad channels
neighbsStructDir = [vars.BST_tDCS_baseDir 'generalScripts/mat_files/'];
neighbsLoadFName = 'eeg1010_neighb_ADJUSTED.mat';
load([neighbsStructDir neighbsLoadFName])

% interpolate bad channels
[~,manualBadChansExcel,~] = xlsread([vars.BST_tDCS_baseDir 'preProcessing/BST_tDCS_EEG/manualBadChans_task.xls']);
manualBadChansExcel(1,:) = []; % remove headers
% adjust badChans using manually-checked spreadsheet
finalBadChansStrs = BST_tDCS_get_manualBadChans(subjNum, tDCSsessionNum, blockNum, badChansStrs, manualBadChansExcel, vars);

cfg.badchannel     = finalBadChansStrs;
cfg.neighbours     = neighbsAllChans;
cfg.elec = ft_read_sens([vars.BST_tDCS_baseDir 'generalScripts/ft_easycap-M1_ADJUSTED.txt']);
cfg.method = 'average';
finalPreprocessedEegStruct = ft_channelrepair(cfg, eegStructFiltered);


end





