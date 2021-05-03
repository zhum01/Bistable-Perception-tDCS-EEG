function [axesH, cBarH] = set_cBarLims_based_on_prctileOfData(allTopoData, lowerPrctile, upperPrctile, axesH, cBarH, varargin)
%%

%% Format the data

if iscell(allTopoData)
    allTopoData = [allTopoData{:}];
end
allTopoData = allTopoData(:);

if ~isempty(varargin) && (strcmp(varargin{1}, 'prctileRaw') || strcmp(varargin{1}, 'prctileZeroMin'))
    cBarLimType = varargin{1};
else
    cBarLimType = 'prctilePosNeg'; % default setting
end

%% Create new lims

if strcmp(cBarLimType, 'prctileRaw')
    newAbsLims = [prctile(allTopoData, lowerPrctile), prctile(allTopoData, upperPrctile)];
elseif strcmp(cBarLimType, 'prctilePosNeg') || strcmp(cBarLimType, 'prctileZeroMin')
    newAbsLims = [-max(abs([prctile(allTopoData, lowerPrctile), prctile(allTopoData, upperPrctile)]))...
                  max(abs([prctile(allTopoData, lowerPrctile), prctile(allTopoData, upperPrctile)]))];
end

[~, decPlaceToRoundTo] = find_firstNonZeroDigit_afterDecimal(diff(newAbsLims));
% specify what to round to for borderline cases (eg. when data range is large, rounding to nearest 5 instead of .5) 
if decPlaceToRoundTo == 1 
    if diff(newAbsLims) < .7
        decPlaceToRoundTo = 2;
    elseif diff(newAbsLims) > 3 && diff(newAbsLims) <= 50
        decPlaceToRoundTo = 0;
    elseif diff(newAbsLims) > 50
        decPlaceToRoundTo = -1;
    else
    end
end
newCLims = [round5(newAbsLims(1), 5*10^-decPlaceToRoundTo, 'floor'), round5(newAbsLims(2), 5*10^-decPlaceToRoundTo, 'ceil')];

if strcmp(cBarLimType, 'prctileZeroMin')
    newCLims = [0, round5(newAbsLims, .05, 'ceil')];
end

for subplotNum = 1:length(axesH)
    try % not all subplots may be plotted or have a colorbar
        axesH(subplotNum).CLim = newCLims;
        cBarH(subplotNum).Ticks = newCLims;
    end
end

            
end

