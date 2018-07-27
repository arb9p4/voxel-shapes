function params = default_voxel_params(params)
%% DEFAULT_VOXEL_PARAMS Returns a parameter structure of default values.
%  These parameters are used to create various voxel shapes with the
%  defined resolution, scale, translation, rotation, and threshold
%  sharpness. Some parameters are used to define isosurface levels for
%  visualization.
%
%  INPUT:
%      params (optional) : Partially defined parameter structure. If
%          provided, any missing values will be added with defalut values.
%
%  OUTPUT:
%      params : Parameter structure with default values
%          - Vx : Voxel coordinates in the x-dimension
%          - Vy : Voxel coordinates in the y-dimension
%          - Vz : Voxel coordinates in the z-dimension
%          - s_vec : Scale vector
%          - t_vec : Translation vector
%          - r_vec : Rotation vector (axis of rotation)
%          - r_ang : Angle of rotation in degrees (counter-clockwise)
%          - sharpness: Threshold sharpness. Higher values are more crisp.
%          - torus_R : Major radius of torus
%          - torus_r : Minor radius of torus
%          - noise_type : Type of noise {interval, gaussian}
%          - t_method : Threshold method for visualization {pct, otsu}
%          - t_pcts : Threshold percentages for visualization
%          - num_otsu_thresholds : Number of Otsu threshold levels
%          - t_min_size : Minimum size of the highest threshold level
%
%  SEE ALSO:
%      create_3d_shape, create_3d_noise, plot_3d_image
%
%  Author:
%      Andrew Buck (7/25/2018)
%%

% Create an empty parameter structure if not provided
if ~exist('params', 'var')
    params = [];
end

% Set the default coordinate values
if ~isfield(params, 'Vx')
    params.Vx = linspace(-3,3,48);
end
if ~isfield(params, 'Vy')
    params.Vy = linspace(-3,3,48);
end
if ~isfield(params, 'Vz')
    params.Vz = linspace(-3,3,48);
end

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

% Set the default noise type
if ~isfield(params, 'noise_type')
    params.noise_type = 'interval';
%     params.noise_type = 'gaussian';
end

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
