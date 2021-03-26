function vars = BST_tDCS_set_blockVars(blockNum, vars)
%% Set the variables specific to different types of blocks 
% eg. instruction and fixation screen durations for ambig. vs. discont. blocks


%%

% sometimes these strs are used for saving ICA data files
if isfield(vars, 'blocksLoop')
    if sum(vars.blocksLoop) == sum(vars.allBlocksLoop) % if all blocks were combined in the ICAcomp file
        vars.blockNumStr = 'allBlocks';
    elseif length(vars.blocksLoop) == 1 % if loading ICAcomp data one block at a time
        vars.blockNumStr = ['block' num2str(vars.blocksLoop)];
    else
        vars.blockNumStr = 'multipleBlocks';
    end
else
    vars.blockNumStr = num2str(blockNum);
end


% ambiguous blocks
if any(blockNum == vars.ambigBlocksLoop)
    vars.blockType = 'ambig';
    vars.blockImgIDStr = 'AmbigID';
    vars.trigBlockStart = vars.trigAmbigBlockStart;
    vars.trigBlockEnd = vars.trigAmbigBlockEnd;
    vars.blockTypeLoop = vars.ambigBlocksLoop;
    vars.buttonDataFNames = '*ambig*';
    vars.ETimgTypes = {'allImgTms', 'faceVaseTms', 'cubeTms'};
    vars.instrDur = 2;
    vars.fixDur = 2;
    vars.imgDur = 60;
    
% discontinuous blocks    
elseif any(blockNum == vars.discontBlocksLoop)
    vars.blockType = 'discont';
    vars.blockImgIDStr = 'DiscontID';
    vars.trigBlockStart = vars.trigDiscontBlockStart;
    vars.trigBlockEnd = vars.trigDiscontBlockEnd;
    vars.blockTypeLoop = vars.discontBlocksLoop; 
    vars.buttonDataFNames = '*discontImgOn*';
    vars.ETimgTypes = {'allImgTms', 'faceVaseTms', 'cubeTms'};
    vars.instrDur = 2;
    vars.fixDur = 0;
    vars.imgDur = 1.5;
end

vars.preImgOnDur = vars.instrDur + vars.fixDur; % set the time (s) between start of trial and img onset (i.e. usually the duration of the instructions and fixation screens)


end