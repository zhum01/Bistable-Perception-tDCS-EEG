%% This script imports and parses behavioral data from 3 files:
% 1. eprime files (stored in .xls sheets)
% 2. button response data (stored in text files)
% 3. trigger information (stored in EEG data files)
% Then save 2 .mats: (1) rawBehavData.mat which contains the raw behavioral data after being parsed
%                    (2) prunedBehavData.mat which contains the same data but with multiple button presses removed 

clear; clc

tic

BST_tDCS_setVars
BST_tDCS_setAllDirectories;

% import eprime and button press data and then extract into behavData struct
rawBehavData = struct;

for subjNum = vars.validSubjs
    for tDCSsessionNum = 1:length(vars.tDCSsessions{subjNum})
        for taskTypeNum = 1:length(vars.taskTypes)
        % set variables that will be used as field names in the behavData struct
            subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums
            tDCSsessionStr = ['session' num2str(tDCSsessionNum)];
            taskTypeStr = vars.taskTypes{taskTypeNum};
            taskTypeFieldStr = taskTypeStr;
            taskTypeFieldStr(taskTypeFieldStr == '-') = []; % get rid of hyphen for using as field name
            
        % directories - set where to load data from
            subjDir = ['sub' subjNumStr '/tDCS_sessions/' tDCSsessionStr '/' taskTypeStr '/'];
            eprimeDataDir = [vars.BST_tDCS_allRawDataDir subjDir vars.BST_tDCS_eprimeDataDir];
            eprimeDataFName = ['sub' subjNumStr '_' tDCSsessionStr '_' taskTypeStr '.xls'];
            
            dirsStruct.eprimeDataDirF = [eprimeDataDir eprimeDataFName];
            dirsStruct.buttonDataDir = [vars.BST_tDCS_allRawDataDir subjDir vars.BST_tDCS_buttonResponseDir];
            dirsStruct.eegDataDir = [vars.BST_tDCS_allRawDataDir subjDir  vars.BST_tDCS_eegRawDataDir];
            
        % parse the behavioral data for each session and store in the behavData struct
            if exist(dirsStruct.eprimeDataDirF, 'file')
                rawBehavData(subjNum).tDCSsessionNum(tDCSsessionNum).(taskTypeFieldStr) = ...
                    BST_tDCS_load_all_behavFiles_and_store_behavData(subjNum, dirsStruct,  vars);
                
                disp(['Completed Subj' num2str(subjNum) ' Session ' num2str(tDCSsessionNum) ' ' taskTypeStr])
            end
        end
    end
end

runTime.rawBehavData = [num2str(toc/60) ' minutes']


%% Prune the data (i.e. remove consecutive button presses that are the same)

prunedBehavData = BST_tDCS_pruneBehavDataStruct(rawBehavData, vars);

%% Save the rawBehavData and prunedBehavData structs separately

% rawBehavData
save([vars.BST_tDCS_behaviorDir, 'BST_tDCS_rawBehavData.mat'], 'rawBehavData', '-v7.3');

% prunedBehavData
save([vars.BST_tDCS_behaviorDir, 'BST_tDCS_prunedBehavData.mat'], 'prunedBehavData', '-v7.3');


