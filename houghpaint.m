%Author : Mamagiannos Dimitrios
%Date : June 2015

function [y,A,B] = houghpaint( c,dr,da,M,N,Imdiff,thr )
%line segments detection
%c : Hough array
%dr : radius step
%da : angle theta step
%M,N : size of image
%Imdiff : Image after convolution with mask

%Thresholding hough array c
[m,n]= size(c);
for i=1:m
    for j=1:n
        if(c(i,j) > thr)
            c(i,j)=1;
        else
            c(i,j)=0;
        end
    end
end

%Detect how many active lines exist
[as,bs]=find(c==1);

siz=size(as,1);

A=zeros(1,2);

I1=zeros(M,N); %current image : draw all lines
  for k=1:siz
    i=as(k);
    j=bs(k);

    A(size(A,1),:)=[i*dr j*da];
    A=[A;[0 0] ];

    %Draw line
    if(j~=n)
                for x=1:M
                         y =i*dr/sin(j*da) -x*cos(j*da)/sin(j*da);
                         y=round(y);
                end
                    for x=1:M

                             y =i*dr/sin(j*da) -x*cos(j*da)/sin(j*da);
                             y=round(y);
                             try
                                 if (y<=N && y>0)
                                    I1(x,y)=I1(x,y)+1;
                                 end
                             end
                    end
    else
        %infinite gradient
        x=i*dr;
         for y=1:N
                try
                       I1(x,y)=I1(x,y);
                end
         end
    end        
  end
  
  %Detect possible intersections
  %Intersections are salient points
  for i=1:M
    for j=1:N
        if(I1(i,j)<2)
            I1(i,j)=0;
        else
            I1(i,j)=1;
        end
    end
  end
  
  %Compare I1,Imdiff in an area to find possible intersections 
 for i=1:M
    for j=1:N
        try
            if(I1(i,j)==1 && (Imdiff(i,j)==1 || Imdiff(i-1,j)==1 ||Imdiff(i+1,j)==1 ||Imdiff(i,j-1)==1 )||Imdiff(i,j+1)==1)
            else
                I1(i,j)=0;
            end
        end
    end
 end
 
 %Combine all the intersections to produce possible line sections. 
[ap,bp]=find(I1==1);    %coordinates of intersections

%Possible line sections have a similarity degree over than 80% with Imdiff
%(Imdiff = conv2(Image,mask))
accepted_rate =0.8; 

B=zeros(1,4); %Line sections points [ x1 y1 x2 y2]

%Combine intersection to produce line segments
for i=1:size(ap,1)-1
    for j=i+1:size(ap,1)
        % find how many points are in i,j line
        l= ( bp(i)-bp(j) ) / (ap(i) - ap(j) );
        b = bp(i) - l*ap(i);
        
        sum_high = 0;
        
        if(abs(l) == inf)
            x=ap(i);
            for y=bp(i) : sign(bp(i)-bp(j)):bp(j)
                if Imdiff(x,y) > 0
                    sum_high=sum_high+1;
                end
            end
            if sum_high/(abs(bp(i)-bp(j))) >= accepted_rate
                B(size(B,1),:) = [ap(i) bp(i) ap(j) bp(j)];
                B=[B ; [0 0 0 0]];
            end
                
        else
            if l<=1 && l>=0

             if(ap(i) < ap(j))
                start=ap(i);
                endd = ap(j);
            else
                start=ap(j);
                endd = ap(i);
            end
                
                sum_high = 0;
                for x=start:endd
                    y= l*x +b;
                    y=round(y);
                    if Imdiff(x,y) > 0
                        sum_high=sum_high+1;
                    end
                end

                if sum_high/(abs(endd-start)) >= accepted_rate
                    B(size(B,1),:) = [ap(i) bp(i) ap(j) bp(j)];
                    B=[B ; [0 0 0 0]];
                end
            elseif l>1
                
             if bp(i) < bp(j)
                start=bp(i);
                endd = bp(j);
            else
                start=bp(j);
                endd = bp(i);
            end
                sum_high = 0;
                for y=start:endd
                    x=y/l -b/l;
                    x=round(x);
                    if Imdiff(x,y) > 0
                        sum_high=sum_high+1;
                    end
                end

                if sum_high/(abs(endd-start)) >= accepted_rate
                    B(size(B,1),:) = [ap(i) bp(i) ap(j) bp(j)];
                    B=[B ; [0 0 0 0]];
                    [ap(i) bp(i) ap(j) bp(j)];
                end
            elseif l<0 && l>=-1
                l= ( bp(i)-bp(j) ) / (-ap(i) +ap(j) );
                 b = bp(i) + l*ap(i);
                    %symmetria
                 if(-ap(i) < -ap(j))
                    start=-ap(j);
                    endd = -ap(i);
                else
                    start=-ap(i);
                    endd = -ap(j);
                end

                    sum_high = 0;
                    for x=start:endd
                        y= l*x +b;
                        y=round(y);
                        if Imdiff(-x,y) > 0
                            sum_high=sum_high+1;
                        end
                    end

                    if sum_high/(abs(endd-start)) >= accepted_rate
                        B(size(B,1),:) = [ap(i) bp(i) ap(j) bp(j)];
                        B=[B ; [0 0 0 0]];
                    end
            elseif l<-1
                 l= ( bp(i)-bp(j) ) / (-ap(i) +ap(j) );
                 b = bp(i) + l*ap(i);
                    %symmetria
                 if(-bp(i) < -bp(j))
                    start=-bp(j);
                    endd = -bp(i);
                else
                    start=-bp(i);
                    endd = -bp(j);
                end

                    sum_high = 0;
                    for y=start:endd
                        x = y/l-b/l;
                        x=round(x);
                        if Imdiff(x,-y) > 0
                            sum_high=sum_high+1;
                        end
                    end

                    if sum_high/(abs(endd-start)) >= accepted_rate
                        B(size(B,1),:) = [ap(i) bp(i) ap(j) bp(j)];
                        B=[B ; [0 0 0 0]];
                    end
            else
                
           end
              
       end
     end
end

%Draw line segments to final image y
I_final = zeros(M,N);
for i=1:size(B,1)-1
    I_final = draw(B(i,1),B(i,2),B(i,3),B(i,4),I_final);
end

y=I_final;
 
A(size(A,1),:) =[];
B(size(B,1),:) =[];

end



