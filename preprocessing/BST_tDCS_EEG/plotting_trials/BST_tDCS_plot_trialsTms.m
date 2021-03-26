% load behavioral data
clear;clc
BST_tDCS_setAllDirectories
loadFName = 'BST_tDCS_behavData.mat'; % name of the behavioral data file
load([vars.BST_tDCS_behaviorDir loadFName]);

%% set variables
clearvars -except rawBehavData prunedBehavData; clc % -except pbd pbdMEG

BST_tDCS_setVars
BST_tDCS_setAllDirectories

vars.preProcName = 'rejectICA_default_EEG';
vars.postProcName = 'LP58_butter';
vars.trialsPrePost = [1500, 1500];
vars.trialTms = -vars.trialsPrePost(1):vars.trialsPrePost(2); % create a vector of the timecourse around the button press
vars.colorOrder = {[0 0 .9 .50], [.7 0 0 .50], [0 .7 0 .50], [.7 0 .7 .50]};
vars.invalidChanNames = {'VEOG_Inf';'VEOG_Sp';'HEOG_L';'HEOG_R'};

vars.taskOrECR = 'ECR'; % 'task' 'ECR'
vars.plotBlockType = 'ambig';
vars.eegValidSubjs = [1,2,4:24];
vars.sessionNumsToPlot = [1:3];
vars.badTrialZVarThresh = 3; % threshold for detecting bad trials (using z-scores of abs(var))
vars.subPlotsYLims = [0 30];
vars.singlePlotYLims = [-5 5];%[0 30];
vars.nSubRows = 8;
vars.nSubCols = 8;
vars.saveFigsBaseDir = ['/data/gogodisk1/Mike/bistable/BST_tDCS/preProcessing/BST_tDCS_EEG/plotting_trials/figures/' vars.plotBlockType '/'];


% plot and save
axesH = cell(length(vars.eegValidSubjs), 1);

tic

for subjNum = vars.eegValidSubjs
    subjNumInd = find(vars.eegValidSubjs == subjNum);
    subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums
    vars.subjNumStr = subjNumStr;    
    
% plot all sessions overlapping for ECR
    if strcmp(vars.taskOrECR, 'ECR')
        tmsFigsH = struct;
        tmsFigsH(1).figH = figure('units', 'normalized', 'outerposition', [0 0 .9 .9], 'visible', 'off');
    end
    
    for tDCSsessionNum = vars.sessionNumsToPlot
% load and organize the trial data into a 3d mat and do any other processing (baseline correction, low pass filtering)
     
    % load button press trial data for current session
        if strcmp(vars.taskOrECR, 'task')
            loadDir = [vars.BST_tDCS_trialDataDir vars.preProcName '/' vars.postProcName '/Ambiguous_V1/'];
            loadFName = ['subject' subjNumStr '_session' num2str(tDCSsessionNum) '_post-tDCS_ambigTrials.mat'];
        elseif strcmp(vars.taskOrECR, 'ECR')
            loadDir = [vars.BST_tDCS_trialDataDir vars.preProcName '/' vars.postProcName '/'];
            loadFName = ['subject' subjNumStr '_session' num2str(tDCSsessionNum) '_ECR.mat'];
        end
        load([loadDir loadFName])
        
        if strcmp(vars.taskOrECR, 'task')
            eegTrialData = ambigButtonTrialData;
            
            validTrialInds = find(~isnan([eegTrialData(:).perceptTypePre])...
                & [eegTrialData(:).perceptPre] > vars.trialsPrePost(1)...
                & [eegTrialData(:).perceptPost] >= vars.trialsPrePost(2));
            
            numTrials = length(validTrialInds);
            numChans = size(eegTrialData(1).eegData, 1);
        elseif strcmp(vars.taskOrECR, 'ECR')
            eegTrialData = ECRdata;
            
            validTrialInds = 1;
            numTrials = 1;
            numChans = size(eegTrialData(1).eegData, 1);
        end
        
        if strcmp(vars.taskOrECR, 'task')
            trialStarts = [eegTrialData(validTrialInds).perceptPre] - vars.trialsPrePost(1);
            trialEnds = trialStarts + sum(vars.trialsPrePost);
            windowTms = 1:sum(vars.trialsPrePost) + 1;
            allTrialsBlockNum = [eegTrialData(validTrialInds).blockNum];
            vars.blockNumsToPlot = unique(allTrialsBlockNum);
        elseif strcmp(vars.taskOrECR, 'ECR')
            trialStarts = ones(1, length(eegTrialData));
            trialEnds = repmat(vars.ECRdur, 1, length(eegTrialData));
            windowTms = 1:vars.ECRdur;
        end
        
        allTrialsEegCell = arrayfun(@(x) x.eegData(1:numChans,:), eegTrialData(validTrialInds), 'uniformoutput' ,false);
        
        allTrialsEegData = reshape(cell2mat(arrayfun(@(x,y,z) x{1}(:,y:z), allTrialsEegCell, trialStarts, trialEnds,...
            'uniformoutput', false)), numChans, length(windowTms), numTrials);
        
% detect large variance trials
    if strcmp(vars.taskOrECR, 'task')
        absMeanAcrossChansTrialData = squeeze(mean(abs(allTrialsEegData), 1));
        largeVarTrialNums = BST_tDCS_find_largeVarTrials_recursive(allTrialsEegData, absMeanAcrossChansTrialData, 1:size(allTrialsEegData, 3), vars.badTrialZVarThresh);
    end
    
        if strcmp(vars.taskOrECR, 'task')
    % plot all trials overlapping
            tmsFigsH = struct;
            tmsFigsH(1).figH = figure('units', 'normalized', 'outerposition', [0 0 .9 .9], 'visible', 'off');
            
            for trialNum = 1:numTrials
                blockNum = allTrialsBlockNum(trialNum);
                [axesH] = BST_tDCS_plotFun_trials_tms(allTrialsEegData, largeVarTrialNums, subjNum, tDCSsessionNum, blockNum, trialNum, numTrials, vars);
            end
            
    % plot trials on separate subplots
            tmsFigsH(2).figH = figure('units', 'normalized', 'outerposition', [0 0 .9 .9], 'visible', 'off');
            figCounter = 1;
            
            for trialNum = 1:numTrials
                vars.absValOrRaw = 'absVal';
                blockNum = allTrialsBlockNum(trialNum);
                subplot(vars.nSubRows, vars.nSubCols, trialNum - (figCounter - 1)*vars.nSubRows*vars.nSubCols)
                [~] = BST_tDCS_plotFun_trials_tms_trialsOnSubPlots(allTrialsEegData, largeVarTrialNums, subjNum, tDCSsessionNum, blockNum, trialNum, numTrials, vars);
                
                vars.absValOrRaw = 'raw';
                blockNum = allTrialsBlockNum(trialNum);
                subplot(vars.nSubRows, vars.nSubCols, trialNum - (figCounter - 1)*vars.nSubRows*vars.nSubCols)
                [axesHSubPlots] = BST_tDCS_plotFun_trials_tms_trialsOnSubPlots(allTrialsEegData, largeVarTrialNums, subjNum, tDCSsessionNum, blockNum, trialNum, numTrials, vars);
                
                
                if mod(trialNum, vars.nSubRows*vars.nSubCols) == 0
                    tmsFigsH(2 + figCounter).figH = figure('units', 'normalized', 'outerposition', [0 0 .9 .9], 'visible', 'off');
                    figCounter = figCounter + 1;
                end
            end
            
     % save figures
            for figNum = 1:length(tmsFigsH)
                saveas(tmsFigsH(figNum).figH, [vars.saveFigsBaseDir vars.taskOrECR '/' 'sub' subjNumStr '_session' num2str(tDCSsessionNum) '_tms' num2str(figNum) '.png']);
            end
            
            close all
            
        elseif strcmp(vars.taskOrECR, 'ECR')
            [axesH] = BST_tDCS_plotFun_trials_tms_ECR(allTrialsEegData, subjNum, tDCSsessionNum, vars);
        end
         
        disp(['Completed sub' subjNumStr ' Session ' num2str(tDCSsessionNum)])
        
    end
    
    if strcmp(vars.taskOrECR, 'ECR')
        saveas(tmsFigsH(1).figH, [vars.saveFigsBaseDir vars.taskOrECR '/' 'sub' subjNumStr '_tms.png']);
    end
    
end

timer = toc





