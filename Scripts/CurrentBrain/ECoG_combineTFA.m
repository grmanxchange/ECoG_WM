%This is the main script to combine different dimensions in the TF data in
%prep for decoding
%Project: ECoG_WM
%Author: D.T.
%Date: 09 April 2021

clear all;
close all;
clc;

%% Add relevant paths
ECoG_setPath;

%% Define important variables
subnips = {'EG_I', 'HS', 'KJ_I', 'LJ', 'MG', 'MKL', 'SB', 'WS', 'KR', 'AS', 'AP'}; %included subnips

tfa_method = 'wavelet';
epoch = 'stimLocked';
dim_com = 'chanxfreq';

%% Loop over subjects to decompose signal into time-frequency spectrum and save the resultant data file
for subi = 1 : length(subnips)
    
    %Load initial data
    if strcmp(epoch, 'stimLocked')
        load([res_path subnips{subi} '/' subnips{subi} '_tfa_wavelet_final.mat']);
    end
    
    %Select specific frequency range (to avoid nans)
    cfg = [];
    cfg.latency = [-0.14, 4.3];
    cfg.frequency = [8.0566, 185.0586];
    freq = ft_selectdata(cfg, freq);
    
    %Reshape to combine the different dimensions
    if strcmp(dim_com, 'chanxfreq')
        tmp = permute(freq.powspctrm, [1, 3, 2, 4]);
        powspctrm_tmp = reshape(tmp, [size(freq.powspctrm, 1), size(freq.powspctrm, 2)*size(freq.powspctrm, 3), size(freq.powspctrm, 4)]);
        clear 'tmp';
        freq.powspctrm = powspctrm_tmp;
        clear 'powspctrm_tmp';
    end
    
    %Save
    save([res_path subnips{subi} '/' subnips{subi} '_' dim_com '_tfa_wavelet_final.mat'], 'freq', '-v7.3');
end
 
