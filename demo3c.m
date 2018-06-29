%Author : Mamagiannos Dimitrios
%Date : June 2015

load('illinois.mat');

im=myedge(I,'log',0.7);

dr=10;
da=2*pi/16;
C = hough( im,dr,da );

figure
imshow(C)
title('Hough array, dr=10,da=*pi/16')
