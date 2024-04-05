classdef LocalLSSVRModel
    properties
        output_number
        number_of_clusters
        idx_clusters
        clusters
        clusters_count
        model_partition
        regularization_parameter =1e-3
        clusterMethod = @kmeans %kmedoids kmeans
        bias
        type = 'local'

        number_of_operations
    end

    methods
        function self = LocalLSSVRModel()
            % Constructor
        end

        function self = fit(self, input, output, sigma, regularization_parameter, bias, number_of_clusters)
            self.bias = bias;
            self.number_of_clusters = number_of_clusters;
            % [~, simples_number] = size(input);
            % [input_number, ~] = size(input);
            [self.output_number, ~] = size(output);

            self.idx_clusters = [];
            self.clusters = [];
            self.clusters_count = zeros(number_of_clusters,1);

            for step = 1:300
                [idx,clust] = self.clusterMethod(input',number_of_clusters,'Distance','sqeuclidean');
                for step2 = 1:number_of_clusters
                    self.clusters_count(step2) = sum(idx==step2);
                end
                if number_of_clusters == 1
                    self.idx_clusters = idx;
                    self.clusters = clust'; 
                    break
                else
                    if min(self.clusters_count >= 4)
                        self.idx_clusters = idx;
                        self.clusters = clust';
                        break                   
                    end
                end
            end

            for step = 1:number_of_clusters
                self.clusters_count(step) = sum(self.idx_clusters==step);
            end

            self.model_partition = cell(self.number_of_clusters, 1);
            for step = 1:self.number_of_clusters
                lssvr_model = LSSVRModel();
                lssvr_model = fit(lssvr_model, input(:, self.idx_clusters==step), output(:, self.idx_clusters==step), ...
                    sigma, regularization_parameter, self.bias);
                self.model_partition{step} = lssvr_model;
            end

        end

        function self = tuning(self, input, output, bias, number_of_clusters)
            self.bias = bias;
            self.number_of_clusters = number_of_clusters;
            % [~, simples_number] = size(input);
            % [input_number, ~] = size(input);
            [self.output_number, ~] = size(output);

            self.idx_clusters = [];
            self.clusters = [];
            self.clusters_count = zeros(number_of_clusters,1);

            for step = 1:300
                [idx,clust] = self.clusterMethod(input',number_of_clusters,'Distance','sqeuclidean');
                for step2 = 1:number_of_clusters
                    self.clusters_count(step2) = sum(idx==step2);
                end
                if number_of_clusters == 1
                    self.idx_clusters = idx;
                    self.clusters = clust'; 
                    break
                else
                    if min(self.clusters_count >= 4)
                        self.idx_clusters = idx;
                        self.clusters = clust';
                        break                   
                    end
                end
            end

            for step = 1:number_of_clusters
                self.clusters_count(step) = sum(self.idx_clusters==step);
            end

            self.model_partition = cell(self.number_of_clusters, 1);
            for step = 1:self.number_of_clusters
                lssvr_model = LSSVRModel();
                lssvr_model = tuning(lssvr_model, input(:, self.idx_clusters==step), output(:, self.idx_clusters==step), self.bias);
                self.model_partition{step} = lssvr_model;
            end

        end

        function [estimated_output, number_of_operations] = predict(self, input)
            [~, number_of_simples] = size(input);
            number_of_operations = zeros(1, number_of_simples);

            estimated_output = zeros(self.output_number, number_of_simples);

            for step_1 = 1:number_of_simples
                distance_of_clusters = zeros(self.number_of_clusters, 1);
                for step_2 = 1:self.number_of_clusters
                    distance_of_clusters(step_2) = sqrt((input(:,step_1) - self.clusters(:,step_2))'*...
                                                    (input(:,step_1) - self.clusters(:,step_2)));
                end

                if(strcmp(self.type,'local'))
                    [~, idx_min] = min(distance_of_clusters);
                    number_of_operations(step_1) = size(self.model_partition{idx_min}.input,2);
                    estimated_output(:, step_1) = predict(self.model_partition{idx_min}, input(:,step_1));
                elseif (strcmp(self.type,'weighted'))
                    inv_distance_of_clusters = 1./distance_of_clusters;
                    weights = inv_distance_of_clusters/sum(inv_distance_of_clusters);
                    weights = ones(self.number_of_clusters,1)./self.number_of_clusters;
                    aux_estimated_output = zeros(self.output_number,1);
                    for step_2 = 1:self.number_of_clusters
                        aux_estimated_output = aux_estimated_output + weights(step_2) .* predict(self.model_partition{step_2}, input(:,step_1));
                    end
                    estimated_output(:, step_1) = aux_estimated_output;
                end
            end      
        end

    end

 end
        

