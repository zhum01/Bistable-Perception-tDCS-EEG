function [] = makeDirFun(dirToMake)
%% checks if a directory exists and create it if it doesn't

%%

if ~exist(dirToMake, 'dir')
    mkdir(dirToMake)
end


end