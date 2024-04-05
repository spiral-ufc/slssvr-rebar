%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing

% Rebar dataset | SLSSVR Model (ALD4P)
% Last Update: 2024/04/04

close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window
format short;  % Output data style (float)

dataset_rebar = RegDatasetLoader('rebar');
percentage_for_training = 0.8;
number_of_experiments = 100;
number_of_removed_samples = 100;

for step_output = 1:4
    sigma = load(sprintf('results/lssvr_sigma_%d.dat', step_output));
    regularization_parameter = load(sprintf('results/lssvr_regularization_parameter_%d.dat', step_output));
    removed_samples_vector = load(sprintf('results/ald_rebar_%d.dat', step_output));
    for step_random_seed = 1:100
        X = sprintf('step_output, step_random_seed = %d, %d.', step_output, step_random_seed); disp(X)
        dataset = RegDatasetHandler(dataset_rebar.input, dataset_rebar.output(step_output,:), percentage_for_training, step_random_seed);
        dataset = normalize(dataset, 'zscore');
        rng shuffle
        for step_removed_samples = 1:number_of_removed_samples

            input = dataset.input_train_norm;
            input(:, removed_samples_vector(step_random_seed, 1:step_removed_samples*10)) = [];
            output = dataset.output_train_norm;
            output(removed_samples_vector(step_random_seed, 1:step_removed_samples*10)) = [];

            lssvr_model = LSSVRModel();
            lssvr_model = fit(lssvr_model, input, output, sigma(step_random_seed), regularization_parameter(step_random_seed), true);

            estimated_output_norm  = predict(lssvr_model, dataset.input_test_norm);

            estimated_output = denormalize(dataset, estimated_output_norm);
            r_squared(step_random_seed, step_removed_samples) = RegDatasetHandler.rSquared(estimated_output, dataset.output_test);
        end
        r_squared(step_random_seed, :)
        save(sprintf('results/aldlssvr_r_squared_%d.dat',step_output),'r_squared','-ascii')
    end
end

boxplot(r_squared)