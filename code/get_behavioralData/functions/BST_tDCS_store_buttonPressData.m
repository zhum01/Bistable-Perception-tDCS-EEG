function [blockData] = BST_tDCS_store_buttonPressData...
    (blockNum, blockTypeStr, buttonDataDir, buttonDataFName, trigTimesStruct, blankDurs, eprimeData, vars)
%% Load the button press data and parses the data for button press times, button press type
% and then stores this data along with imgType, blockType, respons mapping, etc.


%%

blockData.triggerSeries = zeros(length(trigTimesStruct.blockStartTime:(trigTimesStruct.blockEndTime - 1)), 1);
blockData.buttonSeries = zeros(length(trigTimesStruct.blockStartTime:(trigTimesStruct.blockEndTime - 1)), 1);

[blockData] = BST_tDCS_get_numImgPres_and_blankDurs_perTrial(blockTypeStr, buttonDataDir, buttonDataFName, eprimeData(blockNum), blockData, vars);

[blockData] = BST_tDCS_parse_buttonTextData(blockNum, blockTypeStr, buttonDataDir, buttonDataFName, trigTimesStruct.imgOnTimes, blockData, vars);

% for discont blocks, store the blankDurs
if strcmp(blockTypeStr, 'discont') 
    for blankNum = 1:length(blankDurs)
        blockData.trial(blankNum).blankDur = blankDurs(blankNum);
    end
end

% get the response mapping of the block
recordingName = strtok(eprimeData(blockNum).ExperimentName{1},'_');
if strcmp(recordingName(end-1:end),'12')
    blockData.hand = 'L';
elseif strcmp(recordingName(end-1:end),'21')
    blockData.hand = 'R';
end


% get the blockType and imageType of each trial
recordingFigsList = eprimeData(blockNum).Figure;

switch recordingName(1:5)
    
    case 'Ambig'
        blockData.runType = vars.ambigBlockID;
        for imgPresNum = 1:length(trigTimesStruct.imgOnTimes)
            trialTms = trigTimesStruct.imgOnTimes(imgPresNum):trigTimesStruct.imgOffTimes(imgPresNum);
            switch recordingFigsList{imgPresNum}(1:6)
                case vars.faceVaseImgFName
                    trialImgType = vars.faceVaseAmbigID;
                case vars.cubeImgFName
                    trialImgType = vars.cubeAmbigID;
            end
            blockData.triggerSeries(trialTms) = trialImgType;
        end
        
    case 'Disco'
        blockData.runType = vars.discontBlockID;
        for imgPresNum = 1:length(trigTimesStruct.imgOnTimes)
            imgOnTms = trigTimesStruct.imgOnTimes(imgPresNum):trigTimesStruct.imgOffTimes(imgPresNum);
            blankTms = trigTimesStruct.blankOnTimes(imgPresNum):trigTimesStruct.blankOffTimes(imgPresNum);
            switch recordingFigsList{imgPresNum}(1:6)
                case vars.faceVaseImgFName
                    trialImgType = vars.faceVaseDiscontID;
                case vars.cubeImgFName
                    trialImgType = vars.cubeDiscontID;
            end
            blockData.triggerSeries(imgOnTms) = trialImgType;
            blockData.triggerSeries(blankTms) = trialImgType + 1; % add blank periods after trial.
        end
end

% get the button press times and types
numImgPres = length(trigTimesStruct.imgOnTimes);
    
    for imgPresNum = 1:numImgPres
        
    % img on and off times
        blockData.trial(imgPresNum).imgOnTimes = trigTimesStruct.imgOnTimes(imgPresNum);
        blockData.trial(imgPresNum).imgOffTimes = trigTimesStruct.imgOffTimes(imgPresNum);
        trialTms = trigTimesStruct.imgOnTimes(imgPresNum):trigTimesStruct.imgOffTimes(imgPresNum);
        
        blockData.trial(imgPresNum).imgType =  blockData.triggerSeries(trialTms(1));
        
    % blank on and off times
    if strcmp(blockTypeStr, 'discont')
        blockData.trial(imgPresNum).blankOnTimes = trigTimesStruct.blankOnTimes(imgPresNum);
        blockData.trial(imgPresNum).blankOffTimes = trigTimesStruct.blankOffTimes(imgPresNum);
    end
        
    % button press times and percept types
        buttonTimes = find(diff(blockData.buttonSeries(trialTms)) > 0);
        buttonTimes = blockData.trial(imgPresNum).imgOnTimes + buttonTimes;
        blockData.trial(imgPresNum).buttonTimes = buttonTimes;
        buttonTypes = blockData.buttonSeries(buttonTimes);
        
        blockData.trial(imgPresNum).buttonTypes = buttonTypes;
        blockData.trial(imgPresNum).perceptType = buttonTypes;
        blockData.trial(imgPresNum).perceptTimes = blockData.trial(imgPresNum).buttonTimes;
        
        if blockData.hand == 'R'    % Switch percepts for right handed trials
            blockData.trial(imgPresNum).perceptType(buttonTypes == vars.percept2ID) = vars.percept1ID;
            blockData.trial(imgPresNum).perceptType(buttonTypes == vars.percept1ID) = vars.percept2ID;
        end
        
    % percept durations
        if length(blockData.trial(imgPresNum).buttonTimes) > 1
            blockData.trial(imgPresNum).buttonPre =   [buttonTimes(1) - trigTimesStruct.imgOnTimes(imgPresNum) ; ...
                                                                     buttonTimes(2:end) - buttonTimes(1:end-1)];
            blockData.trial(imgPresNum).perceptPre =  blockData.trial(imgPresNum).buttonPre;
            blockData.trial(imgPresNum).buttonPost =  [buttonTimes(2:end) - buttonTimes(1:end-1) ; ...
                                                                     blockData.trial(imgPresNum).imgOffTimes -  buttonTimes(end)];
            blockData.trial(imgPresNum).perceptPost =  blockData.trial(imgPresNum).buttonPost;
        elseif length(blockData.trial(imgPresNum).buttonTimes) == 1
            blockData.trial(imgPresNum).buttonPre =  [buttonTimes(1) - trigTimesStruct.imgOnTimes(imgPresNum)];
            blockData.trial(imgPresNum).perceptPre =  blockData.trial(imgPresNum).buttonPre;
            blockData.trial(imgPresNum).buttonPost =  [trigTimesStruct.imgOffTimes(imgPresNum) -  buttonTimes(end)];
            blockData.trial(imgPresNum).perceptPost =  blockData.trial(imgPresNum).buttonPost;
        end
    end

end



