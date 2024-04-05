%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing

% Rebar dataset | L-SLSSVR Model
% Last Update: 2024/04/04

close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window
format short;  % Output data style (float)

dataset_rebar = RegDatasetLoader('rebar');
percentage_for_training = 0.8;
number_of_experiments = 100;
number_of_clusters = 25;
number_of_sv = [660 850 610 640];


for step_output = 1
    sigma = load(sprintf('results/lssvr_sigma_%d.dat', step_output));
    regularization_parameter = load(sprintf('results/lssvr_regularization_parameter_%d.dat', step_output));
    for step_random_seed = 1:100
        X = sprintf('step_output, step_random_seed = %d, %d.', step_output, step_random_seed); disp(X)
        dataset = RegDatasetHandler(dataset_rebar.input, dataset_rebar.output(step_output,:), percentage_for_training, step_random_seed);
        dataset = normalize(dataset, 'zscore');
        rng shuffle
        [~, centroids] = kmedoids ([dataset.input_train_norm;dataset.output_train_norm]', number_of_sv(step_output),'Distance','sqeuclidean');
        input_centroids = centroids(:,1:18)';
        output_centroids = centroids(:,19)';
        for step_number_of_clusters = 1:number_of_clusters
            llssvr_model = LocalLSSVRModel();
            llssvr_model = fit(llssvr_model, input_centroids, output_centroids,...
                sigma(step_random_seed), regularization_parameter(step_random_seed), true, step_number_of_clusters);
            tstart = tic;
            [estimated_output_norm, aux_number_of_operations]  = predict(llssvr_model, dataset.input_test_norm);
            telapsed = toc(tstart);
            estimated_output = denormalize(dataset, estimated_output_norm);
            r_squared(step_random_seed, step_number_of_clusters) = RegDatasetHandler.rSquared(estimated_output, dataset.output_test);
            number_of_operations(step_random_seed, step_number_of_clusters) = mean(aux_number_of_operations);
            time_of_operations(step_random_seed, step_number_of_clusters) = telapsed;
        end
        r_squared(step_random_seed, :)
        number_of_operations(step_random_seed, :)
        save(sprintf('results/slocallssvr_r_squared_%d.dat',step_output),'r_squared','-ascii')
        save(sprintf('results/slocallssvr_number_of_operations_%d.dat',step_output),'number_of_operations','-ascii')
        save(sprintf('results/slocallssvr_time_of_operations_%d.dat',step_output),'time_of_operations','-ascii')
    end
end