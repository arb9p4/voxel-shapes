%% EXAMPLE_CREATE_BASIC_SHAPES
%
% This example shows how to create and plot basic 3D voxel shapes.

%%

% Define the default parameters
params = default_voxel_params();

% Create the shapes
V_ellipsoid = create_3d_shape('ellipsoid', params);
V_cuboid    = create_3d_shape('cuboid', params);
V_cylinder  = create_3d_shape('cylinder', params);
V_cone      = create_3d_shape('cone', params);
V_torus     = create_3d_shape('torus', params);

% Plot the 3D images
figure; plot_3d_image(V_ellipsoid, params);
figure; plot_3d_image(V_cuboid, params);
figure; plot_3d_image(V_cylinder, params);
figure; plot_3d_image(V_cone, params);
figure; plot_3d_image(V_torus, params);
