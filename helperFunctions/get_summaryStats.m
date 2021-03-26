function [dataMean, dataMed, dataStd, dataSem, N] = get_summaryStats(inputData, varargin)
%%

%%

% if data are in a vector
if isempty(varargin) && isvector(inputData)
    dataMean = nanmean(inputData);
    dataMed = nanmedian(inputData);
    dataStd = nanstd(inputData);
    N = length(inputData);
    dataSem = dataStd./sqrt(N);
 
% if data are in a matrix
elseif ~isempty(varargin)
    acrossDimNum = varargin{1};
    
    dataMean = nanmean(inputData, acrossDimNum);
    dataMed = nanmedian(inputData, acrossDimNum);
    dataStd = nanstd(inputData, 0, acrossDimNum);
    N = size(inputData, acrossDimNum);
    dataSem = dataStd./sqrt(N);
end

end