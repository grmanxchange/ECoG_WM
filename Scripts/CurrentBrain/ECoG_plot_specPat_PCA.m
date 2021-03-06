%This is the main script to plot the results of the PCA.
%Project: ECoG_WM
%Author: D.T.
%Date: 07 June 2021

clear all;
close all;
clc;

%% Add relevant paths
ECoG_setPath;

%% Define important variables
subnips = {'EG_I', 'HS', 'KJ_I', 'LJ', 'MG', 'MKL', 'SB', 'WS', 'KR', 'AS', 'AP'}; %included subnips

blc = 0; %normalization: yes or no
pca_method = 'pca'; %eigendecomposition or pca_con or pca

var_thresh = 95;

%% Define important parameters
frequency = 'fullSpectrum';

if strcmp(frequency, 'fullSpectrum')
    latencies = [-0.14, 4.3]; %to account for the lower frequencies
    freqs = [8, 180];
elseif strmcp(frequency, 'HGP')
    latencies =  [-0.2, 4.5];
    freqs = [70 150];
end

%% Loop over subjects
for subi = 1 : length(subnips)
    
    %Load data
    pc{subi} = load([res_path subnips{subi} '/' subnips{subi} '_PCA_' pca_method '_' frequency '_baselineCorr_' num2str(blc) '_pc.mat'], 'pc');
    proj{subi} = load([res_path subnips{subi} '/' subnips{subi} '_PCA_' pca_method '_' frequency '_baselineCorr_' num2str(blc) '_proj.mat'], 'proj');
    eigvals{subi} = load([res_path subnips{subi} '/' subnips{subi} '_PCA_' pca_method '_' frequency '_baselineCorr_' num2str(blc) '_eigvals.mat'], 'eigvals');
    var_expl{subi} = load([res_path subnips{subi} '/' subnips{subi} '_PCA_' pca_method '_' frequency '_baselineCorr_' num2str(blc) '_var_expl.mat'], 'var_expl');
    
    
    %% Loop over channels 
    for chani = 1 : length(pc{subi}.pc)
        
        %Identify number of components accounting for 95% of the variance
        cumsum_tmp = cumsum(var_expl{subi}.var_expl{chani});
        row = find(cumsum_tmp < var_thresh);   
        n_comps{subi}(chani)  = length(row)+1;
        
    end
end
