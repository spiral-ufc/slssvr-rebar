classdef ParticleSwarmOptimization
    %
    % Help of PSO
    %

    % Hyperparameters
    properties
        fitnessFunction = @sum
        fitness_function_input
        fitness_function_output
        population_size = 50
        particle_size = 2
        number_of_epochs = 10
        random_seed = 102
        inicial_inertia_weight = 0.8
        final_inertia_weight = 0.2
        cognitive_acceleration = 2
        social_acceleration = 1
    end
    % Parameters
    properties (GetAccess = public, SetAccess = protected)
        particle_position = []
        particle_fitness = []
        best_particle_position = []
        best_particle_fitness = []
        best_global_position = []
        best_global_position_round = []
        best_global_fitness = []
        particle_velocity = []
        best_fitness_round = []
        best_fitness_round_index = []
        inertia_weight = []
    end
    %%
    methods
        % Constructor
        function self = ParticleSwarmOptimization()
            % Set the hyperparameters after initializing
        end
        % Initialization of protected parameters
        function self = init(self)
            % disp('PSO - Initializing')
            rng(self.random_seed,'twister')
            self.particle_position = ...
                rand(self.population_size,self.particle_size);
            self.best_particle_position = self.particle_position;
            self.particle_velocity = zeros(size(self.particle_position));
            self.inertia_weight = self.inicial_inertia_weight;
            self.particle_fitness = Inf(self.population_size,1);
            for index_particle = 1:self.population_size
                self.particle_fitness(index_particle) = ...
                    self.fitnessFunction(self.particle_position(index_particle,:));
                %self.particle_position(index_particle,:)
                %self.particle_fitness(index_particle)
            end
            self.best_particle_fitness = self.particle_fitness;
            self.best_fitness_round = Inf(self.number_of_epochs+1,1);
            [best_fitness_round_0, best_fitness_round_index_0] = min(self.particle_fitness);
            self.best_global_fitness = best_fitness_round_0;
            self.best_fitness_round(1) = best_fitness_round_0; 
            self.best_global_position = self.particle_position(best_fitness_round_index_0,:);
            self.best_global_position_round = ones(self.number_of_epochs+1, self.particle_size);
            self.best_global_position_round(1,:) = self.best_global_position;
            % disp('PSO - Finished Initialization')
        end
        
        function self = run(self)
                self = self.init();
                % disp('Starting PSO rounds') 
                % h = waitbar(0,'Please wait...');
                % s = clock;
            for epoch = 1:self.number_of_epochs
                % epoch
                % tic
                rng(self.random_seed * self.number_of_epochs + epoch)
                random_values = rand(self.population_size,2);
                for index_particle = 1:self.population_size
                    %%
                    delta_cognitive_velocity = self.cognitive_acceleration * random_values(index_particle, 1)...
                        * (self.best_particle_position(index_particle, :) - self.particle_position(index_particle, :));
                    delta_social_velocity = self.social_acceleration * random_values(index_particle, 2)...
                        * (self.best_global_position - self.particle_position(index_particle, :));
                    %%
                    self.particle_velocity(index_particle, :) = self.inertia_weight * self.particle_velocity(index_particle, :)...
                        + delta_cognitive_velocity + delta_social_velocity;
                    self.particle_position(index_particle, :) = self.particle_position(index_particle, :) + self.particle_velocity(index_particle, :);
                    % self.particle_position(index_particle, :) = min(max(self.particle_position(index_particle, :), 0), 1);
                    max_min_check = self.particle_position(index_particle, :) > 1 |self.particle_position(index_particle, :) < 0;
                    self.particle_position(index_particle, max_min_check) = self.best_global_position(max_min_check);
                    %%
                    self.particle_fitness(index_particle) = ...
                        self.fitnessFunction(self.particle_position(index_particle,:));
                    if self.best_particle_fitness(index_particle) > self.particle_fitness(index_particle)
                        self.best_particle_fitness(index_particle) = self.particle_fitness(index_particle);
                        self.best_particle_position(index_particle, :) = self.particle_position(index_particle, :);
                    end
                end 
                [self.best_fitness_round(epoch+1), self.best_fitness_round_index] = min(self.particle_fitness);
                if self.best_global_fitness > self.best_fitness_round(epoch+1)
                        self.best_global_fitness = self.best_fitness_round(epoch+1);
                        self.best_global_position = self.particle_position(self.best_fitness_round_index,:);
                end
                self.best_global_position_round(epoch+1,:) = self.best_global_position;
                %%
                self.inertia_weight = self.final_inertia_weight + (self.inicial_inertia_weight - self.final_inertia_weight)...
                    *(self.number_of_epochs - epoch)/(self.number_of_epochs - 1);
                %%
                % if epoch == 1
                %   is = etime(clock,s);
                %   esttime = is * self.number_of_epochs;
                % end
                % gravstr = sprintf('Epoch = %d/%d - Remaining time = ', epoch, self.number_of_epochs);
                % waitbar(epoch/self.number_of_epochs,h, [gravstr, num2str(esttime-etime(clock,s), '%4.1f'),' s' ]);
                 % toc
            end
            % close(h)
        end
    end
end