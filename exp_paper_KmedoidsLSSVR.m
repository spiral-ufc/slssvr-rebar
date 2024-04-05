%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing

% Rebar dataset | SLSSVR Model (kmedoids)
% Last Update: 2024/04/04

close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window
format short;  % Output data style (float)

dataset_rebar = RegDatasetLoader('rebar');
percentage_for_training = 0.8;
number_of_experiments = 100;
number_of_clusters = 100;

for step_output = 1:4
    sigma = load(sprintf('results/lssvr_sigma_%d.dat', step_output));
    regularization_parameter = load(sprintf('results/lssvr_regularization_parameter_%d.dat', step_output));
    for step_random_seed = 1:100
        X = sprintf('step_output, step_random_seed = %d, %d.', step_output, step_random_seed); disp(X)
        dataset = RegDatasetHandler(dataset_rebar.input, dataset_rebar.output(step_output,:), percentage_for_training, step_random_seed);
        dataset = normalize(dataset, 'zscore');
        rng shuffle
        for step_number_of_clusters = 1:number_of_clusters

            [~, centroids] = kmedoids([dataset.input_train_norm;dataset.output_train_norm]', 1040 - (step_number_of_clusters) * 10,'Distance','sqeuclidean');
            input_centroids = centroids(:,1:18)';
            output_centroids = centroids(:,19)';


            lssvr_model = LSSVRModel();
            lssvr_model = fit(lssvr_model, input_centroids, output_centroids,...
                sigma(step_random_seed), regularization_parameter(step_random_seed), true);

            estimated_output_norm  = predict(lssvr_model, dataset.input_test_norm);

            estimated_output = denormalize(dataset, estimated_output_norm);
            r_squared(step_random_seed, step_number_of_clusters) = RegDatasetHandler.rSquared(estimated_output, dataset.output_test);
        end
        r_squared(step_random_seed, :)
        save(sprintf('results/kmedoids2lssvr_r_squared_%d.dat',step_output),'r_squared','-ascii')
        
    end
end

boxplot(r_squared)