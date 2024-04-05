%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing

% Rebar dataset | LSSVR Model
% Last Update: 2024/04/04

close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window
format short;  % Output data style (float)

dataset_rebar = RegDatasetLoader('rebar');
percentage_for_training = 0.8;
number_of_experiments = 100;
number_of_clusters = 1;

r_squared_1 = zeros(number_of_experiments, number_of_clusters);
r_squared_2 = zeros(number_of_experiments, number_of_clusters);
r_squared_3 = zeros(number_of_experiments, number_of_clusters);
r_squared_4 = zeros(number_of_experiments, number_of_clusters);

sigma_1 = zeros(number_of_experiments, number_of_clusters);
sigma_2 = zeros(number_of_experiments, number_of_clusters);
sigma_3 = zeros(number_of_experiments, number_of_clusters);
sigma_4 = zeros(number_of_experiments, number_of_clusters);

regularization_parameter_1 = zeros(number_of_experiments, number_of_clusters);
regularization_parameter_2 = zeros(number_of_experiments, number_of_clusters);
regularization_parameter_3 = zeros(number_of_experiments, number_of_clusters);
regularization_parameter_4 = zeros(number_of_experiments, number_of_clusters);

for step_number_of_clusters = 1:number_of_clusters
    
    for step_random_seed = 1:number_of_experiments
        
        dataset = RegDatasetHandler(dataset_rebar.input, dataset_rebar.output, percentage_for_training, step_random_seed);
        dataset = normalize(dataset, 'zscore');

        lssvr_model = LSSVRModel();
        lssvr_model = tuning(lssvr_model, dataset.input_train_norm, dataset.output_train_norm, true);
        estimated_output_norm  = predict(lssvr_model, dataset.input_test_norm);
        estimated_output = denormalize(dataset, estimated_output_norm);

        r_squared = RegDatasetHandler.rSquared(estimated_output, dataset.output_test);
        

        r_squared_1(step_random_seed, step_number_of_clusters) = r_squared(1);
        r_squared_2(step_random_seed, step_number_of_clusters) = r_squared(2);
        r_squared_3(step_random_seed, step_number_of_clusters) = r_squared(3);
        r_squared_4(step_random_seed, step_number_of_clusters) = r_squared(4);

        sigma_1(step_random_seed, step_number_of_clusters) = lssvr_model.sigma(1);
        sigma_2(step_random_seed, step_number_of_clusters) = lssvr_model.sigma(2);
        sigma_3(step_random_seed, step_number_of_clusters) = lssvr_model.sigma(3);
        sigma_4(step_random_seed, step_number_of_clusters) = lssvr_model.sigma(4);

        regularization_parameter_1(step_random_seed, step_number_of_clusters) = lssvr_model.regularization_parameter(1);
        regularization_parameter_2(step_random_seed, step_number_of_clusters) = lssvr_model.regularization_parameter(2);
        regularization_parameter_3(step_random_seed, step_number_of_clusters) = lssvr_model.regularization_parameter(3);
        regularization_parameter_4(step_random_seed, step_number_of_clusters) = lssvr_model.regularization_parameter(4);




        clc
        [step_number_of_clusters step_random_seed]
        r_squared'
        [mean(r_squared_1(1:step_random_seed,step_number_of_clusters), 1) ...
        mean(r_squared_2(1:step_random_seed,step_number_of_clusters), 1) ...
        mean(r_squared_3(1:step_random_seed,step_number_of_clusters), 1) ...
        mean(r_squared_4(1:step_random_seed,step_number_of_clusters), 1)]

        mean(r_squared_1, 1)
        mean(r_squared_2, 1)
        mean(r_squared_3, 1)
        mean(r_squared_4, 1)
    end
    save results/lssvr_r_squared_1.dat r_squared_1 -ascii
    save results/lssvr_r_squared_2.dat r_squared_2 -ascii
    save results/lssvr_r_squared_3.dat r_squared_3 -ascii
    save results/lssvr_r_squared_4.dat r_squared_4 -ascii

    save results/lssvr_sigma_1.dat sigma_1 -ascii
    save results/lssvr_sigma_2.dat sigma_2 -ascii
    save results/lssvr_sigma_3.dat sigma_3 -ascii
    save results/lssvr_sigma_4.dat sigma_4 -ascii

    save results/lssvr_regularization_parameter_1.dat regularization_parameter_1 -ascii
    save results/lssvr_regularization_parameter_2.dat regularization_parameter_2 -ascii
    save results/lssvr_regularization_parameter_3.dat regularization_parameter_3 -ascii
    save results/lssvr_regularization_parameter_4.dat regularization_parameter_4 -ascii
end


clc
disp('Mean')
mean(r_squared_1, 1)
mean(r_squared_2, 1)
mean(r_squared_3, 1)
mean(r_squared_4, 1)

disp('Std')
std(r_squared_1)
std(r_squared_2)
std(r_squared_3)
std(r_squared_4)

disp('Max')
max(r_squared_1, [], 1)
max(r_squared_2, [], 1)
max(r_squared_3, [], 1)
max(r_squared_4, [], 1)


