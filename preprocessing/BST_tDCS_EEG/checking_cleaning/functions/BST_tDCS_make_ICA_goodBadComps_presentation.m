function BST_tDCS_make_ICA_goodBadComps_presentation(subjNum, tDCSsessionNum, preProcessingSettingsName, vars)
%%

%%
BST_tDCS_setAllDirectories;
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums

figuresDir = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/ICA_Figures/Subject' subjNumStr '/'...
              'session' num2str(tDCSsessionNum) '/' vars.blockNumStr '/'];

import mlreportgen.ppt.*

slidesDir = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/ICA_Figures/goodBadComps_separated/' ...
             'Subject' subjNumStr '/session' num2str(tDCSsessionNum) '/'];
if ~exist(slidesDir, 'dir')
    mkdir(slidesDir)
end
slidesFName = ['Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_' vars.blockNumStr '_ICAComponents_goodBadSeparated.pptx'];

slides = Presentation([slidesDir slidesFName], [vars.BST_tDCS_preProcessedDataDir 'ICA_Template.pptx']);

% get total number of ICA components
allFiles = dir([figuresDir, '*.png']);
numComps = length(allFiles)/3;

% get the good and bad component nums
blockNum = str2double(vars.blockNumStr(end));
ICAcompsToRemove = BST_tDCS_ICAstandard_compsToReject_separateBlocks;
currBlockGoodBadComps{1} = setdiff(1:numComps, ICAcompsToRemove(subjNum).tDCSsessionNum(tDCSsessionNum).blockNum(blockNum).componentsToReject);
currBlockGoodBadComps{2} = ICAcompsToRemove(subjNum).tDCSsessionNum(tDCSsessionNum).blockNum(blockNum).componentsToReject;

% put the components into slides (first half good comps, second half bad comps)
for goodOrBadInd = 1:2 % 1 is index for NOT removed components, 2 is index for removed components
    compsToAddToPPT = currBlockGoodBadComps{goodOrBadInd};
    
    presentationTitleSlide = add(slides,'Title Slide');
    if goodOrBadInd == 1
        replace(presentationTitleSlide,'Title',['NOT Removed ICA components for subject ' subjNumStr ' ' vars.blockNumStr]);
    elseif goodOrBadInd == 2
        replace(presentationTitleSlide,'Title',['Removed ICA components for subject ' subjNumStr ' ' vars.blockNumStr]);
    end
    
    for compNum = compsToAddToPPT
        % disp(['Component Number: ' num2str(compNum)])
        pictureSlide = add(slides,'ICALayout');
        
        nmData = [figuresDir 'Data' num2str(compNum) '.png'];
        pnameData = Picture(nmData);
        data = find(pictureSlide,'Data');
        replace(data(1),pnameData);
        
        nmPwelch = [figuresDir 'Pwelch' num2str(compNum) '.png'];
        pnamePwelch = Picture(nmPwelch);
        pwelc = find(pictureSlide,'Pwelch');
        replace(pwelc(1),pnamePwelch);
        
        nmTopo = [figuresDir 'Topo' num2str(compNum) '.png'];
        pnameTopo = Picture(nmTopo);
        topo = find(pictureSlide,'Topo');
        replace(topo(1),pnameTopo);
        
        head1 = Paragraph(['Component ' num2str(compNum)]);
        replace(pictureSlide,'Title',head1);
        
    end
end


close(slides);


end





    