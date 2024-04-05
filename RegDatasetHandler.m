classdef RegDatasetHandler
    % Hyperparameters
    properties (GetAccess = public, SetAccess = protected)
        input
        input_train
        input_test
        input_train_norm
        input_test_norm
        output
        output_train
        output_test
        output_train_norm
        output_test_norm
        input_min
        input_max
        input_mean
        input_std
        output_min
        output_max
        output_mean
        output_std
        percentage_for_training
        training_length
        random_seed
        normalization = 'none'
    end

    methods
        function self = RegDatasetHandler(input,output,percentage_for_training,random_seed)
            % Just need inputs, outputs and percentage for training.
            % Other hyperparameters must be set after.
            self.input = input;
            self.output = output;
            self.percentage_for_training = percentage_for_training;
            self.random_seed = random_seed;

            data_length = length(self.input(1,:));
            self.training_length = ceil(data_length * self.percentage_for_training);

            rng(random_seed,'twister')
            aux_index = randperm(data_length);
            rng shuffle

            self.input_train = self.input(:,aux_index(1:self.training_length));
            self.input_test = self.input(:,aux_index(self.training_length+1 : end));
            self.output_train = self.output(:,aux_index(1:self.training_length));
            self.output_test = self.output(:,aux_index(self.training_length+1 : end));
        end

        function self = normalize(self,normalization)

            self.normalization = normalization;
            
            self.input_max = max(self.input_train,[],2);
            self.input_min = min(self.input_train,[],2);
            self.input_mean = mean(self.input_train,2);
            self.input_std = std(self.input_train,0,2);
            self.output_max = max(self.output_train,[],2);
            self.output_min = min(self.output_train,[],2);
            self.output_mean = mean(self.output_train,2);
            self.output_std = std(self.output_train, 0, 2);

            if(strcmp(self.normalization,'none'))

            elseif(strcmp(self.normalization,'binary'))

            elseif(strcmp(self.normalization,'bipolar'))

            elseif(strcmp(self.normalization,'zscore'))
                self.input_train_norm = (self.input_train - self.input_mean) ./ self.input_std;
                self.input_test_norm = (self.input_test - self.input_mean) ./ self.input_std;
                self.output_train_norm = (self.output_train - self.output_mean) ./ self.output_std;
                self.output_test_norm = (self.output_test - self.output_mean) ./ self.output_std;

            elseif(strcmp(self.normalization,'zscore3'))

            else
                disp('Choose a correct option. Data was not normalized.');

            end
        end

        function output = denormalize(self, output_signals_norm)

            if(strcmp(self.normalization,'none'))

            elseif(strcmp(self.normalization,'binary'))

            elseif(strcmp(self.normalization,'bipolar'))

            elseif(strcmp(self.normalization,'zscore'))
                output = output_signals_norm  .* self.output_std + self.output_mean;

            elseif(strcmp(self.normalization,'zscore3'))

            else
                disp('Choose a correct option. Data was not normalized.');

            end
        end
    end

    methods (Static)
        function r_squared = rSquared(estimated_output, output)
            [output_number, ~] = size(output);
            r_squared = zeros(output_number,1);
            for step = 1:output_number
                aux_error = estimated_output(step,:) - output(step,:);
                r_squared(step) = 1 - sum(aux_error.^2) / sum((output(step,:) - mean(output(step,:))).^2);
                % figure; qqplot(output(step, :), estimated_output(step, :)); 
                % title(sprintf('Output %d', step))
                % xlabel('Real output')
                % ylabel('Estimated output')
            end
        end
        function mean_square_error = meanSquareError(estimated_output, output)
            [output_number, ~] = size(output);
            mean_square_error = zeros(output_number,1);
            for step = 1:output_number
                aux_error = estimated_output(step,:) - output(step,:);
                mean_square_error(step) = mean(aux_error.^2);
            end
        end

    end

end













