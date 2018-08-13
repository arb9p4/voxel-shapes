%% EXAMPLE_CREATE_SHAPE_DATASET
%
% This example shows how to create and plot a dataset of 3D voxel shapes.

%%

% Define the default parameters
params = default_voxel_params();

% Create the dataset
shapes = create_shape_dataset(params);

% Plot the different shape types
for i = 1:length(params.shape_types)
    plot_dataset(shapes.(params.shape_types{i}));
end
