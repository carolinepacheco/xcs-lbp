%  Copyright 2014 by Caroline Pacheco do E.Silva
%  If you have any problem, please feel free to contact Caroline Pacheco do E.Silva.
%  lolyne.pacheco@gmail.com
%% Background Subtraction Algorithm
%%% Gaussian Mixture Model with XCS-LBP
addpath('../')

clear all; clc;
dir_path = ['img/'];
png_files = dir(fullfile(dir_path,'*.png'));
nFrames = size(png_files,1);
%%

detector = vision.ForegroundDetector(...
    'NumTrainingFrames', 5, ... % 5 because of short video
    'InitialVariance', 30*30); % initial standard deviation of 30

for k = 1:1:nFrames
    disp(['Processing frame: ' num2str(k)]);
    
    imagefile = [dir_path num2str(k) '.png'];
    I = imread(imagefile);
    I = rgb2gray(I);
    I = imresize(I,0.25);
    I = double(I);
    
    % parameter set
    
    % 1. "FxRadius", "FyRadius" and "TInterval" are the radii parameter along X, Y and T axis; They can be 1, 2, 3 and 4. "1" and "3" are recommended.
    %  Pay attention to "TInterval". "TInterval * 2 + 1" should be smaller than the length of the input sequence "Length".
    % For example, if one sequence includes seven frames, and you set TInterval
    % to three, only the pixels in the frame 4 would be considered as central
    % pixel and computed to get theXTC-SLBP feature.
    FxRadius = 1;
    FyRadius = 1;
    TInterval = 2;
    
    % 2. "TimeLength" and "BoderLength" are the parameters for bodering parts in time and space which would not
    % be computed for features. Usually they are same to TInterval and the
    % bigger one of "FxRadius" and "FyRadius";
    TimeLength = 2;
    BorderLength = 1;
    
    % Compute uniform patterns
    NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
    nDim = 2 ^ (NeighborPoints(1));  %dimensionality of basic XC-LBP
    
    XCS = XCSLBP(I,FxRadius, FyRadius, NeighborPoints, BorderLength);
    
    XCS = XCS*(255/16);
    frame = medfilt2(XCS);
    
    mask = step(detector, frame);
    mask = medfilt2(mask);
    
    h1 = figure(1);
    subplot(1,2,1), imshow(I,[],'InitialMagnification','fit'), title('Input');
    subplot(1,2,2), imshow(mask,[],'InitialMagnification','fit'), title('Foreground');
    pause(0.1);
   
end
disp('Finished');