% Path of the filefold
ReadinPath='.\DanaOffice\';
SamplePath='.\Officecorner\';
SavePath = '.\Paircorner\';
% File suffix
fileExt = '*.jpg';
% Get the path
files = dir(fullfile(ReadinPath,fileExt)); 
len = size(files,1);
% Get the whole files
r=2;
f=ones(r*2+1,r*2+1);
%for i=1:len-1
for i=1:1
   fileName1 = strcat(ReadinPath,files(i).name);
   fileName2 = strcat(ReadinPath,files(i+1).name);
   corner1=strcat(SamplePath,files(i).name);
   corner2=strcat(SamplePath,files(i+1).name);
   image2 = imread(fileName2);
   image1 = imread(fileName1);
   cor1=imread(corner1);
   cor2=imread(corner2);
   [m,n,~]=size(image1);
   coor1=[];
   for a=1:m
       for b=1:n
         if cor1(a,b)>200
             coor1=[coor1,[a;b]];
         end
       end
   end
   coor2=[];
   for a=1:m
       for b=1:n
         if cor2(a,b)>200
             coor2=[coor2,[a;b]];
         end
       end
   end
   [~,m]=size(coor1);
   [~,n]=size(coor2);
   R=zeros(m,n);
   [r,c,~]=size(image1);
   I1_tmp=zeros(r+2*r,c+2*r,3);  
   I2_tmp=zeros(r+2*r,c+2*r,3);  
   I1_tmp(r+1:r+r,r+1:c+r,1:3)=image1;  
   I2_tmp(r+1:r+r,r+1:c+r,1:3)=image2; 
   norm1=zeros(m);
   norm2=zeros(n);
 
    for a=1:m
        x1=coor1(1,a)+r;   
        y1=coor1(2,a)+r;

        for b=1:n
         x2=coor2(1,b)+r;   
         y2=coor2(2,b)+r; 

         I1_mean=mean(mean(I1_tmp(x1-r:x1+r,y1-r:y1+r)));  
         I2_mean=mean(mean(I2_tmp(x2-r:x2+r,y2-r:y2+r)));  
        z=I1_tmp(x1-r:x1+r,y1-r:y1+r)-I1_mean;  
        w=I2_tmp(x2-r:x2+r,y2-r:y2+r)-I2_mean;  
        p=sum(sum(z.*w));  
        q=sqrt(sum(sum(z.^2))*sum(sum(w.^2)));  
        R(a,b)=p/q;  

        
       end
    end
    
    canvas=ones(max(r,r),c+c+100)*255;  
canvas(1:r,1:c,1:3)=image1;  
canvas(1:r,c+101:c+c+100,1:3)=image2;  
imshow(uint8(canvas));  
hold on  

[m,n]=find(R>=max(max(R))-0.1);  
[number,~]=size(m);  
for k=1:number 
    x_1=coor1(2,m(k));  
    x_2=coor2(2,n(k));  
    y_1=coor1(1,m(k));  
    y_2=coor2(1,n(k));  
    line([x_1,x_2+c+100],[y_1,y_2]); 
    plot([x_1 x_2+c+100],[y_1 y_2],'ro');  
end  

end
