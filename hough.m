%Author : Mamagiannos Dimitrios
%Date : June 2015

function C = hough( x,dr,da )
%Calculate hough array for line detection
%x : Input image
%dr : radius step
%da : angle theta step

[m,n] = size(x);

%Initialize hough array C
C=zeros(floor(sqrt(m^2+n^2)/dr),floor(2*pi/da) );

[m_C,n_C] = size(C);

for j=1:n_C
    %For each angle
    th=(j)*da; %+0.5*da;
    for n1=1:m
        for n2=1:n
            if(x(n1,n2)==1)
                r=n1*cos(th)+n2*sin(th);
                pos= r/dr;
                if(pos>floor(pos))
                    pos=floor(pos)+1;
                else
                    pos=floor(pos);
                end
               if (pos>0)
                   try
                        C(pos+1,j) = C(pos+1,j) + 1;
                   end
               end
            end
        end
    end
end

end

