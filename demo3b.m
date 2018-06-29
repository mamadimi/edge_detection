%Author : Mamagiannos Dimitrios
%Date : June 2015

load('illinois.mat')

prwt =  myedgecon( I,'prewitt',0.05,0.065,0.065,2);

sob =  myedgecon( I,'sobel',0.2,0.06,0.06,2 );


figure
subplot(2,2,1); 
imshow(I);
title('Image')
subplot(2,2,2); 
imshow(prwt);
title('Prewitt mask')
subplot(2,2,3); 
imshow(sob);
title('Sobel mask')
