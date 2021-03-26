%%
vars.BST_tDCS_baseDir = '/isilon/LFMI/VMdrive/Mike/bistable/BST_tDCS/gitScripts/';
vars.BST_tDCS_toolboxesDir = '/isilon/LFMI/VMdrive/Mike/toolboxes/';
vars.BST_tDCS_allDataDir = ['/isilon/LFMI/VMdrive/Mike/bistable/BST_tDCS/data_files/'];

% raw and processed data directories
vars.BST_tDCS_allRawDataDir =       [vars.BST_tDCS_allDataDir 'all_rawData/'];
vars.BST_tDCS_processedDataDir =    [vars.BST_tDCS_allDataDir 'processed_data/'];

% tDCS sessions
vars.BST_tDCS_eegRawDataDir =       'EEG_rawData/';
vars.BST_tDCS_eprimeDataDir =       'EPrime_behavioralData/';
vars.BST_tDCS_buttonResponseDir =   'buttonResponseData/';
vars.BST_tDCS_ETdataDir =           'eyeTrackingData/';
vars.edf2ascAppDir = '/isilon/LFMI/VMdrive/Mike/bistable/BST_tDCS/toolboxes/EDF2ASC/'; % directory of the application that converts .edf files to .asc
% screening sessions
vars.BST_tDCS_screeningSessionDir =    'screening_session/';

% processed data directories
vars.BST_tDCS_preProcessedDataDir = [vars.BST_tDCS_processedDataDir 'EEG_preProcessed/'];
vars.BST_tDCS_EEGpostProcessedDataDir = [vars.BST_tDCS_processedDataDir 'EEG_postProcessed/'];
vars.BST_tDCS_trialDataDir =        [vars.BST_tDCS_processedDataDir 'EEG_trialData/'];
vars.BST_tDCS_behaviorDir =         [vars.BST_tDCS_processedDataDir 'behavioralData_mats/'];



