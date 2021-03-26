function vars = BST_tDCS_make_ICA_figures(subjNum, tDCSsessionNum, blockNum, preProcessingSettingsName, vars)

%% Parameters
subjNumStr = add_0_before_singleDigit_subjNums(subjNum);

numFFT = 2^12; %number of fft points for hamming window when calculating power spectrum
samplingFrequency = vars.eegFs;
maxFrequency = 50; %maximum frequency to show on power spectrum
plotTmsLength =  50 * samplingFrequency; %Amount of data to show on each row of timecourse figure
icaDataDirF = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/sub' subjNumStr ...
                '/Subject' subjNumStr '_session' num2str(tDCSsessionNum) '_' vars.blockNumStr '_componentData_' preProcessingSettingsName '.mat'];
figuresDir = [vars.BST_tDCS_preProcessedDataDir preProcessingSettingsName '/ICA_Figures/Subject' subjNumStr '/'...
              'session' num2str(tDCSsessionNum) '/' vars.blockNumStr '/'];


load(icaDataDirF);

vars.numIcaComps = length(icaComponentStruct.label);

if ~exist(figuresDir,'dir')
    mkdir(figuresDir);
end

% topo plot
for compNum = 1:vars.numIcaComps
    % disp(['Component Number: ' num2str(compNum)])
    figure('visible','off');
    topoPlotData = icaComponentStruct.topo(:,compNum);
    mx = max(abs(topoPlotData));
    topoplot(topoPlotData, vars.capLocsFName);
    set(gca,'clim',[-mx mx]);
    axis off
    colorbar
    axis square
    print('-dpng','-r100',[figuresDir 'Topo' num2str(compNum)]);
    close all
end


% power spectrum plots
for compNum = 1:vars.numIcaComps
    tmsDataCurrComp = icaComponentStruct.trial{1}(compNum,:);
    
    [p,f] = pwelch(tmsDataCurrComp,hamming(numFFT),[],numFFT,samplingFrequency);
    figure('visible','off');
    plot(f,log10(p));
    xlabel('Frequency (Hz)');
    ylabel('Power (dB)');
    set(gca,'xlim',[0 maxFrequency]);
    set(gca,'ylim',[min(log10(p(f <maxFrequency))) max(log10(p(f <maxFrequency)))]);
    box off
    
    axis square
    print('-dpng','-r100',[figuresDir 'Pwelch' num2str(compNum)]);
    close all
    
    figure('visible','off');
    hold on
    
% time course plots    
    mn = mean(tmsDataCurrComp);
    sd = std(tmsDataCurrComp);
    maxRowsTimeCourse = ceil(length(tmsDataCurrComp)/plotTmsLength);
    for plotRowNum = 1:maxRowsTimeCourse
        tms = (1 + (plotRowNum-1)*plotTmsLength:plotRowNum*plotTmsLength);
        if any(tms > length(tmsDataCurrComp))
            tms = tms(tms <= length(tmsDataCurrComp));
        end
        plot(tmsDataCurrComp(tms) + (-plotRowNum * sd * 10));
        hold on;
    end
    set(gcf,'position',[30         235        1205         582])
    print('-dpng','-r100',[figuresDir 'Data' num2str(compNum)]);
    close all
    
end




end







