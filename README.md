# Image-Wrapping-based-on-Corner-Detection-and-Feature-Matching
## Algorithm
1.  Achieve feature detection by Harris Corner Detection
2.  Extract features by non-maximum suppression
3.  Compute the homograph and match features by NCC and RANSAC
4.  Find the final output image size and initialize a panorama
5.  Warp the two images together by using vision.blender
6.  Adjust the gray value of the overlapping area in Final Image

## Language
MATLAB

## Libraries
MATLAB Computer Vision ToolBox
