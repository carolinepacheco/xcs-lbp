%  An example how to use XCS-LBP
%  The below codes are not optimized. It is straightforward for easy understanding.
%  Copyright 2014 by Caroline Pacheco do E.Silva
%  If you have any problem, please feel free to contact Caroline Pacheco do E.Silva.
%  lolyne.pacheco@gmail.com
%%
clear all; clc;

I = imread('001.png');
I = rgb2gray(I);
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

h1 = figure(1);
subplot(1,2,1), imshow(I,[],'InitialMagnification','fit');
subplot(1,2,2), imshow(XCS,[],'InitialMagnification','fit');

disp('Finished');