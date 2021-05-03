function [axesH] = BST_tDCS_plotFun_badChans_topo(allChansStrs, badChansStrs, topoData, subjNumStr, tDCSsessionNum, blockNum, vars)
%%

%%

[badChanNums] = BST_tDCS_get_chanNumsFromStrs(allChansStrs, badChansStrs);
goodChanNums = BST_tDCS_get_chanNumsFromStrs(allChansStrs, setdiff(allChansStrs, badChansStrs));

topoplot(topoData, vars.capLocsFName, 'emarker2', {badChanNums, 'o', 'r', 5}, 'headrad', 'rim', 'style', 'map');
hold on
topoplot(topoData, vars.capLocsFName, 'emarker2', {goodChanNums, 'o', 'k', 5}, 'headrad', 'rim', 'style', 'map');
axis([-.6 .6 -.6 .6])

title(['Block ' num2str(blockNum)], 'fontsize', 14)

axesH = gca;


end