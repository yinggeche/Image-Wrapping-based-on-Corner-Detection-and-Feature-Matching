% function [m,n] = match(A1,posr1,posc1,A2,posr2,posc2)

I1 = imread('../test/DSC_0309.jpg');
I2 = imread('../test/DSC_0311.jpg');
A1 = double(rgb2gray(I1));
A2 = double(rgb2gray(I2));

[posr1,posc1]=harris(A1);
[posr2,posc2]=harris(A2);


% We choose the window size 3*3
% Compute the mean in 3*3 window
window_size = 3;
window = 1/9 * ones(window_size, window_size);
M1 = filter2(window, A1);
M2 = filter2(window, A2);

% Compute the variance in 3*3 window
V1 = filter2(window, sqrt((A1-M1).^2));
V2 = filter2(window, sqrt((A2-M2).^2));

% Create a matrix to store the normalized correlation value
C = zeros(length(posr1), length(posr2));

% Get the window radius
r = floor(window_size/2);
% Compute the correlation matrix
for a=1+r:length(posr1)-r
   ax = posr1(a,1);
   ay = posc1(a,1);
   for b = 1+r:length(posr2)-r
       bx = posr2(b,1);
       by = posc2(b,1);
       A1_m = A1(ax-r:ax+r,ay-r:ay+r)-M1(ax,ay)*ones(window_size, window_size);
       A2_m = A2(bx-r:bx+r, by-r:by+r)-M2(bx,by)*ones(window_size,window_size);
       numerator = double(sum(sum(A1_m.* A2_m)));
       denominator = sqrt(sum(sum(A1_m.^2))) * sqrt(sum(sum(A2_m.^2)));
       C(a,b) = double(numerator/denominator);
   end
end

% % % 
% Cmax = max(max(C));
% t=Cmax*0.995;
% for i = 1:length(posr1) 
%     for j = 1:length(posr2)
%         if C(i,j) < t
%             C(i,j) = 0;
%         end
%     end
% end

% % Normalization
% c_peaks=imregionalmax(C);
% 
% % Get the sparse set of corners
% [m,n]=find(c_peaks ==1);
[m,n]=find(C>=max(max(C))-0.01);

% % 
% Q1 = zeros(length(posr1), length(posr2));
% Q2 = zeros(length(posr1), length(posr2));
% % Cmax = max(C);
% % for i=1:length(posr1)
% %     j = 1:length(posr2)
% %     
% 
% [~,index_1]=max(C);
% for i=1:length(posr2)
%     Q1(index_1(1,i),i) = 1;
% end
% [~,index_2]=max(C,[],2);
% for i=1:length(posr1)
%     Q2(i,index_2(i,1)) = 1;
% end
% 
% Q = Q1+Q2;
% 
% [m,n] = find(Q==max(Q));
% end
[h1, w1] = size(A1);
[h2, w2] = size(A2);
canvas_2=ones(max(h1,h2),w1+w2+100)*255;  
canvas_2(1:h1,1:w1)=A1;  
canvas_2(1:h2,w1+101:w1+w2+100)=A2; 

figure
imshow(uint8(canvas_2));  
hold on

[number,~] = size(m);
% Plot the correlations
for i=1:number
    x1 = posr1(m(i),1);
    y1 = posc1(m(i),1);
    x2 = posr2(n(i),1);
    y2 = posc2(n(i),1);
    line([x1,x2+w1+100],[y1,y2]);
    plot([x1 x2+w1+100],[y1 y2],'ro');
end