

% images will be saved to source/frames/...
source='/host/Users/ibogun2010/datasets/Gupta/frames';




vidlist=dir(source);

vidlist=vidlist(3:end);


for i=43:length(vidlist)
    
    fprintf('video %i out of %i \n',i,length(vidlist));
    
    optFlow=struct('forward',[],'backward',[]);
    %optFlow=repmat(optFlow,length(vidlist),1);
    
    
    
    vidName=strcat(source,'/',vidlist(i).name);
    framelist=dir(vidName);
    framelist=framelist(3:end);
    
    forwardFlow=struct('flow',[]);
    forwardFlow=repmat(forwardFlow,length(framelist)-1,1);
    
    backwardFlow=struct('flow',[]);
    backwardFlow=repmat(backwardFlow,length(framelist)-1,1);
    
    for j=1:length(framelist)-1
        
        fprintf('frame %i out of %i \n',j,length(framelist)-1);
        
        frame1=strcat(source,'/',vidlist(i).name,'/',framelist(j).name);
        frame2=strcat(source,'/',vidlist(i).name,'/',framelist(j+1).name);
        
        im1=double(imread(frame1));
        im2=double(imread(frame2));
        
        
        forward=mex_LDOF(im1,im2);
        backward=mex_LDOF(im2,im1);
        
        
        forwardFlow(j).flow=forward;
        backwardFlow(j).flow=backward;
        
    end
    
    optFlow.forward=forwardFlow;
    optFlow.backward=backwardFlow;
    if (i<10)
        savefile=strcat('0',num2str(i));
    else
        savefile=num2str(i);
    end
    
    save(savefile,'optFlow');
end