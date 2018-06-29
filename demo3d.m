%Author : Mamagiannos Dimitrios
%Date : June 2015

load('illinois.mat');
illinois = I;
load('shapes.mat')
shapes=I;

%% Iliinois
im=myedge(illinois,'log',0.5);

%Execution time = 2min
dr=5;
da=2*pi/8;
thr=100;

C = hough( im,dr,da );

[M,N] =size(im);

[Illi,A1,B1] = houghpaint( C,dr,da,M,N,im,thr );


%% Shapes

%Execution time = 20 sec
im=myedge(shapes,'log',0.3);
dr=5;
da=2*pi/16;
thr=10;

C = hough( im,dr,da );

[M,N] =size(im);

[shps,A2,B2] = houghpaint( C,dr,da,M,N,im,thr );


figure
subplot(2,2,1); 
imshow(illinois);
title('Illinois')
subplot(2,2,2); 
imshow(Illi);
title('Illinois line sections')
subplot(2,2,3); 
imshow(shapes);
title('Shapes')
subplot(2,2,4); 
imshow(shps);
title('Shapes line sections')


