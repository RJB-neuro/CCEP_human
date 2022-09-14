%% RERUN preprocess
clear all
close all
%% Windows
cwp         = pwd;
idcs        = strfind(cwp,'\');
path        = cwp(1:idcs(end)-1);
idcs        = strfind(path,'\');
path        = path(1:idcs(end)-1);  % path 0, where all important folders are (Patients, codes, etc.)
%addpath('C:\Program Files\MATLAB\R2020b\toolbox\fieldtrip');
addpath(genpath([path '\elab\Epitome']));
addpath(genpath([path '\toolboxes\nx_toolbox']));
addpath([path '\toolboxes\fieldtrip']);
sep         = '\';
clearvars cwp idcs
addpath([pwd '/nx_plots_matlab']);
addpath([pwd '/nx_preproc']);
ft_defaults;
warning('off','MATLAB:xlswrite:AddSheet'); %optional
stop
%% MAC
cwp = pwd;
idcs   = strfind(cwp,'/');
path = cwp(1:idcs(end)-1);
idcs   = strfind(path,'/');
path = path(1:idcs(end)-1); 
sep = '/';
clearvars cwp idcs
addpath('/Applications/MATLAB_R2020a.app/toolbox/fieldtrip');
addpath([pwd '/nx_plots_matlab']);
addpath([pwd '/nx_preproc']);
ft_defaults;
warning('off','MATLAB:xlswrite:AddSheet'); %optional
%% get rescale factor based on one block during 5min baseline
% [sclA, sclC] = get_rescale2(ppEEG, 500);
% load one file, EEG and scalpEEG
%load('T:\EL_experiment\Patients\EL005\Data\experiment1\data_blocks\EL005_BP_CR2\EL005_BP_CR2.mat')
[sclA, sclC]             = get_rescale_factors(EEG, Fs, 0, 300);
[sclA_scalp, sclC_scalp] = get_rescale_factors(scalpEEG, scalpFs, 1, 300);
%% UPDATE STIMLIST and TTL 
subj            = 'EL015';
%block_path     = uigetdir(['E:\PhD\EL_experiment\Patients\', subj, '/Data']);
% path where all blocks are stored
block_path     = uigetdir(['T:\EL_experiment\Patients\', subj, '\Data']); %
block_files     = dir(block_path);
isdir           = [block_files.isdir]; % Get all the codes
block_files     = block_files(isdir==1); % Select only the p and H codes, delete the rest
for i=3:length(block_files)
%     run_pp(char([block_path, sep, block_files(i).name]), sclA, sclC );
%     run_pp_scalp(char([block_path, sep, block_files(i).name]), sclA_scalp, sclC_scalp, BP_label);
% %     
    %sanity_checks(char([block_path, sep, block_files(i).name]),BP_label );
%     %save_metadata(char([block_path, sep, block_files(i).name]));
%     %rescale(char([block_path, sep, block_files(i).name]),sclA, sclC)
    %create_TTL(char([block_path, sep, block_files(i).name]));
    score2list(char([block_path, sep, block_files(i).name]),0);
end