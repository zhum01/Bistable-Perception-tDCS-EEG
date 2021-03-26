function combinedEegStruct = BST_tDCS_combineEegStructs(eegCell, vars)
%Function takes a cell of fieldtrip eeg structs, and makes one combined eeg
%struct containing a set of trials

%%

combinedEegStruct = struct;

% remove empty cells
notEmptyCells = cellfun(@(x) ~isempty(x), eegCell);
eegCell = {eegCell{notEmptyCells}};

if isfield(eegCell{2}, 'hdr') % not sure why I chose to use 2nd cell
    combinedEegStruct.hdr     = eegCell{2}.hdr;
end
combinedEegStruct.label   = eegCell{2}.label;
combinedEegStruct.fsample = eegCell{2}.fsample;
combinedEegStruct.cfg     = eegCell{2}.cfg;

combinedEegStruct.time       = [];
combinedEegStruct.trial      = [];
combinedEegStruct.sampleinfo = [];

for eegStructNum= 1:numel(eegCell)
    
    combinedEegStruct.time       = [combinedEegStruct.time         eegCell{eegStructNum}.time];
    combinedEegStruct.trial      = [combinedEegStruct.trial        eegCell{eegStructNum}.trial];
    
    if eegStructNum == 1
        combinedEegStruct.sampleinfo = [combinedEegStruct.sampleinfo;  eegCell{eegStructNum}.sampleinfo];
    else
        combinedEegStruct.sampleinfo = [combinedEegStruct.sampleinfo;  eegCell{eegStructNum}.sampleinfo + combinedEegStruct.sampleinfo(end,end)];
    end

end

end




