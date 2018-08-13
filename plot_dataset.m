function plot_dataset(data)
%% Plot dataset
%
%  INPUT:
%      data : Cell array of shapes
%
%  SEE ALSO:
%      create_shape_dataset
%
%  Author:
%      Andrew Buck (8/13/2018)
%%

addpath tight_subplot

% Loop over the first 40 examples
figure();
ha = tight_subplot(5,8,0,0,0);
for i = 1:min(40, length(data))
    
    % Plot the 3D image
    axes(ha(i));
    set(gca, 'visible', 'off');
    plot_3d_image(data{i});
    
end
    