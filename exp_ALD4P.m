%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing

% Rebar dataset | ALD4P
% Last Update: 2024/04/04

close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window
format short;  % Output data style (float)

dataset_rebar = RegDatasetLoader('rebar');
percentage_for_training = 0.8;
it = 1000;

for step_output = 1:4
    removed_samples_vector = zeros(100,it);
    sigma = load(sprintf('results/lssvr_sigma_%d.dat', step_output));
    for step_random_seed = 1:100
        X = sprintf('step_output, step_random_seed = %d, %d.',step_random_seed, step_output);
        disp(X)
        dataset = RegDatasetHandler(dataset_rebar.input, dataset_rebar.output(step_output,:), percentage_for_training, step_random_seed);
        rng shuffle
        dataset = normalize(dataset, 'zscore');
        HP.sigma = sigma(step_random_seed);
        HP.regularization_parameter = 0.00001;
        HP.it = it;
        HP.kernel_type = 'rbf';
        removed_samples_vector(step_random_seed, :) = ald_selection(dataset.input_train_norm,HP);
        save(sprintf('results/aldii_rebar_%d.dat',step_output),'removed_samples_vector','-ascii')
        clc
    end
end