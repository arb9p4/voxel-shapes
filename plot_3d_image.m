function plot_3d_image(V, params)
%% PLOT_3D_IMAGE Plots a 3D voxel image.
%   This function displays the max projections along each dimension and
%   shows a 3D mesh representing the isosurfaces.
%
%  INPUT:
%      V : 3-dimensional matrix of real-valued numbers.
%      params : Parameter data structure defining the coordinates and 
%               isosurface drawing method. See default_voxel_params().
%
%  SEE ALSO:
%      create_3d_shape, create_3d_noise, default_voxel_params
%
%  Author:
%      Andrew Buck (7/25/2018)
%%

% Get the size of the voxel image
sz = size(V);

% Provide default paramters if not provided
if ~exist('params', 'var')
    params = default_voxel_params();
    params.Vx = 1:sz(2);
    params.Vy = 1:sz(1);
    params.Vz = 1:sz(3);
end

% Get the range of each dimension
xmin = min(params.Vx);
xmax = max(params.Vx);
ymin = min(params.Vy);
ymax = max(params.Vy);
zmin = min(params.Vz);
zmax = max(params.Vz);

% Get the dimensions of each voxel
dx = (xmax - xmin) / sz(2);
dy = (ymax - ymin) / sz(1);
dz = (zmax - zmin) / sz(3);

% Adjust the plot boundaries to account for voxel size
xmin = xmin - dx/2;
xmax = xmax + dx/2;
ymin = ymin - dy/2;
ymax = ymax + dy/2;
zmin = zmin - dz/2;
zmax = zmax + dz/2;

% Get max projections
projTop = squeeze(max(V, [], 3));
projSide = squeeze(max(V, [], 2))';
projBack = squeeze(max(V, [], 1))';

% Prepare the figure
cla;
set(gca, 'ZDir', 'reverse');
hold on;
xlabel('y');
ylabel('x');
zlabel('z');
axis equal;
axis tight;
view([60 20]);
% colorbar;
camlight;

% Draw the Top projection
X = [ymin ymin;
     ymax ymax];
Y = [xmin xmax;
     xmin xmax];
Z = [zmax zmax;
     zmax zmax];
surf(X, Y, Z, 'CData', projTop, 'FaceColor', 'texturemap', 'EdgeColor', 'k', 'FaceLighting', 'none');

% Draw the Side projection
X = [ymin ymax;
     ymin ymax];
Y = [xmax xmax;
     xmax xmax];
Z = [zmin zmin;
     zmax zmax];
surf(X, Y, Z, 'CData', projSide, 'FaceColor', 'texturemap', 'EdgeColor', 'k', 'FaceLighting', 'none');

% Draw the Back projection
X = [ymin ymin;
     ymin ymin];
Y = [xmin xmax;
     xmin xmax];
Z = [zmin zmin;
     zmax zmax];
surf(X, Y, Z, 'CData', projBack, 'FaceColor', 'texturemap', 'EdgeColor', 'k', 'FaceLighting', 'none');

% Return if the image is all zero
if max(V(:)) == 0
    drawnow;
    return
end

% Prepare a high-resolution version of the data to display the isosurfaces
s = 2;
[X, Y, Z] = meshgrid(params.Vx, params.Vy, params.Vz);
[Xs, Ys, Zs] = meshgrid(linspace(min(params.Vx), max(params.Vx), sz(2)*s), ...
                        linspace(min(params.Vy), max(params.Vy), sz(1)*s), ...
                        linspace(min(params.Vz), max(params.Vz), sz(3)*s));
Vs = interp3(X, Y, Z, V, Xs, Ys, Zs, 'nearest');

% Create a -inf padded border to clean up the isosurfaces
Vs0 = -inf(size(Vs));
Vs0(2:size(Vs,1)-1, 2:size(Vs,2)-1, 2:size(Vs,3)-1) = Vs(2:size(Vs,1)-1, 2:size(Vs,2)-1, 2:size(Vs,3)-1);

% Determine the appropriate thresholds
if strcmpi(params.t_method, 'otsu')
    thresholds = fliplr(multithresh(V, params.num_otsu_thresholds));
else
    Vmin = min(V(:));
    Vmax = max(V(:));
    thresholds = (Vmax - Vmin) * params.t_pcts + Vmin;
end

% Make sure the highest threshold contains at least some minimum number of voxels
if nnz(V >= thresholds(1)) < params.t_min_size
    Vsort = sort(V(V>0), 'descend');
    thresholds(1) = Vsort(params.t_min_size);
end

% Get the colormap of the threshold levels
cmap = colormap();
cmap_t = linspace(min(V(:)), max(V(:)), size(cmap,1));

for ti = 1:length(thresholds)
   
    % Find the region that is greater than this threshold
    S = Vs0 >= thresholds(ti);
    
    % Plot the isosurface
    p = patch(isosurface(Ys, Xs, Zs, S, 0.5));
    p.EdgeColor = 'none';
    
    % Set the color
    [~, ci] = min(abs(cmap_t - thresholds(ti)));
    p.FaceColor = cmap(ci,:);
    
    % Set the transparancy
    p.FaceAlpha = 0.75/2^(ti-1);

end

% Update the figure
drawnow;
