%% Overlapping spatio-temporal curves
close all;
% Two 3-D curves that overlap in their spatial paths. To see spatial
% overlapping, rotate the 3-D volume to see it from the top. 
% The two trajectories intersect at a single instant (time dimension)
 load trajectories;
% This is our (pre-defined) path in space. We can add the time variation
% later. For a set of general points in space, the trajectory points can be
% created using a spline curve on a 2-D image
x = -2*pi:0.01:2*pi;
y = 10*sin(x);
 
% This is how your particle varies in time (i.e., animation). This is now a
% motion trajectory.
z1 = linspace(0,10,length(x)).^1.5;
 
% This is another particle moving along the same path (x_i,y_i)
z2 = 5+1/2*linspace(0,10,length(x)).^1.5;
 


gaussFilter = gausswin(5);
gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.

id=1;

traj=trajectory(id).trajectory;

x=traj(:,1);
y=traj(:,2);
z1=1:size(traj,1);

x = conv(x, gaussFilter,'same');
y = conv(y, gaussFilter,'same');

x=x(2:end-1);
y=y(2:end-1);

z1=2:size(traj,1)-1;



figure

subplot(1,2,1);
set(gca,'fontsize',20)
% visualize the trajectories on the spatio-temporal volume
plot3(x,y,z1,'b-', 'LineWidth', 2 );
box on, axis equal
 

id=5;

traj=trajectory(id).trajectory;

x=traj(:,1);
y=traj(:,2);


% Do the blur.
x = conv(x, gaussFilter,'same');
y = conv(y, gaussFilter,'same');
x=x(2:end-1);
y=y(2:end-1);

z1=2:size(traj,1)-1;

%figure

subplot(1,2,2);
set(gca,'fontsize',20)
% visualize the trajectories on the spatio-temporal volume
plot3(x,y,z1,'b-', 'LineWidth', 2 );
box on, axis equal



% hold on;
% plot3(x,y,z2,'r-', 'LineWidth', 2 );
% box on, axis equal
% set( gcf, 'Color', 'w' ); 


