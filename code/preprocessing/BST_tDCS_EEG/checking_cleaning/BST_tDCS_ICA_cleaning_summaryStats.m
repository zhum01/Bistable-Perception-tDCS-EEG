%%
clearvars -except rawBehavData prunedBehavData;clc
BST_tDCS_setVars
BST_tDCS_setAllDirectories;


vars.taskOrECR = 'task';
vars.blocksLoop = [1:6]; % data for these blocks will be preprocessed
    if strcmp(vars.taskOrECR, 'ECR')
        vars.initBlocksLoop = 1;
    end
vars.badChansXlsDirF = ['/home/zhum/Downloads/manualBadChans_' vars.taskOrECR '.xls'];
    
badChansStats = struct;
ICAcompsStats = struct;
% numBadChansPerBlock = cell(length(vars.eegValidSubjs)*length(vars.sessionNumsToPlot)*length(vars.blocksLoop), 2);
% badChanStats.perBlock = cell(length(vars.eegValidSubjs)*length(vars.sessionNumsToPlot)*length(vars.blocksLoop), 2);
% badChanStats.meanAcrossBlocks = cell(length(vars.eegValidSubjs)*length(vars.sessionNumsToPlot), 2);
allBlocksCounter = 1;
allSessCounter = 1;


tic

vars.eegValidSubjs = [1:24];

for subjNum = vars.eegValidSubjs
    subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums
        
    for tDCSsessionNum = 1:length(vars.tDCSsessions{subjNum})
        
        for blockNum = vars.blocksLoop
                 
% removed channels
      % load bad channels
                badChannelsLoadDir = [vars.BST_tDCS_preProcessedDataDir 'RichardBadChannels/' vars.taskOrECR '/Stats/'];
                badChannelsFName = [subjNumStr '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_Stats.mat'];
                load([badChannelsLoadDir badChannelsFName])
                badChansStrs = vars.capChanNamesAll64(stats.badChannels);

      % get manually-checked bad channels
                [~,manualBadChansExcel,~] = xlsread(vars.badChansXlsDirF);
                manualBadChansExcel(1,:) = []; % remove headers
                % adjust badChans using manually-checked spreadsheet
                finalBadChansStrs = BST_tDCS_get_manualBadChans(subjNum, tDCSsessionNum, blockNum, badChansStrs, manualBadChansExcel, vars);
               
                badChansStats.perBlock{allBlocksCounter, 1} = length(finalBadChansStrs);
                
% removed ICA components
                
                if strcmp(vars.taskOrECR, 'task')
                    allSubjsRemovedComps = BST_tDCS_ICAstandard_compsToReject_separateBlocks;
                    ICAcompsStats.removedPerBlock{allBlocksCounter, 1} = length(allSubjsRemovedComps(subjNum).tDCSsessionNum(tDCSsessionNum).blockNum(blockNum).componentsToReject);
                elseif strcmp(vars.taskOrECR, 'ECR')
                    allSubjsRemovedComps = BST_tDCS_ICAstandard_compsToReject_ECR;
                    ICAcompsStats.removedPerBlock{allBlocksCounter, 1} = length(allSubjsRemovedComps(subjNum).tDCSsessionNum(tDCSsessionNum).componentsToReject);
                end
                
                allBlocksCounter = allBlocksCounter + 1;
     
        end
        
        allSessCounter = allSessCounter + 1;
        
        badChansStats.meanAcrossBlocks{allSessCounter, 1} = ['sub' subjNumStr '_sess' num2str(tDCSsessionNum)];
        badChansStats.meanAcrossBlocks{allSessCounter, 2} = mean([badChansStats.perBlock{allBlocksCounter - length(vars.blocksLoop):allBlocksCounter - 1}]);
        badChansStats.perBlock{allBlocksCounter - length(vars.blocksLoop), 3} = 'START';
        badChansStats.perBlock{allBlocksCounter - 1,3} = 'END';
        
    end
end

runTime = toc;

%     save([vars.saveMatDir 'numBadChansPerBlock'], 'numBadChansPerBlock')





