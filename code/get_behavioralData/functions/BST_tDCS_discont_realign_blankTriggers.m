function [imgOffTimes, blankOnTimes, blankOffTimes, blankDurs] ...
    = BST_tDCS_discont_realign_blankTriggers(subjNum, blockStartTime, imgOnTimes, triggerValues, triggerTimes, vars)
%% Get blank durations and realign blank on and off times to block start times.

%%

% get img offset times
diffTrigTimes = diff(triggerTimes); % differences are in the order: blankOn - imgOn (imgDur), blankOff - blankOn (blankDur), next imgOn - blankOff (unintentional ~370ms lag from eprime eyetracking script)
imgDurs = diffTrigTimes(triggerValues == vars.trigImgOn);
imgOffTimes = imgOnTimes + imgDurs - 1;

% get blank onset and offset times
if subjNum < 12 % for discont blocks of first 12 subjects, triggers weren't sent for imgOff and blankOff times, so get these times by using differences of trigger times
blankDurs = diffTrigTimes(triggerValues == vars.trigBlankOn); % blank duration is the time from blankOn until the next imgOn

elseif subjNum >= 12 % value of blankOff trigger was changed for sub12 and after, so blank duration can be determined using blankOff triggers
    blankDurs = diffTrigTimes(triggerValues == vars.trigBlankOn)...
        + diffTrigTimes(triggerValues == vars.trigBlankOff);
end

% the time difference between triggers at the end of trials will be longer than the maximum blankDur (because these include fixation screen time),
% so find these times and record the blankDur as the same as the previous blankDur
trialEndBlankInds = find(blankDurs > max(vars.blankDursLoop) + 500);
blankDurs(trialEndBlankInds) = blankDurs(trialEndBlankInds - 1);

blankOnTimes = triggerTimes(triggerValues == vars.trigBlankOn) - blockStartTime;
blankOffTimes = blankOnTimes + blankDurs - 1;


end




