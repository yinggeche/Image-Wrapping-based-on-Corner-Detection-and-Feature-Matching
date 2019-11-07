# Image-Wrapping-based-on-Corner-Detection-and-Feature-Matching
## Description
Image Wrapping based on Corner Detection and Feature Matching
## Language
MATLAB
## Algorithm
1. Achieve feature detection by Harris Corner Detection
2. Match features between two images by computing homograph(tranformation matrix)
3. Find the final output image size and initialize a panorama
4. Warp the two images together by using vision.blender
5. Adjust the gray value of the overlapping part
