
trajectoriesDir='/host/Users/ibogun2010/Dropbox/Code/data/tracks/';
load('groundTruth');
list=dir(trajectoriesDir);

n=length(list)-2;
%n=1;


tNewMax=100;
tNewMin=3;

withVelocity=0;


if (withVelocity==1)
    dataMatrix=zeros(1000,(tNewMax-tNewMin+1)*4-2);
else
    dataMatrix=zeros(1000,(tNewMax-tNewMin+1)*2);
end

groundTruthExtended=zeros(1000,1);

trajectoryLimitPoints=zeros(n,1);

trajectoriesCounter=0;

% for every video
for i=3:(n+2)
    video=load(strcat(trajectoriesDir,(list(i).name)));
    video=video.track;
    
    % for every track in the video
    
    trajMax=0;
    for j=1:length(video)
        if (trajMax<length(video(j).traj))
            trajMax=length(video(j).traj);
            bestTraj=j;
        end
    end
    
    for j=1:length(video)
        
        if (j~=bestTraj)
            continue;
        end
        
        if (length(video(j).traj)<20)
            continue;
        end
        
        trajectoriesCounter=trajectoriesCounter+1;
        
        hand=video(j).traj;
        hand=smooth(hand,19);
        
        %hand=hand/norm(hand);
        
        len=length(hand);
        
        [hand,handVelocity]=preprocessTrajectory(hand,tNewMin,tNewMax,3,len);
        
        if (withVelocity)
            dataMatrix(trajectoriesCounter,:)=[hand,handVelocity];
        else
            dataMatrix(trajectoriesCounter,:)=hand;
        end   
        groundTruthExtended(trajectoriesCounter)=groundTruth(i-2);
    end
    
    trajectoryLimitPoints(i-2)=trajectoriesCounter;
end
dataMatrix=dataMatrix(1:trajectoriesCounter,:);
dataMatrix=dataMatrix';
groundTruthExtended=groundTruthExtended(1:trajectoriesCounter);
groundTruthExtended=groundTruthExtended';

clearvars -except dataMatrix groundTruthExtended groundTruth trajectoryLimitPoints;
[a,b,c]=SSC(dataMatrix,groundTruthExtended,6,0,0.1);
display(b);
display(c);