function cfg = BST_tDCS_preProcessingSettings_default_EEG(preProcessingSettingsName)

cfg = [];
cfg.channel = {'all', '-TP9', '-TP10', '-EMG_1', '-EMG_2', '-Mast_L', '-Mast_R'};

cfg.demean = 'yes';
cfg.detrend = 'yes';

cfg.bsfilter   = 'yes';
cfg.bsfreq     = [58 62; 118 122; 178 182];
cfg.bsfiltord  = 4;
cfg.bsfilttype = 'but';

cfg.hpfilter = 'yes';
cfg.hpfreq = 0.5;
cfg.hpfiltord  = 3;
cfg.hpfilttype = 'but';

cfg.lpfilter = 'yes';
cfg.lpfreq = 150;
cfg.lpfiltord  = 3;
cfg.lpfilttype = 'but';

cfg.BST_PreProcessingName = preProcessingSettingsName;
cfg.BST_doICA = true;

cfg.BST_ICA.cfg.method = 'runica'; % run ica, not ru-ni-ca
cfg.BST_ICA.cfg.channel = {'all', '-TP9', '-TP10', '-EMG_1', '-EMG_2', '-Mast_L', '-Mast_R'};



end




