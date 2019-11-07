clear all;
close all;
% ------------ i) Read Images----------------
I1 = imread('../DanaOffice/DSC_0310.jpg');
I2 = imread('../DanaOffice/DSC_0311.jpg');
A1 = double(rgb2gray(I1));
A2 = double(rgb2gray(I2));

[h1, w1] = size(A1);
[h2, w2] = size(A2);

canvas_1=ones(max(h1,h2),w1+w2+100,3)*255;  
canvas_1(1:h1,1:w1,1:3)=I1;  
canvas_1(1:h2,w1+101:w1+w2+100,1:3)=I2; 

figure
imshow(uint8(canvas_1));
title('Original images');
hold on

% ------- ii) Harris Corner Detection--------

% Compute the corner_locations
[posr1,posc1]=harris(A1);
[posr2,posc2]=harris(A2);

% Result Display

canvas_2=ones(max(h1,h2),w1+w2+100)*255;  
canvas_2(1:h1,1:w1)=A1;  
canvas_2(1:h2,w1+101:w1+w2+100)=A2; 

figure
imshow(uint8(canvas_2)); 
title('Corners')
hold on

for i = 1:length(posr1)
    plot(posc1(i),posr1(i),'r.');
end
hold on
for i = 1:length(posr2)
    plot(posc2(i)+w1+100,posr2(i),'r.');
end
hold on
% % ---------- iii) NCC Corner Match-----------
% 
% % Compute the correlated corners pairs
% [m,n] = match(A1,posr1,posc1,A2,posr2,posc2);
% [number,~] = size(m);
% % Plot the correlations
% for i=1:number
%     x1 = posr1(m(i),1);
%     y1 = posc1(m(i),1);
%     x2 = posr2(n(i),1);
%     y2 = posc2(n(i),1);
%     line([x1,x2+w1+100],[y1,y2]);
%     plot([x1 x2+w1+100],[y1 y2],'ro');
%     hold on
% end