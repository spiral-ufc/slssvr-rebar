 classdef LSSVRModel
    properties
        input
        output
        regularization_parameter

        alpha
        b

        opt_output
        
        sigma
        
        omega

        bias = true
        training_status = 'untrained'
        hyper_search_space = [-7.5 7.5] %[log(min), log(max)]
        operation_number
    end

    methods

        function self = LSSVRModel()
        end
            
        function self = fit(self, input, output, sigma, regularization_parameter, bias)
            simples_number = size(input,2);
            self.operation_number = simples_number;
            output_number = size(output,1);
            self.input = input;
            self.output = output;
            self.bias = bias;
            r_parameter_number = size(regularization_parameter,1);
            sigma_number = size(sigma,1);

            if output_number == r_parameter_number
                self.regularization_parameter = regularization_parameter(:,1);
            else
                self.regularization_parameter = ones(output_number,1) * regularization_parameter(1,1);
            end

            if output_number == sigma_number
                self.sigma = sigma(:,1);
            else
                self.sigma = ones(output_number,1) * sigma(1,1);
            end

            self.alpha = zeros(simples_number, output_number);
            self.b = zeros(output_number, 1);
            for step = 1:output_number
                kernel_matrix = LSSVRModel.kernelMatrix(input, 'rbf', self.sigma(step)) + self.regularization_parameter(step) * eye(simples_number);
                if self.bias
                    v = kernel_matrix \ output(step,:)';
                    nu = kernel_matrix \ ones(simples_number,1);
                    s = ones(1,simples_number)*nu(:,1);
                    self.b(step) = (nu(:,1)'* output(step,:)')./s;
                    self.alpha(:, step) = v(:,1)-(nu(:,1)*self.b(step));
                else
                    self.alpha(:, step) = kernel_matrix \ output(step,:)'; 
                end
            end
            self.training_status = 'trained';
        end

        function estimated_output = predict(self, input)
            output_number = size(self.alpha,2);
            simples_number = size(input, 2);

            estimated_output = zeros(output_number,simples_number);
            for step = 1:output_number
                for step_simple = 1:simples_number
                    kernel_vector = LSSVRModel.kernelVector(input(:, step_simple), self.input, 'rbf', self.sigma(step));
                    estimated_output(step,step_simple) = self.alpha(:, step)' * kernel_vector + self.b(step);
                end
            end
            
        end

       function self = tuning(self, input, output, bias)
            simples_number = size(input,2);
            self.operation_number = simples_number;
            input_number = size(input,1);
            output_number = size(output,1);
            tuned_regularization_parameter = zeros(output_number, 1);
            tuned_sigma = zeros(output_number, 1);
            self.input = input;
            self.output = output;
            self.bias = bias;

            % X = input';
            self.omega = sum(input'.^2,2)*ones(1,simples_number);
            self.omega = self.omega + self.omega'-2*(input'*input);

            for step = 1:output_number
                self.opt_output = output(step,:);

                pso = ParticleSwarmOptimization();
                pso.random_seed = randi(1024);
                pso.particle_size = 2;
                pso.population_size = 5;
                pso.number_of_epochs = 5;
                pso.fitnessFunction = @self.evaluateHyper;
                pso = pso.run();

                % disp('Simplex - Initializing')
                options = optimset('MaxIter',100);
                simplex_result = fminsearch(@self.evaluateHyper, pso.best_global_position, options);

                tuned_regularization_parameter(step) = exp((self.hyper_search_space(2) - self.hyper_search_space(1))...
                                                        * simplex_result(1) + self.hyper_search_space(1));
                tuned_sigma(step) = exp((self.hyper_search_space(2) - self.hyper_search_space(1))...
                                     * simplex_result(2) + self.hyper_search_space(1));

            end

            self = fit(self, input, output, tuned_sigma, tuned_regularization_parameter, self.bias);

        end

        function out = evaluateHyper(self, hyper)
            simples_number = size(self.opt_output,2);
            k = 10;

            test_regularization_parameter = exp((self.hyper_search_space(2) - self.hyper_search_space(1))...
                                             * hyper(1) + self.hyper_search_space(1));
            test_sigma = exp((self.hyper_search_space(2) - self.hyper_search_space(1))...
                          * hyper(2) + self.hyper_search_space(1));

            kernel_matrix_ = exp(-self.omega./(2*test_sigma));
            kernel_matrix = kernel_matrix_ + test_regularization_parameter *eye(simples_number);
            
            
            estimated_output = zeros(1, simples_number);
            if simples_number <= k
                for step = 1:simples_number
                    index = true(simples_number,1);
                    index(step) = false;
                    dim = sum(index);

                    b_ = 0;
                    if self.bias
                        v = kernel_matrix(index, index) \ self.opt_output(:,index)';
                        nu = kernel_matrix(index, index) \ ones(dim,1);
                        s = ones(1,dim)*nu(:,1);
                        b_ = (nu(:,1)'* self.opt_output(:,index)')./s;
                        alpha_ = v(:,1)-(nu(:,1)*b_);
                    else
                        alpha_ = kernel_matrix(index, index) \ self.opt_output(:,index)';
                    end

                    estimated_output(step) = alpha_' * kernel_matrix_(index,step) + b_;
                end
            else
                fold_length = simples_number / k;
                fold_index = cell(k, 1);
                fold_end = 0;
                for i = 1:k
                  fold_start = fold_end + 1;
                  fold_end = floor(i*fold_length);
                  fold_index{i} = fold_start:fold_end;
                end
                for i = 1:k
                    aux = boolean(ones(k,1));
                    aux(i) = false;
                    index_training = reshape(horzcat(fold_index{aux}), 1, []);
                    index_test = fold_index{i};

                    dim = length(index_training);
                    b_ = 0;
                    if self.bias
                        v = kernel_matrix(index_training, index_training) \ self.opt_output(:,index_training)';
                        nu = kernel_matrix(index_training, index_training) \ ones(dim,1);
                        s = ones(1,dim)*nu(:,1);
                        b_ = (nu(:,1)'* self.opt_output(:,index_training)')./s;
                        alpha_ = v(:,1)-(nu(:,1)*b_);
                    else
                        alpha_ = kernel_matrix(index_training, index_training) \ self.opt_output(:,index_training)';
                    end

                    estimated_output(index_test) = alpha_' * kernel_matrix_(index_training,index_test) + b_;
                end
            end

            mean_square_error = RegDatasetHandler.meanSquareError(estimated_output, self.opt_output);
            r_squared = RegDatasetHandler.rSquared(estimated_output, self.opt_output);
            
            % fprintf('%.10f %.10f %f %f\n', [test_regularization_parameter test_sigma mean_square_error r_squared] )

            out = mean_square_error;
        end

    end

        methods (Static)
        function kernel_matrix = kernelMatrix(input, kernel_type, kernel_hyper)
          [~, length_input]=size(input);
          kernel_matrix = zeros(length_input);
          switch kernel_type
            case {'rbf','RBF'}
                den = 2 * kernel_hyper;
                for i = 1:length_input
                  for j = i:length_input
                    aux = input(:,i) - input(:,j);
                    kernel_matrix(i,j) = exp(-aux'*aux/den);
                    kernel_matrix(j,i) = kernel_matrix(i,j);
                  end
                end
              % case {'linear','LINEAR'}
              %   for i = 1:length_input
              %     for j = i:length_input
              %       kernel_matrix(i,j) = input(:,i)'*input(:,j);
              %       kernel_matrix(j,i) = kernel_matrix(i,j);
              %     end
              %   end
          end
        end
        
        function kernel_vector = kernelVector(new_input, input, kernel_type, kernel_hyper)
            [~, length_input]=size(input);
            kernel_vector = zeros(length_input, 1);
          switch kernel_type
            case {'rbf','RBF'}
                den = 2 * kernel_hyper;
                for i = 1:length_input
                    aux = new_input - input(:,i);
                    kernel_vector(i) = exp(-aux'*aux/den);
                end
            % case {'linear','LINEAR'}
            %     for i = 1:length_input
            %         kernel_vector(i) = new_input'*input(:,i);
            %     end
           end
        end   
    end
end




