%% Set the variables that will be used in most analysis scripts

%% general variables
BST_tDCS_setAllDirectories;
vars.numSubjs = 24; % set total number of subjects in the study
vars.removedSubjs = []; % set which subjects will be removed from analysis
vars.validSubjs = 1:vars.numSubjs; 
vars.validSubjs(vars.removedSubjs) = []; % create a vector with only valid subjects
vars.eegValidSubjs = vars.validSubjs; 

%% task and data structure variables
BST_tDCS_set_tDCSsessions_perSubj % set which sessions for each subject have been completed
vars.taskTypes = {'pre-tDCS', 'post-tDCS'};
% set how the data will be organized into groups and what field names
% are used in the struct that stores data for each group (do not change this ordering)
vars.groupFieldNames = {{1, 'pretDCS'}, {1, 'posttDCS'}...
                       ,{2, 'pretDCS'}, {2, 'posttDCS'}...
                       ,{3, 'pretDCS'}, {3, 'posttDCS'}}; % must be a vector
                        % a vector used to split and index all task groups
                        % first value in each cell is the INDEX of the tDCSsession (the actual session number can be set in BST_tDCS_set_tDCSsessions_perSubj.m)
                        % second value in each cell is a str for either 'pretDCS' or 'posttDCS'
                        % eg. {1, 'pretDCS'} means the group will consist of data from the pretDCS task of the first index of the cells set in BST_tDCS_set_tDCSsessions_perSubj.m
vars.imgTypes = {'faceVase', 'cube'};
vars.faceVaseImgFName = {'faceVa', 'new_fa'}; % used for differentating the image file name (only the first 6 characters are used)
vars.cubeImgFName = 'necker'; % 'neckerColor_353x353.jpg' 
vars.percept1ID = 6; % the marker value for button presses for percept1 in leftResponseMapping blocks
vars.percept2ID = 7; % value for percept 2
vars.unsureID = 8; % value for unsure
vars.perceptTypes = {'face', 'vase', 'gCube', 'bCube'}; % should be in order of {percept1, percept2}, which should match the buttonIDs set in vars.perceptButton
vars.legStrs = {'faceVase','cube'}; % set labels used for legends in plots

% ambiguous blocks
vars.ambigBlocksLoop = [1,4]; % block numbers that are ambig
vars.ambigBlockID = 1; % markerID used for ambig blocks in some scripts
vars.ambigNumTrials = 6; % number of trials per ambig block
vars.faceVaseAmbigID = 5; % marker value for ambig faceVase trials
vars.oldFaceVaseAmbigID = 4; % marker value for ambig faceVase trials that used the old faceVase image
vars.cubeAmbigID = 6; % marker value for ambig cube trials
% vars.ambigOutliersLowerB = 3;
% vars.ambigOutliersUpperB = 30;

% discontinuous blocks
vars.discontBlocksLoop = [2,3,5,6]; % block numbers that are discont
vars.discontBlockID = 2; % markerID used for discont blocks in some scripts
vars.discontNumTrials = 6; % number of trials per discont block
vars.faceVaseDiscontID = 7; % marker value for discont faceVase trials
vars.cubeDiscontID = 9; % marker value for discont cube trials
vars.discontImgOnDur = 1500; % how long image is on the screen (in ms)
vars.blankDursLoop = [570, 970, 1570]; % blank durations used in all discont trials
vars.faceVaseBlankDursLoop = [570, 970, 1570]; % blank durations used in faceVase discont trials
vars.cubeBlankDursLoop = [570, 970, 1570]; % blank durations used in cube discont trials
vars.blankButtons = 'onlyImg'; % choose whether to use button press data when only img is on the screen or both imgOn and blankOn times
                    % 'imgAndBlank'
                    % 'onlyImg'

vars.allBlocksLoop = sort([vars.ambigBlocksLoop, vars.discontBlocksLoop]); % create a vector combining all blockNums of ambig and discont blocks

vars.getStatsFieldNames = {'NumSwitches', 'NumUnsures', 'UnsurePost'...
    ,'PerceptPost', 'P1PerceptPost', 'P2PerceptPost'...
    ,'PropPercept1', 'PropPercept2', 'PerceptBias'...
    ,'ReactionTimes'};
    % set the field names for only the behavioral measures that you will get the mean, med, std, and sem for

%% EPrime behavioral data variables
vars.usefulEprimeHeaders = {'ExperimentName', 'Figure', 'blankDur', 'Block', 'Trial', 'trialList.Sample'}; 
                % Headers of columns that contain information that will be extracted from the excel sheets containing the eprime behavData
vars.trigAmbigBlockStart = 11; % trigger value for start of ambig blocks
vars.trigAmbigBlockEnd = 12; % trigger value for end of ambig blocks 
vars.trigDiscontBlockStart = 13; % trigger value for start of discont blocks 
vars.trigDiscontBlockEnd = 14; % trigger value for end of discont blocks 
vars.trigImgOn = 1; % trigger value for img onsets in both blocks
vars.trigImgOff = 2; % trigger value for img offsets in both blocks
vars.trigBlankOn = 3; % trigger value for blank onsets in discont blocks
vars.trigBlankOff = 4; % trigger value for blank offsets in discont blocks
vars.validTrigValues = [vars.trigAmbigBlockStart, vars.trigAmbigBlockEnd, vars.trigDiscontBlockStart, vars.trigDiscontBlockEnd...
                      , vars.trigImgOn, vars. trigImgOff, vars.trigBlankOn]; 
                      % create a vector of only trigger values that are considered valid (the EEG files sometimes have unecessary triggers)
                  
%% EEG data variables
vars.eegFs = 1000; % sampling frequency of EEG recordings
vars.ECRdur = 60*vars.eegFs; % duration of eyes-closed rest recordings
vars.capLocsAll64Chans = 'BST_tDCS_standard-10-20_all64Chans.locs';
all64ChansLocs = readlocs(vars.capLocsAll64Chans);
vars.capChanNamesAll64 = {all64ChansLocs(:).labels}; 
vars.capMastChanNums = [17, 22];
vars.capLocsFName = 'BST_tDCS_standard-10-20_TP9_TP10_removed.locs'; % set the name of the file that contains the channel names of the cap electrodes
locsDataStruct = readlocs(vars.capLocsFName); % load the cap electrode labels
vars.capChanNamesRemovedTP9_10 = {locsDataStruct(:).labels};
vars.capChanNumsRemovedTP9_10 = 1:length(locsDataStruct); % get the number of channels used
vars.allChanNums = vars.capChanNumsRemovedTP9_10;
vars.eogChanNamesDef = {'VEOG_Inf','VEOG_Sp','HEOG_L','HEOG_R'};


vars.rIFGchanNames = {'F6', 'FC4', 'F4', 'F8'};
for chanNum = 1:length(vars.rIFGchanNames)
    vars.rIFGchanNums(chanNum) = find(strcmp(vars.capChanNamesRemovedTP9_10, vars.rIFGchanNames{chanNum}) == 1);
end

vars.occChanNames = {'Oz', 'POz', 'O1', 'O2'};
for chanNum = 1:length(vars.occChanNames)
    vars.occChanNums(chanNum) = find(strcmp(vars.capChanNamesRemovedTP9_10, vars.occChanNames{chanNum}) == 1);
end
clear locsDataStruct
clear chanNum

%% eye tracking data variables
vars.edfFs = 1000; % sampling frequency of the eye tracking data
vars.screenLeft = 0; % left-most coordinate of screen in eye tracking gaze coordinates (pixels)
vars.screenRight = 1919; % righ-most coordinate
vars.screenTop = 0; % top-most coordinate
vars.screenBottom = 1079; % bottom-most coordinate
vars.fixCrossCoord = [length(vars.screenLeft:vars.screenRight)./2, length(vars.screenTop:vars.screenBottom)./2] + [vars.screenLeft, vars.screenTop];
                % coordinate of fixation cross
vars.windowSizeAroundBS = 50/1000*vars.edfFs; % the number of samples before and after each blink/sacc that will also be naned





