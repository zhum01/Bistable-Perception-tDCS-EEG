function BST_tDCS_make_ICA_presentation(subjNum, tDCSsessionNum, blockNum, preProcessingSettingsName, numComps, vars)
%%

%%
BST_tDCS_setAllDirectories;
subjNumStr = add_0_before_singleDigit_subjNums(subjNum); % add a 0 before single digit subjNums

figuresDir = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/ICA_Figures/Subject' subjNumStr '/'...
              'session' num2str(tDCSsessionNum) '/' vars.blockNumStr '/'];

import mlreportgen.ppt.*
slidesDir = [figuresDir 'slides/'];
if ~exist(slidesDir, 'dir')
    mkdir(slidesDir)
end

slidesDir = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/ICA_Figures/Subject' subjNumStr '/'...
              'session' num2str(tDCSsessionNum) '/'];
slidesFName = ['Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_' vars.blockNumStr '_ICAComponents.pptx'];

slides = Presentation([slidesDir slidesFName], [vars.BST_tDCS_preProcessedDataDir 'ICA_Template.pptx']);

presentationTitleSlide = add(slides,'Title Slide');
replace(presentationTitleSlide,'Title',['ICA components for subject ' subjNumStr ' ' vars.blockNumStr]);

for compNum = 1:numComps
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

close(slides);


end





    