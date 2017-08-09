clc,clear,close
% tSNE is a unsupervised dimensionality reduction technique. I just wanted to see if this technique can be used on molecular dynamics data.
% You can find the matlab library for tSNE algorithm here : https://lvdmaaten.github.io/tsne/

% Load data
% The data format is like M rows (for frames) and N*3 columns (for 3 for X Y Z coordinates and N for atom numbers) 
load '/home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/ANALYSIS/fitted_DCD/only_Carbon_alphas_dcd/ANALYSIS/tSNE_test/RAS_GTP_375_400ns_data.dat'
load '/home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/ANALYSIS/fitted_DCD/only_Carbon_alphas_dcd/ANALYSIS/tSNE_test/RAS_GTP_PSER11_375_400ns_data.dat'
load '/home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/ANALYSIS/fitted_DCD/only_Carbon_alphas_dcd/ANALYSIS/tSNE_test/RAS_GDP_375_400ns_data.dat'
load '/home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/ANALYSIS/fitted_DCD/only_Carbon_alphas_dcd/ANALYSIS/tSNE_test/RAS_GDP_PSER11_375_400ns_data.dat'
load '/home/devanandt/Documents/RAS/1C1Y/DATA/1C1Y/ANALYSIS/fitted_DCD/only_Carbon_alphas_dcd/ANALYSIS/tSNE_test/RAS_375_400ns_label.dat'
RAS_allcases_375_400ns_data_concatenated=[RAS_GTP_375_400ns_data ;RAS_GTP_PSER11_375_400ns_data; RAS_GDP_375_400ns_data; RAS_GDP_PSER11_375_400ns_data];


train_X=RAS_allcases_375_400ns_data_concatenated;
ind = randperm(size(train_X, 1));
train_X = train_X(ind,:);
train_labels = RAS_375_400ns_label(ind);
% Set parameters
no_dims = 3;
initial_dims = 20;
%perplexity = 5000*5/100;% 5 pecent of data size
perplexity = 30;
% perplexity = 30;
% Run t−SNE
mappedX = tsne(train_X, [], no_dims, initial_dims, perplexity);
% Plot results
gscatter(mappedX(:,1), mappedX(:,2),train_labels);


RAS_allcases_tSNE_375_400ns=mappedX;
% save('RAS_allcases_tSNE_375_400ns.mat','RAS_allcases_tSNE_375_400ns') 
save RAS_allcases_2D_tSNE_vectors_375_400ns_3_20_30.dat RAS_allcases_tSNE_375_400ns -ascii % 2_5_250 stands for 2 (tSNE vector subspace dimension), 5 (PCA dimensions), perplexity = 5percent of data size (5000)=250
