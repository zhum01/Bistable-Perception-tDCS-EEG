loadDir = '/data/gogodisk1/Mike/bistable/BST_tDCS/general_scripts/';
templateFName = 'eeg1010_neighb.mat';

load([loadDir templateFName])

% first remove cap mastoids from list of electrodes
locsDataStruct = readlocs('BST_tDCS_standard-10-20_all64Chans.locs'); % load the cap electrode labels
capChanNamesAll64 = {locsDataStruct(:).labels};

tp9Ind = find(strcmp(capChanNamesAll64, 'TP9'));
tp10Ind = find(strcmp(capChanNamesAll64, 'TP10'));
mastInds = [tp9Ind tp10Ind];

capChansMastRemoved = capChanNamesAll64;
capChansMastRemoved(mastInds) = [];

neighbTemp = neighbours;
invalidChanStrs = setdiff({neighbTemp.label},capChanNamesAll64);

% Remove all channels that aren't part of the acticap
for chanNum = 1:length(neighbTemp)
    if any(strcmp(neighbTemp(chanNum).label, invalidChanStrs))
        neighbTemp(chanNum).label = {};
    else
        neighborChans = neighbTemp(chanNum).neighblabel;
        chansToRemove = setdiff(neighborChans, capChansMastRemoved);
        
        if ~isempty(chansToRemove)
            for chanToRemoveNum = 1:length(chansToRemove)
                removeInd = strcmp(chansToRemove{chanToRemoveNum}, neighborChans);
                neighborChans(removeInd) = [];
            end
            
            neighbTemp(chanNum).neighblabel = neighborChans;
        end
    end
end

% Go back and remove invalid channels
for chanNum = 1:length(neighbours)
    if chanNum <= length(neighbTemp)
        if isempty(neighbTemp(chanNum).label)
            neighbTemp(chanNum) = [];
        end
    end
end


neighbsAllChans = neighbTemp;

saveDir = loadDir;
saveFName = 'eeg1010_neighb_ADJUSTED.mat';
save([saveDir, saveFName], 'neighbsAllChans');




