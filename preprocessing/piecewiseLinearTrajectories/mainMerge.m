
% given trajectory find it's last detection.


% for every frame, calculate cumulative number of trajectories starting at
% it.

load d_dGroup;
load trajectories;

framesFolder='/host/Users/ibogun2010/datasets/Gupta/frames/c01/';
images=dir(framesFolder);
images=images(3:end);

for i=1:length(images)
    imNames{i}=strcat(framesFolder,images(i).name); %#ok<SAGROW>
end


n=length(trajectory);

cumTrajectoryStart=zeros(69,1);

for i=1:n
    t=trajectory(i).center;
    idx=find(t(:,1),1,'first');
   cumTrajectoryStart(idx)=cumTrajectoryStart(idx)+1; 
end

cumTrajectoryStart=cumsum(cumTrajectoryStart);


% trajectory #1
i=1;

t=trajectory(i).center;
first=find(t(:,1),1,'last');

maxSimilary=0;
for j=cumTrajectoryStart(first-1):cumTrajectoryStart(first+10)
    
    s=trajectorySimilarity(t,trajectory(j).center,imNames);
    fprintf('Similarity for the trajectory %d is %f \n',j,s);
    if (s>maxSimilary)
        maxSimilary=s;
        bestMatch=j;
    end
    
end
fprintf('Similarity for the trajectory %d is %d \n',i,bestMatch);