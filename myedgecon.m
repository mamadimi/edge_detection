%Author : Mamagiannos Dimitrios
%Date : June 2015

function y = myedgecon( x,type,thr,Tnorm,Targ,r )
%Line detection using sobel or prewitt mask. Line connection using local
%search
%x : Input image
%type : method of line detection
%thr : threshold for decide if one pixel belongs to a line
%Tnorm :norm threshold
%Targ : angle threshold
%r : searchinf radius

%Image Im (Im= conv2(x,h))
%Find edges
if strcmp(type,'prewitt')
    h=[1 1 1;0 0 0;-1 -1 -1];
    Im=conv2(x,h);
elseif strcmp(type,'sobel')
    h=[1 2 1;0 0 0;-1 -2 -1];
    Im=conv2(x,h);
else
    display('Wrong method')
    
end

%Threshold
for i=1:size(Im,1)
    for j=1:size(Im,2)
        if(Im(i,j)<thr)
            Im(i,j)=0;
        else
            Im(i,j)=1;
        end
    end
end

%% Gradient
[Gmag,Gdir] = imgradient(x,type);

%% Start define lines
[M,N] =size(Im);

y=zeros(M,N);

for i=1:M
    for j=1:N
        if (Im(i,j)==1 )
            y(i,j) =1;
            %for each pixel find the neighbourhood
            for k=-r:r
                for l=-r:r
                    try
                        if(abs(Gmag(i,j) - Gmag(i+k,j+l))<Tnorm && abs (Gdir(i,j)-Gdir(i+k,j+l)) <Targ && k+i<M && j+l<N)
                            y(i+k,j+l)=1;
                        end
                   end
                end
            end
        end
    end
end


end

