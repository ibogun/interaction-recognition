prepareDifferentSizeData;


lambda=[0.1,1,10,100,1000,10000,100000];
sigma=[0.001,0.01,0.1,1,10,100,1000,10000,100000];

lambda=1;

fid = fopen('test.txt','w');
fprintf(fid,'Gaussian best alignment kernel\n');


[a,c,b]=SSC(trajectoriesArray,groundTruth,6,0,1,...
    getKernel('gaussianAlignment',1));


tic


for i=1:length(lambda)
    for j=1:length(sigma)
        try
            [a,c,b]=SSC(trajectoriesArray,groundTruth,6,0,sigma(j),...
                getKernel('gaussianAlignment',lambda(i)));
            fprintf(fid,'sigma=%4g, lambda=%4g, miss=%g\n',...
                sigma(j),lambda(i),min(b(:)));
        catch err

        end

    end
end
toc;

fclose(fid);