

% images will be saved to source/frames/...
source='/host/Users/ibogun2010/datasets/Gupta/frames';


savefile='pairwiseOptFlow';

vidlist=dir(source);

vidlist=vidlist(3:end);




pairwiseOptFlow=struct('forward',[],'backward',[]);
pairwiseOptFlow=repmat(pairwiseOptFlow,length(vidlist),1);

i=1;

vidName=strcat(source,'/',vidlist(i).name);
framelist=dir(vidName);
framelist=framelist(3:end);

forwardFlow=struct('flow',[]);
forwardFlow=repmat(forwardFlow,length(framelist)-1,1);

backwardFlow=struct('flow',[]);
backwardFlow=repmat(backwardFlow,length(framelist)-1,1);

for j=1:length(framelist)-1
    
    display(j);
    
    frame1=strcat(source,'/',vidlist(i).name,'/',framelist(j).name);
    frame2=strcat(source,'/',vidlist(i).name,'/',framelist(j+1).name);
    
    im1=double(imread(frame1));
    im2=double(imread(frame2));
    
    tic
    forward=mex_LDOF(im1,im2);
    toc
    tic
    backward=mex_LDOF(im2,im1);
    toc
    
    forwardFlow(j).flow=forward;
    backwardFlow(j).flow=backward;
    
end

pairwiseOptFlow(i).forward=forwardFlow;
pairwiseOptFlow(i).backward=backwardFlow;

save(savefile,'pairwiseOptFlow');