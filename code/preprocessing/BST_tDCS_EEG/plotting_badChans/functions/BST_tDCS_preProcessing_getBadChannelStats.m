function BST_tDCS_preProcessing_getBadChannelStats(subjNum, tDCSsessionNum, vars)
%Function will preprocess data using settings defined in preProcessingSettings

%% Find EEG raw data files for the recordings from this subject
BST_tDCS_setAllDirectories;
rawDataSubjFolders = BST_tDCS_getRawDataSubjFolders;
subjEegDataDir = rawDataSubjFolders{subjNum}{tDCSsessionNum}{1};
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums

%% preprocess each block of data using ft_preprocessing

preProcessedEEGStructCell = cell(numel(vars.blocksLoop),1);

for blockNum = vars.blocksLoop
    if exist([vars.saveDir '/Stats/' subjNumStr '_Session' num2str(tDCSsessionNum) '_Block' num2str(blockNum) '_Stats.mat'],'file');
        
        [rawDataFName, triggerFName, vars] = BST_tDCS_get_eegFileName_combOrSepBlocks(subjEegDataDir, blockNum, vars);
            
        if ~(strcmp(vars.eegFileSaveType, 'combinedBlocks') && any(blockNum == vars.blocksLoop(2:end)))...
                || (subjNum == 18 && tDCSsessionNum == 2)
            % don't load the same data file multiple times when more the one block was saved in the same file
            % only exception is sub18_sess2, whose data for blocks 2-6 were saved in a separate file
            % Load EEG data
            cfg = [];
            cfg.continuous  = 'yes';
            cfg.dataset = [subjEegDataDir rawDataFName];
            eegStruct = ft_preprocessing(cfg);
       end
        
        % Remove non-task periods from beinning and end of recording
        if strcmp(vars.taskOrECR, 'task')
            currBlockEegData = BST_tDCS_removeNontaskEEGData(subjNum, blockNum, eegStruct, triggerFName, vars);
        elseif strcmp(vars.taskOrECR, 'ECR')
            currBlockEegData = eegStruct;
        end
        
        
        BST_tDCS_preProcessing_doGetBadChannelStats(subjNumStr, tDCSsessionNum,blockNum,currBlockEegData, vars);
        
        disp(['Completed Subj ' subjNumStr ' Session ' num2str(tDCSsessionNum) ' ' num2str(blockNum)])
    end
end


end



