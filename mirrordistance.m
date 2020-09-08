function out = mirrordistance()
    out=[];
    
    %define conditions
    distfromtel=0:1:2000;
    distfromtel(2,:)=0;
    
    specs=cell(9,2);

    
    %recreate optic setup
    specs{3,1}='s';
    specs{3,2}=500;
    specs{4,1}='t';
    specs{4,2}=-1000;
    specs{5,1}='s';
    specs{5,2}=2000;
    specs{6,1}='t';
    specs{6,2}=3000;
    specs{7,1}='s';
    specs{7,2}=31000;
    specs{8,1}='t';
    specs{8,2}=13500;
    specs{9,1}='s';
    specs{9,2}=13500;
        values=[0;10*10^-6];
        dev=30.15*10^-3;
        for x=4:size(specs,1)
            if x==4
                mat=[1 0;-1/specs{x,2} 1];
            elseif specs{(x),1}==('s')
                mat=[1,specs{x,2};0,1]*mat;
            elseif specs{x,1}==('m')
                if (20-x)==2
                    values(2)=values(2)+specs{x,2};
                end
            elseif specs{x,1}==('t')
                mat=[1,0;-1/specs{x,2},1]*mat;
            elseif specs{x,1}==('c')
                mat=[1,0;-1/(specs{x,2}(2)),1]*mat;
            end    
        end
        for d=distfromtel(1,:)
            t=dev/(mat(1,1)*d+mat(1,2));
            xf=dev*(mat(2,1)*d+mat(2,2))/(mat(1,1)*d+mat(1,2));
            distfromtel(2,d+1)=abs(xf-t);
        end
    fig=figure;
    plot(distfromtel(1,:),distfromtel(2,:));
    xlabel('Initial distance from telescope (mm)');
    ylabel('Angle Change (rad)');
end

