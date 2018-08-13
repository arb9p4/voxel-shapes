function shapes = create_shape_dataset(params)
%% CREATE_SHAPE_DATASET Creates a dataset of 3D shapes.
%
%  INPUT:
%      params : Data structure defining the parameters of the dataset.
%               See default_voxel_params().
%
%  OUTPUT:
%      shapes : Struct with a cell array of shapes for each defined shape
%               type. 
%
%  SEE ALSO:
%      default_voxel_params, plot_dataset
%
%  Author:
%      Andrew Buck (8/13/2018)
%%

% Get default parameter values for any missing fields
if ~exist('params', 'var')
    params = [];
end

% Get default values for any missing fields
params = default_voxel_params(params);

% Prepare a cell array to hold the shapes
shapes_cell = cell(params.num_samples, length(params.shape_types));

for j = 1:length(params.shape_types)
    
    shapeName = params.shape_types{j};

    for i = 1:params.num_samples

        disp(['Creating ' shapeName ' ' num2str(i) ' of ' num2str(params.num_samples)]);

        % Reset the default parameters
        p = params;

        % Assign random parameter values
        p.s_vec = rand(1, 3) * range(params.s_range) + min(params.s_range);
        p.t_vec = rand(1, 3) * range(params.t_range) + min(params.t_range);
        if strcmpi(params.r_method, 'random')
            p.r_vec = sample_weights(1, 3);
            p.r_ang = rand()*360;
        end
        p.sharpness = rand() * range(params.sharpness_range) + min(params.sharpness_range);
        R = rand() * range(params.torus_R_range) + min(params.torus_R_range);
        r = rand() * range(params.torus_r_range) + min(params.torus_r_range);
        p.torus_R = max(R, r);
        p.torus_r = min(R, r);
        noiseWeight = rand() * range(params.noise_range) + min(params.noise_range);

        % Create the 3D shape
        V_shape = create_3d_shape(shapeName, p);

        if noiseWeight > 0
            
            % Create the noise
            V_noise = create_3d_noise(params);

            % Blend the shape and the noise
            V = noiseWeight*V_noise + (1-noiseWeight)*V_shape;
            
        else
            
            % Just use the clean shape
            V = V_shape;
            
        end
        
        % Save the data
        shapes_cell{i, j} = V;
        
    end
    
end

% Convert to structure array
shapes = [];
for i = 1:length(params.shape_types)
    shapes.(params.shape_types{i}) = shapes_cell(:,i);
end
