%Author : Mamagiannos Dimitrios
%Date : June 2015

function y = myedge( x,type,thr )
%Line detection using sobel or prewitt or log mask
%x : Input image
%type : method of line detection
%thr : threshold for decide if one pixel belongs to a line

if strcmp(type,'prewitt')
    h=[1 1 1;0 0 0;-1 -1 -1];
    y=conv2(x,h);
elseif strcmp(type,'sobel')
    h=[1 2 1;0 0 0;-1 -2 -1];
    y=conv2(x,h);
elseif strcmp(type,'log')
    h=[0 0 -1 0 0;0 -1 -2 -1 0;-1 -2 16 -2 -1;0 -1 -2 -1 0;0 0 -1 0 0];
    y=conv2(x,h);
else
    display('Wrong method')
    
end

%Threshold
for i=1:size(x,1)
    for j=1:size(x,2)
        if(y(i,j)<thr)
            y(i,j)=0;
        else
            y(i,j)=1;
        end
    end
end

end
