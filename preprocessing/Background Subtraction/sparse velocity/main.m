%% For every frame find max sparse energy and track both ways

debugTracking;
% this will create a cell array 'allTraj' with trajectories for every frame
% for every video

%% choose the best trajectory based on the criteria: max energy along the path

chooseBestTrajectoryFromMany;


%% Check trajectories error rate (Optional, will make a plot)
checkTrajectoryQuality;

%trajectories are ready