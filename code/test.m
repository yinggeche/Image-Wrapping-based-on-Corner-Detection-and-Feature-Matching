% Show
figure
imshow(I1);
hold on
for i = 1:length(posr1)
    plot(posc1(i),posr1(i),'r+');
end

figure
imshow(I2);
hold on
for i = 1:length(posr2)
    plot(posc2(i),posr2(i),'r+');
end
