function [removed_samples_vector] = ald_selection(X,HP)

% Get size
[~,N] = size(X);

% Get hyperparameters
sigma = HP.sigma; % sigma of gaussian kernel
iterations = HP.it;
sig2n = HP.regularization_parameter;
kernel_type = HP.kernel_type;

% Init Output
removed_samples_vector = zeros(1,iterations);

if(iterations >= N)
    disp("number of iterations is not smaller than number of samples");
else
    
    % Init variables
    Xaux = X;
    vet_indexes = 1:N;
    Km = calc_kernel_matrix(Xaux, kernel_type);
    Kinv = pinv(Km);

    for it = 1:iterations
        disp(it);
        m = N-it+1;
        ald_values = zeros(1,m);
        for index = 1:m
            % Get sample and reduced samples matrix
            xt = Xaux(:,index);
            Xred = Xaux;
            Xred(:,index) = [];
            % Get reduced inverse kernel matrix
            ep = zeros(m,1);
            ep(index) = 1;
            u = Km(:,index) - ep;
            %
            eq = zeros(m,1);
            eq(index) = 1;
            v = eq;
            %
            Kinv_red = Kinv + (Kinv * u)*(v' * Kinv) / (1 - v' * Kinv * u);
            Kinv_red(index,:) = [];
            Kinv_red(:,index) = [];
            % calculate ald
            switch kernel_type
                case {'rbf','RBF'}
                    ktt = exp(-norm(xt-xt)^2/(sigma^2));
                case {'linear','LINEAR'}
                    ktt = xt'*xt;
            end
            kt = calc_kernel_vector(Xred, xt, kernel_type);
            at = Kinv_red*kt;
            ald_values(index) = ktt - kt'*at + sig2n;
        end
        % Get index with minimum ald
        [~,min_ald_index] = min(ald_values);
        % Update output
        removed_samples_vector(it) = vet_indexes(min_ald_index);
        % Update samples matrix and indexes vector
        Xaux(:,min_ald_index) = [];
        vet_indexes(min_ald_index) = [];
        % Update Kernel matrix and its inverse
        ep = zeros(m,1);
        ep(min_ald_index) = 1;
        u = Km(:,min_ald_index) - ep;
        eq = zeros(m,1);
        eq(min_ald_index) = 1;
        v = eq;
        Kinv = Kinv + (Kinv * u)*(v' * Kinv) / (1 - v' * Kinv * u);
        Kinv(min_ald_index,:) = [];
        Kinv(:,min_ald_index) = [];
        Km(min_ald_index,:) = [];
        Km(:,min_ald_index) = [];
    end
end

%%%%%% KERNEL FUNCTION MATRIX
function kernel_matrix = calc_kernel_matrix(Dx,kernel_type)

    kernel_matrix = zeros(N,N);
    switch kernel_type
            case {'rbf','RBF'}
                for i = 1:N
                    for j = i:N
                        kernel_matrix(i,j) = exp(-norm(Dx(:,i)-Dx(:,j))^2/(sigma^2));
      	                kernel_matrix(j,i) = kernel_matrix(i,j);
                    end
                end
                kernel_matrix = kernel_matrix + sig2n*eye(N,N);
              
            case {'linear','LINEAR'}
                for i = 1:N
                    for j = i:N
                        kernel_matrix(i,j) = Dx(:,i)'*Dx(:,j);
      	                kernel_matrix(j,i) = kernel_matrix(i,j);
                    end
                end
                kernel_matrix = kernel_matrix + sig2n*eye(N,N);
    end

end

%%%%%% KERNEL FUNCTION VECTOR
function kernel_vector = calc_kernel_vector(Dx,xt,kernel_type)
    [~,n] = size(Dx);
    kernel_vector = zeros(n,1);
    switch kernel_type
            case {'rbf','RBF'}
                for i = 1:n
                    kernel_vector(i) = exp(-norm(Dx(:,i)-xt)^2/(sigma^2));
                end

            case {'linear','LINEAR'}
                for i = 1:n
                    kernel_vector(i) = Dx(:,i)'*xt;
                end
    end
end

%%%%%% 

end
























