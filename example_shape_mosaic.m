%% EXAMPLE_SHAPE_MOSAIC
%
% This example creates a mosaic of example 3D shapes using random parameter
% configurations.

%%

addpath tight_subplot

% Define the list of shape types
shapeTypes = {'ellipsoid', 'cuboid', 'cylinder', 'cone', 'torus'};

% Prepare a cell array to hold the shapes
V_all = cell(40,1);

% Loop over 40 examples
figure();
ha = tight_subplot(5,8,0,0,0);
for i = 1:40
    
    % Create the default parameters
    params = default_voxel_params();
    
    % Assign random parameter values 
    params.s_vec = rand(1,3) + 0.5;
    params.t_vec = rand(1,3)*2 - 1;
    params.r_vec = sample_weights(1, 3);
    params.r_ang = rand()*360;
    params.sharpness = rand()*10;
    shapeName = shapeTypes{randi(5)};
    noiseWeight = rand()*0.75;
    
    % Create the 3D shape
    V_shape = create_3d_shape(shapeName, params);
    
    % Create the noise
    V_noise = create_3d_noise(params);
    
    % Blend the shape and the noise
    V = noiseWeight*V_noise + (1-noiseWeight)*V_shape;
    
    % Save the data
    V_all{i} = V;
    
    % Plot the 3D image
    axes(ha(i));
    set(gca, 'visible', 'off');
    plot_3d_image(V, params);
    
end
    