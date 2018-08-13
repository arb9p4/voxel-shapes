function params = default_voxel_params(params)
%% DEFAULT_VOXEL_PARAMS Returns a parameter structure of default values.
%  These parameters are used to create various voxel shapes with the
%  desired resolution, scale, translation, rotation, and threshold
%  sharpness. Some parameters are used to define isosurface levels for
%  visualization and to create random datasets.
%
%  INPUT:
%      params (optional) : Partially defined parameter structure. If
%          provided, any missing values will be added with defalut values.
%
%  OUTPUT:
%      params : Parameter structure with default values
%        _Coordnaites_
%          - Vx : Voxel coordinates in the x-dimension
%          - Vy : Voxel coordinates in the y-dimension
%          - Vz : Voxel coordinates in the z-dimension
%        _Shape Definition_
%          - s_vec : Scale vector
%          - t_vec : Translation vector
%          - r_vec : Rotation vector (axis of rotation)
%          - r_ang : Angle of rotation in degrees (counter-clockwise)
%          - sharpness: Threshold sharpness. Higher values are more crisp.
%          - torus_R : Major radius of torus
%          - torus_r : Minor radius of torus
%        _Visualization_
%          - t_method : Threshold method for visualization {pct, otsu}
%          - t_pcts : Threshold percentages for visualization
%          - num_otsu_thresholds : Number of Otsu threshold levels
%          - t_min_size : Minimum size of the highest threshold level
%        _Dataset Generation_
%          - shape_types : Cell array of shape types to generate
%          - num_samples : Number of samples to generate
%          - s_range : Scale range
%          - t_range : Translation range
%          - r_method : Rotation method {random, fixed}
%          - sharpness_range : Sharpness range
%          - torus_R_range : Torus major radius range
%          - torus_r_range : Torus minor radius range
%          - noise_type : Type of noise {interval, gaussian}
%          - noise_range : Noise range (either single value or [min max])
%
%  SEE ALSO:
%      create_3d_shape, create_3d_noise, plot_3d_image,
%      create_shape_dataset
%
%  Author:
%      Andrew Buck (8/13/2018)
%%

%% Initialization

% Create an empty parameter structure if not provided
if ~exist('params', 'var')
    params = [];
end


%% Coordinates

% Set the default coordinate values
if ~isfield(params, 'Vx')
    params.Vx = linspace(-3, 3, 48);
end
if ~isfield(params, 'Vy')
    params.Vy = linspace(-3, 3, 48);
end
if ~isfield(params, 'Vz')
    params.Vz = linspace(-3, 3, 48);
end


%% Shape Definition

% Set the default scale vector
if ~isfield(params, 's_vec')
    params.s_vec = [1; 1; 1];
end

% Set the default translation vector
if ~isfield(params, 't_vec')
    params.t_vec = [0; 0; 0];
end

% Set the default rotation vector
if ~isfield(params, 'r_vec')
    params.r_vec = [1; 0; 0];
end

% Set the default rotation angle
if ~isfield(params, 'r_ang')
    params.r_ang = 0;
end

% Set the default threshold sharpness
if ~isfield(params, 'sharpness')
    params.sharpness = 5;
end

% Set the default torus major radius
if ~isfield(params, 'torus_R')
    params.torus_R = 1;
end

% Set the default torus minor radius
if ~isfield(params, 'torus_r')
    params.torus_r = 0.5;
end


%% Visualization

% Set the default threshold method
if ~isfield(params, 't_method')
%     params.t_method = 'pct';
    params.t_method = 'otsu';
end

% Set the default threshold percentages
if ~isfield(params, 't_pcts')
    params.t_pcts = [0.95, 0.5, 0.05];
end

% Set the default number of Otsu threshold levels
if ~isfield(params, 'num_otsu_thresholds')
    params.num_otsu_thresholds = 3;
end

% Set the default minimum size of the highest threshold level
if ~isfield(params, 't_min_size')
    params.t_min_size = 10;
end


%% Dataset Generation

% Set the types of shapes to generate
if ~isfield(params, 'shape_types')
    params.shape_types = {'ellipsoid', 'cuboid', 'cylinder', 'cone', 'torus'};
end

% Set the number of each shape to generate
if ~isfield(params, 'num_samples')
    params.num_samples = 100;
end

% Set the scale range
if ~isfield(params, 's_range')
    params.s_range = [0.5, 2];
end

% Set the translation range
if ~isfield(params, 't_range')
    params.t_range = [-1, 1];
end

% Set the rotation method
if ~isfield(params, 'r_method')
    params.r_method = 'random';
%     params.r_method = 'fixed';
end

% Set the sharpness range
if ~isfield(params, 'sharpness_range')
    params.sharpness_range = [1, 10];
end

% Set the torus major radius range
if ~isfield(params, 'torus_R_range')
    params.torus_R_range = [0.5, 1];
end

% Set the torus minor radius range
if ~isfield(params, 'torus_r_range')
    params.torus_r_range = [0.5, 1];
end

% Set the default noise type
if ~isfield(params, 'noise_type')
    params.noise_type = 'interval';
%     params.noise_type = 'gaussian';
end

% Set the noise range
if ~isfield(params, 'noise_range')
    params.noise_range = 0;
%     params.noise_range = [0, 1];
end
