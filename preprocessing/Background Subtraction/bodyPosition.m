bodyFolder='/host/Users/ibogun2010/datasets/Gupta/detections/upper body detections/';
bodyFiles=dir(bodyFolder);
bodyFiles=bodyFiles(3:end);

% for every video
n=480;
m=640;

for v=1:length(bodyFiles)
    vidFolder=strcat(bodyFolder,bodyFiles(v).name);
    files=dir(vidFolder);
    files=files(3:end);
    
    
    % for every frame
    %for j=1:length(files)
    
    
    fprintf('Current video: %d \n',v);
    
    
    % get the count of the detections for every video
    %
    c=0;
    boxes=cell(1000,1);
    
    
    for j=1:length(files)
        
        file=load(strcat(vidFolder,'/',files(j).name));
        BB=file.BB;
        for k=1:size(BB,1)
            c=c+1;
            bb=BB(k,1:4);
            
            if (bb(1)<1)
                bb(1)=1;
            end
            
            if (bb(2)<1)
                bb(2)=1;
            end
            
            if (bb(3)>n)
                bb(3)=n;
            end
            
            if (bb(4)>m)
                bb(4)=m;
            end
            
            boxes{c}=bb;
            
        end
        
    end
    
    
    boxes=boxes(1:c);
    %
    
    labelMap=struct('count',[],'labels',[]);
    labelMap.count=0;
    labelMap=repmat(labelMap,c,1);
    label=1;
    isLabeled=0;
    
    
    % 60% of the area overlap
    threshold=0.6;
    
    for i=1:c
        %fprintf('Current detection %d \n',i);
        l1=boxes{i};
        l1=[l1(1) l1(2) l1(3)-l1(1) l1(4)-l1(2)];
        
        labelMap(i).labels=[i];
        
        for j=1:c
            
            if (i==j)
                continue;
            end
            
            l2=boxes{j};
            l2=[l2(1) l2(2) l2(3)-l2(1) l2(4)-l2(2)];
            
            overlap=rectint(l1,l2);
            
            measure= overlap/(l1(3)*l1(4)+l2(3)*l2(4)-overlap);
            
            if (measure>=threshold)
                labelMap(i).count=labelMap(i).count+1;
                labelMap(j).count=labelMap(j).count+1;
                
                labelMap(i).labels=[labelMap(i).labels j];
                labelMap(j).labels=[labelMap(j).labels i];
            end
            
        end
        
    end
    
    
    f=@(x) x.count;
    a=arrayfun(f,labelMap);
    [~,idx]=max(a);
    
    average=@(x) [(x(1)+x(3))/2, (x(2)+x(4))/2];
    
    indices=labelMap(idx).labels;
    
    bodyCenter=[0,0];
    
    for i=1:length(indices)
        
        bodyCenter=bodyCenter+average(boxes{indices(i)});
        
    end
    
    bodyCenter=bodyCenter/length(indices);
    bodyReference(v,:)=bodyCenter;
end

save('bodyReference','bodyReference');







