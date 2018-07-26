function V = create_3d_noise(params)
%% CREATE_3D_NOISE Creates 3D value noise.
%
%  INPUT:
%      params : Parameter data structure defining the resolution, scale, 
%               translation, rotation, and threshold sharpness of the
%               shape. See default_voxel_params().
%
%  OUTPUT:
%      V : 3-dimensional matrix of real-valued numbers in range [0, 1]
%          representing the 3D shape.
%
%  SEE ALSO:
%      default_voxel_params, plot_3d_image
%
%  Author:
%      Andrew Buck (7/25/2018)
%%

% Get default parameter values for any missing fields
if ~exist('params', 'var')
    params = [];
end
params = default_voxel_params(params);

% Get the dimensions of the region
nx = length(params.Vx);
ny = length(params.Vy);
nz = length(params.Vz);

% Determine the number of noise octaves required
k = ceil(log2(max([nx, ny, nz])));

% Create each octave of value noise
s = 2^k;
V = zeros(s, s, s);
for i = 1:k
    if strcmpi(params.noise_type, 'interval')
        Y = rand(2^i, 2^i, 2^i);
    elseif strcmpi(params.noise_type, 'gaussian')
        Y = randn(2^i, 2^i, 2^i);
    else
        error('Invalid noise type');
    end
    X = interp3(Y, k-i+1);
    V = V + X(1:s, 1:s, 1:s) ./ (2^i);
end

% Trim to the specified size
V = V(1:ny, 1:nx, 1:nz);
