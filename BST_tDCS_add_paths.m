BST_tDCS_setAllDirectories

initDir = pwd;
restoredefaultpath;

% fieldtrip
cd([vars.BST_tDCS_toolboxesDir 'fieldtrip-20161114/'])
ft_defaults

% eeglab
addpath([vars.BST_tDCS_toolboxesDir 'eeglab14_1_1b/']) 
eeglab % load eeglab functions automatically
close all

% custom scripts
addpath(genpath(vars.BST_tDCS_baseDir))


cd(initDir)
clear
clc

