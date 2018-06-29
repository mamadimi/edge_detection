function I = draw(x1,y1,x2,y2,I)
    l= (y2-y1)/(x2-x1);
    b = y1-l*x1;
    flag=0;
    if l<0 && l>=-1
        %x1=-x1;
        %x2=-x2;
       % l= (y2-y1)/(x2-x1);
        %b = y1-l*x1;
        flag=1;
        x1=-x1;
        x2=-x2;
    end
    if l<-1
        flag=2;
        y1=-y1;
        y2=-y2;
    end
    l= (y2-y1)/(x2-x1);
    b = y1-l*x1;
    
    if l<=1
        if(l<0)
            [x1,y1,x2,y2]
        end
        start =min(x1,x2);
        fin= max(x1,x2);
        for x=start:fin
               y=l*x+b;
               y=round(y);
               if flag==1
                    I(-x,y)=1;
               else
                   I(x,y)=1;
               end
        end
    else
         start =min(y1,y2);
        fin= max(y1,y2);
        for y=start:fin
               x=y/l -b/l;
               x=round(x);
               if flag==2
                    I(x,-y)=1;
               else
                   I(x,y)=1;
               end
        end
    end
        
end
