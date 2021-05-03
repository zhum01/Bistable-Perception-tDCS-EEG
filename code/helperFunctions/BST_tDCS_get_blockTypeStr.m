function [blockTypeStr] = BST_tDCS_get_blockTypeStr(blockNum, vars)
%%

%%

if any(blockNum == vars.ambigBlocksLoop)
    blockTypeStr = 'ambig';
elseif any(blockNum == vars.discontBlocksLoop)
    blockTypeStr = 'discont';
end
    



end

