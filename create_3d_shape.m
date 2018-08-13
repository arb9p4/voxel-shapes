function V = create_3d_shape(shapename, params)
%% CREATE_3D_SHAPE Creates a 3D voxel image of a basic shape.
%
%  INPUT:
%      shapename: Name of the shape to create. Options are 'ellipsoid',
%                 'cuboid', 'cylinder', 'cone', or 'torus'.
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

% Get default values for any missing fields
if ~exist('params', 'var')
    params = [];
end
params = default_voxel_params(params);

% Create the voxel coordinate grids
[X, Y, Z] = meshgrid(params.Vx, params.Vy, params.Vz);
P0 = [X(:), Y(:), Z(:)];
P0 = [P0, ones(size(P0,1),1)]';

% Normalize the rotation axis
R = [params.r_vec(1); params.r_vec(2); params.r_vec(3)];
R = R + eps;    % Make sure the vector is non-zero
R = R ./ sqrt(sum(R.^2));
rx = R(1);
ry = R(2);
rz = R(3);

% Get the sine and cosine of the rotation angle
sa = sin(-params.r_ang * pi/180);
ca = cos(-params.r_ang * pi/180);

% Construct the rotation matrix
Tr = [ca+rx^2*(1-ca),     rx*ry*(1-ca)-rz*sa, rx*rz*(1-ca)+ry*sa, 0;
      ry*rx*(1-ca)+rz*sa, ca+ry^2*(1-ca),     ry*rz*(1-ca)-rx*sa, 0;
      rz*rx*(1-ca)-ry*sa, rz*ry*(1-ca)+rx*sa, ca+rz^2*(1-ca),     0;
      0,                  0,                  0,                  1];

% Construct the scaling matrix
Ts = [1/params.s_vec(1), 0,                 0,                 0;
      0,                 1/params.s_vec(2), 0,                 0;
      0,                 0,                 1/params.s_vec(3), 0;
      0,                 0,                 0,                 1];
  
% Construct the translation matrix
Tt = [1, 0, 0, -params.t_vec(1);
      0, 1, 0, -params.t_vec(2);
      0, 0, 1, -params.t_vec(3);
      0, 0, 0, 1              ];

% Apply the transformation
P1 = Ts*Tr*Tt*P0;

% Reshape coordinate matrices into 3D
Xt = reshape(P1(1,:), size(X));
Yt = reshape(P1(2,:), size(Y));
Zt = reshape(P1(3,:), size(Z));

% Define the distance map based on the shape type
if strcmp(shapename, 'ellipsoid')
    D = sqrt(Xt.^2 + Yt.^2 + Zt.^2);
elseif strcmp(shapename, 'cuboid')
    D = max(cat(4, abs(Xt), abs(Yt), abs(Zt)), [], 4);
elseif strcmp(shapename, 'cylinder')
    Dr = sqrt(Xt.^2 + Yt.^2);
    Da = abs(Zt);
    D = max(Dr, Da);
elseif strcmp(shapename, 'cone')
    Dr = sqrt(Xt.^2 + Yt.^2) ./ ((1+Zt)/2);
    Da = abs(Zt);
    Da(Zt < -1) = inf;
    D = max(Dr, Da);
elseif strcmp(shapename, 'torus')
    Dr = abs(sqrt(Xt.^2 + Yt.^2) - params.torus_R);
    D = sqrt(Dr.^2 + Zt.^2) ./ params.torus_r;
else
    error('Invalid shape type. Options are ''ellipsoid'', ''cuboid'', ''cylinder'', ''cone'', or ''torus''.');
end

% Create the volume density map from the sharpness parameter
V = 1 - 1 ./ (1 + exp(-params.sharpness .* (D-1)));
