% load behavioral data
clear;clc
BST_tDCS_setAllDirectories
loadFName = 'BST_tDCS_behavData.mat'; % name of the behavioral data file
load([vars.BST_tDCS_behaviorDir loadFName]);

%% set variables
clearvars -except rawBehavData prunedBehavData; clc % -except pbd pbdMEG
BST_tDCS_setVars

vars.taskOrECR = 'ECR';
vars.rawOrProc = 'raw';
vars.eegValidSubjs = [1:24];
vars.sessionNumsToPlot = [1:3];
vars.blocksLoop = [1:6];
vars.zoomedInYLims = [-100, 100];
vars.xLims = [0 65000];
vars.preProcessingSettingsName = 'rejectICA_default_EEG';
vars.postProcessingSettingsName = 'LP58_butter';
loadEegDataDir = [vars.BST_tDCS_EEGpostProcessedDataDir vars.preProcessingSettingsName '/' vars.postProcessingSettingsName '/'];
badChannelsLoadDir = [vars.BST_tDCS_preProcessedDataDir 'RichardBadChannels/' vars.taskOrECR '/Stats/'];
vars.badChansXlsDirF = ['/home/zhum/Downloads/manualBadChans_' vars.taskOrECR '.xls'];
vars.saveFigsDir = '/data/gogodisk1/Mike/bistable/BST_tDCS/preProcessing (copy)/BST_tDCS_EEG/plotting_badChans/figures/ECR/';
toposSaveDir = [vars.saveFigsDir 'topos/' vars.rawOrProc '/'];
tmsSaveDir = [vars.saveFigsDir 'tms/' vars.rawOrProc '/'];
tmsSaveDirZoomedIn = [vars.saveFigsDir 'tms/' vars.rawOrProc '/zoomedIn/'];
if ~exist(toposSaveDir, 'dir')
    mkdir(toposSaveDir)
end
if ~exist(tmsSaveDir, 'dir')
    mkdir(tmsSaveDir)
end
if ~exist(tmsSaveDirZoomedIn, 'dir')
    mkdir(tmsSaveDirZoomedIn)
end              


vars.eegValidSubjs = [1,2,4:24];

tic

for subjNum = vars.eegValidSubjs
    subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums
        
    for tDCSsessionNum = vars.sessionNumsToPlot
        
    % get file name for eeg data
        rawDataSubjFolders = BST_tDCS_getRawDataSubjFolders;
        subjEegDataDir = rawDataSubjFolders{subjNum}{tDCSsessionNum}{1};
        
        for blockNum = vars.blocksLoop
            % for ECR recordings, only need to run once for each session
            if strcmp(vars.taskOrECR, 'ECR') && blockNum ~= 1
                continue 
            end
            
            if strcmp(vars.rawOrProc, 'raw')
                [eegDataFName, triggerFName, vars] = BST_tDCS_get_eegFileName_combOrSepBlocks(subjEegDataDir, blockNum, vars);
            elseif strcmp(vars.rawOrProc, 'processed')
                % skip removed blocks
                if subjNum == 1 && tDCSsessionNum == 2 && blockNum == 1 ...
                || subjNum == 4 && tDCSsessionNum == 1 && (blockNum == 3 || blockNum == 4) ...
                || subjNum == 21 && tDCSsessionNum == 2 && (blockNum == 3 || blockNum == 4 || blockNum == 5)
                    continue
                end
                
                eegDataDirF = [loadEegDataDir 'Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_allBlocks_postProcessedData_' vars.postProcessingSettingsName '.mat'];
                load(eegDataDirF)
                eegStructFiltered = postProcessedEegData;
            end
            
      % Load raw EEG data and do all preprocessing
            if strcmp(vars.rawOrProc, 'raw') 
                if ~(strcmp(vars.eegFileSaveType, 'combinedBlocks') && any(blockNum == vars.blocksLoop(2:end)))...
                        || (subjNum == 18 && tDCSsessionNum == 2)
                    % don't load the same data file multiple times when more than one block was saved in the same file
                    % only exception is sub18_sess2, whose data for blocks 2-6 were saved in a separate file
                    
                % Load EEG data
                    cfg = [];
                    cfg.continuous  = 'yes';
                    cfg.dataset = [subjEegDataDir eegDataFName];
                    
                    rawEegStruct = ft_preprocessing(cfg);
                end
                
                if strcmp(vars.taskOrECR, 'task')
                    % Remove non-task periods from beinning and end of recording
                    eegStructTrimmed = BST_tDCS_removeNontaskEEGData(subjNum, blockNum, rawEegStruct, triggerFName, vars);
                else
                    eegStructTrimmed = rawEegStruct;
                end
                    % Run filters and other preprocessing steps
                    preProcCfg = BST_tDCS_preProcessingSettings_default_EEG('default_EEG');
                    preProcCfg.channel = {'all'};
                    eegStructFiltered = ft_preprocessing(preProcCfg, eegStructTrimmed);
            end
                 
      % load bad channels
                badChannelsFName = [subjNumStr '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_Stats.mat'];
                load([badChannelsLoadDir badChannelsFName])
                finalBadChansStrs = vars.capChanNamesAll64(stats.badChannels);

      % get manually-checked bad channels
                [~,manualBadChansExcel,~] = xlsread(vars.badChansXlsDirF);
                manualBadChansExcel(1,:) = []; % remove headers
                % adjust badChans using manually-checked spreadsheet
                finalBadChansStrs = BST_tDCS_get_manualBadChans(subjNum, tDCSsessionNum, blockNum, autoBadChansStrs, manualBadChansExcel, vars);
                
      % topo of good chans and bad chans
                if tDCSsessionNum == vars.sessionNumsToPlot(1) && blockNum == vars.blocksLoop(1)
                    topoFigH = figure('units', 'normalized', 'outerposition', [0 0 .9 .9], 'visible', 'off');
                end
                
                blankTopo = zeros(64, 1);
                subplotInd = length(vars.blocksLoop)*(tDCSsessionNum - 1) + blockNum;
                subplot(length(vars.sessionNumsToPlot), length(vars.blocksLoop), subplotInd)
                topoAxesH = BST_tDCS_plotFun_badChans_topo(vars.capChanNamesAll64, finalBadChansStrs, blankTopo, subjNumStr, tDCSsessionNum, blockNum, vars);
                
                if tDCSsessionNum == vars.sessionNumsToPlot(end) && blockNum == vars.blocksLoop(end)
                    print('-dpng','-r100',[vars.saveFigsDir 'topos/sub' subjNumStr '_topo']);
                    close all
                end
                
      % tms of all chans, labeled by good and bad
                if strcmp(vars.rawOrProc, 'raw') 
                    badChansStrsToLab = autoBadChansStrs;
                elseif strcmp(vars.rawOrProc, 'processed')
                    badChansStrsToLab = finalBadChansStrs;
                end
      
                tmsFigH = figure('units', 'normalized', 'outerposition', [0 0 .9 .9], 'visible','off');
                [tmsAxesH, tmsTextH] = BST_tDCS_plotFun_badChans_tms(eegStructFiltered, vars.capChanNamesAll64, badChansStrsToLab, stats, subjNumStr, tDCSsessionNum, blockNum, vars);
                
                print('-dpng','-r100',[tmsSaveDir 'sub' subjNumStr '_session' num2str(tDCSsessionNum) '_block' num2str(blockNum) '_tms']);
                
                % change lims to zoom in and save for raw data
                if strcmp(vars.rawOrProc, 'raw')
                    for chanNum = 1:length(eegStructFiltered.label)
                        set(tmsAxesH(chanNum),'ylim', vars.zoomedInYLims)
                        
                        if chanNum == 1
                            xLims = get(tmsAxesH(chanNum), 'xlim');
                            yLims = get(tmsAxesH(chanNum), 'ylim');
                            
                            set(tmsTextH, 'position', [xLims(1) - abs(xLims(2)*1.5), yLims(1)])
                        end
                    end
                    print('-dpng','-r100',[tmsSaveDirZoomedIn 'sub' subjNumStr '_session' num2str(tDCSsessionNum) '_block' num2str(blockNum) '_tms']);
                end
                
               close(tmsFigH)
                
            disp(['Completed sub' subjNumStr ' Session ' num2str(tDCSsessionNum) ' Block ' num2str(blockNum)])
            
        end
    end
end


timer = toc





