load ../interpolatedFullDataInStruct.mat;
load bodyReferenceThroughCenterMass;
trajectoriesArray=normalizeTrajectories(trajectory,bodyReference,0);

for i=1:54
    
    tStart=data(i).tInteractionStart;
    tEnd=data(i).tInteractionStop;
    t=trajectoriesArray{1,i};
    v=trajectoriesArray{2,i};
    
    t=t(tStart:tEnd,:);
    v=v(tStart:tEnd,:);
    trajectoriesArray{1,i}=t;
    trajectoriesArray{2,i}=v;
end
    