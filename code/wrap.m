clear all;
close all;
I1 = rgb2gray(imread('../DanaOffice/DSC_0310.jpg'));
I2 = rgb2gray(imread('../DanaOffice/DSC_0311.jpg'));

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

% figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);

% Compute the Geometric Transformation
tforms1 = estimateGeometricTransform(matchedPoints1, matchedPoints2,'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);
tforms2 = estimateGeometricTransform(matchedPoints2, matchedPoints2,'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);

imageSize = size(I1);

% Find the size of the final output image
for i = 1:numel(tforms1)
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms1(i), [1 imageSize(2)], [1 imageSize(1)]);
end

xMin = min([1; xlim(:)]);
xMax = max([imageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([imageSize(1); ylim(:)]);

% Get the size
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Produce the new image
panorama = zeros([height width], 'like', I1);
figure
imshow(panorama);
title('Empty Canvas for New Image')
hold on
blender = vision.AlphaBlender;

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);
% Create the panorama.
% I1 after transformation
warpedImage1 = imwarp(I1, tforms1, 'OutputView', panoramaView);
warpedImage2 = imwarp(I2, tforms2, 'OutputView', panoramaView);
figure
imshow(warpedImage1);
title('Image 1 after transform');
hold on

% panorama = step(blender, panorama, warpedImage,

figure
imshow(warpedImage2);
title('Image 2');
hold on
figure
a = blender(warpedImage1, warpedImage2);
imshow(a);
title('Wrapping using MATLAB functions');
hold on
figure
b = warpedImage1+warpedImage2;
imshow(b);
title('Wrapping using addition');
hold on

tol = sum(sum(b));
avg = floor(tol/(width*height));

c = b-uint8(ones(height,width)*avg*1.7);
d = (b-c);

figure
imshow(d);
title('Wrapping after adjusting gray value');
hold on
