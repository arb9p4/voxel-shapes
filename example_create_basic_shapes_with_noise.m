%% EXAMPLE_CREATE_BASIC_SHAPES_WITH_NOISE
%
% This example shows how to create and plot basic 3D voxel shapes with
% value noise.

%%

% Define the default parameters
params = default_voxel_params();

% Define the list of shape types
shapeTypes = {'ellipsoid', 'cuboid', 'cylinder', 'cone', 'torus'};

% Set the noise strength
noiseWeight = 0.5;

% Loop over each type
for i = 1:length(shapeTypes)
   
    % Create the 3D shape
    V_shape = create_3d_shape(shapeTypes{i}, params);
    
    % Create the noise
    V_noise = create_3d_noise(params);
    
    % Blend the shape and the noise
    V = noiseWeight*V_noise + (1-noiseWeight)*V_shape;
    
    % Plot the 3D image
    figure; plot_3d_image(V, params);
    
end
