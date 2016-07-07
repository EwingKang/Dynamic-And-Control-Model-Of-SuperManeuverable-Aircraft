data_dir_GainS = 'sim_result\x31_03_sim_GainS_MG_30s.mat';
data_dir_NDI = 'sim_result\x31_03_sim_NDI_MG_30s.mat';


close(findobj('type','figure','name','Path top-down'));
close(findobj('type','figure','name','Path longitudinal'));
close(findobj('type','figure','name','Path lateral'));
close(findobj('type','figure','name','3dpath'));

% Plot Gain S first
data_list_GainS = who('-file',data_dir_GainS);
load(data_dir_GainS);

fig_3dpath = figure('name','3dpath');
plot3(x31sim_stateX.data(:,4),x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'b'); hold on
ax_3dpath = gca;

fig_path_topdown = figure('name','Path top-down');
plot(x31sim_stateX.data(:,5),x31sim_stateX.data(:,4),'b'); hold on
ax_path_topdown = gca;

fig_path_longi = figure('name','Path longitudinal');
plot(x31sim_stateX.data(:,4),x31sim_stateX.data(:,6),'b'); hold on
ax_path_longi = gca;

fig_path_lat = figure('name','Path lateral');
plot(x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'b'); hold on
ax_path_lat = gca;

clear(data_list_GainS{:});

% Plot NDI second
data_list_NDI = who('-file',data_dir_NDI);
load(data_dir_NDI);

plot3(ax_3dpath,x31sim_stateX.data(:,4),x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'r');
grid(ax_3dpath,'on');    axis(ax_3dpath,'equal');
xlabel(ax_3dpath,'x');    ylabel(ax_3dpath,'y');    zlabel(ax_3dpath,'z');
set(ax_3dpath,'YDir','Reverse','ZDir','Reverse');
legend(ax_3dpath,'Gain Scheduling','NDI');

plot(ax_path_topdown,x31sim_stateX.data(:,5),x31sim_stateX.data(:,4),'r');
xlabel(ax_path_topdown,'y');    ylabel(ax_path_topdown,'x');
legend(ax_path_topdown,'Gain Scheduling','NDI');

plot(ax_path_longi,x31sim_stateX.data(:,4),x31sim_stateX.data(:,6),'r');
xlabel(ax_path_longi,'x');    ylabel(ax_path_longi,'z');
set(ax_path_longi,'YDir','Reverse');      axis(ax_path_longi,'equal');
legend(ax_path_longi,'Gain Scheduling','NDI');

plot(ax_path_lat,x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'r');
xlabel(ax_path_lat,'y');    ylabel(ax_path_lat,'z');
set(ax_path_lat,'YDir','Reverse');
legend(ax_path_lat,'Gain Scheduling','NDI');


clear(data_list_NDI{:});
