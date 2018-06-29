%Author : Mamagiannos Dimitrios
%Date : June 2015

load('shapes.mat')

Im1=myedge(I,'prewitt',0.05);

Im2=myedge(I,'sobel',0.2);

Im3=myedge(I,'log',0.5);

figure
subplot(2,2,1); 
imshow(I);
title('Image')
subplot(2,2,2); 
imshow(Im1);
title('Prewitt mask')
subplot(2,2,3); 
imshow(Im2);
title('Sobel mask')
subplot(2,2,4); 
imshow(Im3);
title('Log mask')