%% Account for all errors (eg. false triggers) of all subjs and sessions

if strcmp(accountForType, 'falseTriggers')
    if strcmpMov('sub08/tDCS_sessions/session3/post-tDCS', eegDataDir)
        % false trigger sent for 5th block (eprime crashed)
        allBlocksEndInds(6) = allBlocksEndInds(5); % the last blockEnd trigger is actually the 5th blockEnd trigger in the EEG file because the real 5th blockEnd trigger was never sent
        allBlocksEndInds(5) = nan; % nan 5th blockEnd trigger because it was never sent
        allBlocksStartInds(5) = nan; % nan 5th blockStart trigger because the block was redone
        
    elseif strcmpMov('sub02/tDCS_sessions/session3/post-tDCS', eegDataDir)
        % false trigger sent for 3rd block (restarted block due to large number of movement artifacts in the beginning of the block)
        allBlocksStartInds(3) = []; % nan 3rd blockStart trigger because the block was redone
        
    elseif strcmpMov('sub14/tDCS_sessions/session1/pre-tDCS', eegDataDir)...
            || strcmpMov('sub15/tDCS_sessions/session3/pre-tDCS', eegDataDir)
        % the first block for pre-tDCS task was never saved in an EEG file for these sessions
            % the trigger times shouldn't matter since eeg data is not used for pre-tDCS task, so use the same trigger data as in ambiguous block 4
        allBlocksStartInds = [allBlocksStartInds(3) allBlocksStartInds];
        allBlocksEndInds = [allBlocksEndInds(3) allBlocksEndInds];
        
    elseif strcmpMov('sub17/tDCS_sessions/session3/pre-tDCS', eegDataDir)
        % the beginning of the first block for pre-tDCS task was never saved in an EEG file
        % also restarted the 2nd block
        allBlocksStartInds(1) = [];
        allBlocksStartInds = [3 allBlocksStartInds];
        
    elseif strcmpMov('sub13/tDCS_sessions/session2/pre-tDCS', eegDataDir)
        % false trigger was sent for the 4th block
        allBlocksStartInds(4) = [];
        
    elseif strcmpMov('sub18/tDCS_sessions/session2/post-tDCS', eegDataDir) && length(allBlocksStartInds) > 1
        % 1st trigger not sent (subject went to bathroom after 1st block, so blocks 2-6 were saved in a separate eeg file)
        allBlocksStartInds = [nan allBlocksStartInds];
        allBlocksEndInds = [nan allBlocksEndInds];
        
    elseif strcmpMov('sub21/tDCS_sessions/session1/pre-tDCS', eegDataDir)
        % false trigger for 2nd block
        allBlocksStartInds(2) = [];
        
    elseif strcmpMov('sub22/tDCS_sessions/session2/post-tDCS', eegDataDir)
        % redid 2nd block
        allBlocksStartInds(2) = [];
        allBlocksEndInds(2) = [];
    end
    
%% adding a block start trigger for files that are missing them
elseif strcmp(accountForType, 'blockStartTrigger')
    
    if strcmpMov('sub17/tDCS_sessions/session3/pre-tDCS', eegDataDir) && blockNum == 1
        % started the pre-tDCS recording file after block 1 started, so need to add the trigger for ambigBlockStart
        triggerValues = cat(1, vars.trigAmbigBlockStart, triggerValues);
        ambigFixationDur = 2;
        triggerTimes = cat(1, triggerTimes(1) - ambigFixationDur*vars.eegFs, triggerTimes); % the 1st trigger after the file started saving is for the 1st imgOnset. so add the time of the blockStart by subtracting the fixation screen duration from the imgOnset time
    end

%% errors with saving eeg blocks in separate files or all in the same file
elseif strcmp(accountForType, 'savingMultipleFiles')
    % sub18_session2_post-tDCS went to bathroom after 1st block so data for blocks 2-6 were saved in a separate file
    if strcmpMov('sub18/tDCS_sessions/session2/post-tDCS', eegDataDir)
        recordingListFNamesOutput = [{'sub18pos_allBlocks.vhdr'}, repmat({'sub18pos_allBlocks_02-06.vhdr'},1,5)];
    end

%% After rejecting ICA components - for some sessions, remove blocks with data too noisy to analyze    
elseif strcmp(accountForType, 'adjustBlockInds')      
    if subjNum == 1 && tDCSsessionNum == 2
        vars.blocksLoop = [2:6];
    end
    if subjNum == 4 && tDCSsessionNum == 1 
        vars.blocksLoop = [1:2,5:6];
    end
    
    if subjNum == 21 && tDCSsessionNum == 2 
        vars.blocksLoop = [1:2,6];
    end
end



