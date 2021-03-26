function [blockData] = BST_tDCS_parse_buttonTextData(blockNum, blockTypeStr, buttonDataDir, buttonDataFName, imgOnTimes, blockData, vars)
%% Load the text files with button response data and parse the data.
    % Store data for button types and percept durations


%%

buttonData = importdata([buttonDataDir buttonDataFName], '\t');

buttonTimesAlignedToEEG = nan(length(buttonData), 1);
perceptTypeData = nan(length(buttonData), 1);
    
%% ambig. blocks
if strcmp(blockTypeStr, 'ambig')
    imgOnInds = find(strcmp(buttonData, 'Trial')) + 1; % + 1 because the response time is always one index below the text that signals the trial start
    imgOffInds = cat(1,imgOnInds(2:end) - 2, length(buttonData)); % - 2 because two rows above the startInd is the endInd of the previous trial
    
    for trialNum = 1:length(imgOnInds)
        trialStartInd = imgOnInds(trialNum);
        trialEndInd = imgOffInds(trialNum);
        
        imgOnTimeCurrTrial = imgOnTimes(trialNum);
        buttonRTdata = cellfun(@(x) str2double(x(19:end)), {buttonData{trialStartInd:trialEndInd}});
        buttonTimesAlignedToEEG(trialStartInd:trialEndInd) = round(imgOnTimeCurrTrial + buttonRTdata./1000.*vars.eegFs);
        
        perceptTypesCurrTrial = cellfun(@(x) str2double(x(12)), {buttonData{trialStartInd:trialEndInd}});
        perceptTypeData(trialStartInd:trialEndInd) = perceptTypesCurrTrial;
    end


%% discont. blocks
elseif strcmp(blockTypeStr, 'discont')
    buttonData(strcmp(buttonData, 'blankDur_trialStart')) = []; % delete messages for start of each blankDur trial
    buttonTimesAlignedToEEG = nan(length(buttonData), 1);
    perceptTypeData = nan(length(buttonData), 1);
    
    imgOnInds = find(strcmp(buttonData, 'Trial')) + 1; % + 1 because the response time is always one index below the text that signals the trial start
    imgOffInds = cat(1, imgOnInds(2:end) - 2, length(buttonData)); % -2 because end of last trial is 2 indices before imgOnInds
 
    % (optional) also load the data for button presses during blanks
    % (default is to use only button presses when an image is on the
    % screen)
    if strcmp(vars.blankButtons, 'imgAndBlank') && exist('allButtonDataTxtsBlanks', 'var')
        cd(buttonDataDir)
        
        allButtonDataTxtsBlanks = dir('*discontBlankOn*');
        buttonDataFNameBlanksLoop = {allButtonDataTxtsBlanks.name};
        
        discontBlockInd = vars.discontBlocksLoop == blockNum;
        buttonDataFNameBlank = buttonDataFNameBlanksLoop{discontBlockInd};
        buttonDataBlanks = importdata([buttonDataDir buttonDataFNameBlank], '\t');
        
        if isfield(buttonDataBlanks, 'textdata')
            imgOnIndsBlanks = find(strcmp(buttonDataBlanks, 'Blank')) + 1; 
            imgOffIndsBlanks = cat(1, imgOnIndsBlanks(2:end) - 2, length(buttonDataBlanks));
        end
    end

% get specific data and put them in behavData struct
        for imgPresNum = 1:length(imgOnInds)
            imgOnInd = imgOnInds(imgPresNum);
            imgOffInd = imgOffInds(imgPresNum);

        % get which button was pressed
            perceptTypesCurrTrial = cellfun(@(x) str2double(x(12)), {buttonData{imgOnInd:imgOffInd}});
            
            % (optional) combine button presses during img on and blank on
            if strcmp(vars.blankButtons, 'imgAndBlank') && exist('allButtonDataTxtsBlanks', 'var') && length(imgOnInds) == length(imgOnIndsBlanks) && isfield(buttonDataBlanks, 'textdata')
                imgOnIndBlanks = imgOnIndsBlanks(imgPresNum);
                imgOffIndBlanks = imgOffIndsBlanks(imgPresNum);
                
                perceptTypeDataImg = perceptTypesCurrTrial;
                perceptTypeDataBlanks = cellfun(@(x) str2double(x(12)), {buttonDataBlanks{imgOnIndBlanks:imgOffIndBlanks}});
                perceptTypesCurrTrial = cat(1, perceptTypeDataImg, perceptTypeDataBlanks);
            end
            
            if ~isempty(perceptTypesCurrTrial) % if trial had no button presses, it is left empty
                imgOnTimeCurrTrial = imgOnTimes(imgPresNum);
                buttonRTdata = cellfun(@(x) str2double(x(19:end)), {buttonData{imgOnInd:imgOffInd}});
                buttonTimesAlignedToEEG(imgOnInd:imgOffInd) = round(imgOnTimeCurrTrial + buttonRTdata./1000.*vars.eegFs);
                
                perceptTypeData(imgOnInd:imgOffInd) = perceptTypesCurrTrial;
            end
        end
end


%% get times of button presses alligned to EEG
leftPressTimes =       buttonTimesAlignedToEEG(perceptTypeData == vars.percept1ID);
rightPressTimes =      buttonTimesAlignedToEEG(perceptTypeData == vars.percept2ID);
unsurePressTimes =     buttonTimesAlignedToEEG(perceptTypeData == vars.unsureID);

blockData.buttonSeries(leftPressTimes) = vars.percept1ID;
blockData.buttonSeries(rightPressTimes) = vars.percept2ID;
blockData.buttonSeries(unsurePressTimes) = vars.unsureID;





end