function [sessionNumStr] = BST_tDCS_get_sessionNumStr_fromGroupFieldNames(subjNum, tDCSsessionNum, vars)
%% Get the correct sessionNum that corresponds to the group data being used.

%%

groupTaskTypes = cellfun(@(x) x{2}, vars.groupFieldNames, 'uniformoutput', false);
posttDCSgroupInds = ismember(groupTaskTypes, {'posttDCS'});
posttDCSgroups = {vars.groupFieldNames{posttDCSgroupInds}};
sessionNumCurr = posttDCSgroups{tDCSsessionNum}{1};
sessionNumStr = num2str(vars.tDCSsessions{subjNum}{sessionNumCurr});
        
end