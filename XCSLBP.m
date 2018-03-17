function XCSLBP= XCSLBP(VolData, FxRadius, FyRadius, NeighborPoints, BorderLength)
              
%  This function is to compute the XCSLBP features
%  Reference:
%  Caroline Silva, Thierry Bouwmans, Carl Fr?licot, "An eXtended Center-Symmetric Local Binary Pattern
%  for Background Modeling and Subtraction in Videos," International
%  Conference on Computer Vision Theory and Applications (VISAPP),
%  March 2015, 1-8.
%
%  Copyright 2014 by Caroline Pacheco do E.Silva
%  If you have any problem, please feel free to contact Caroline Pacheco do E.Silva.
%  lolyne.pacheco@gmail.com
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function: Running this funciton each time to compute the LBP-TOP distribution of one video sequence.
%
%  Inputs:
%
%  "VolData" keeps the grey level of all the pixels in sequences with [height][width][Length];
%       please note, all the images in one sequnces should have same size (height and weight).
%       But they don't have to be same for different sequences.
%
%  "FxRadius", "FyRadius" and "TInterval" are the radii parameter along X, Y and T axis; They can be 1, 2, 3 and 4. "1" and "3" are recommended.
%  Pay attention to "TInterval". "TInterval * 2 + 1" should be smaller than the length of the input sequence "Length". For example, if one sequence includes seven frames, and you set TInterval to three, only the pixels in the frame 4 would be considered as central pixel and computed to get the LBP-TOP feature.
%
%
%  "NeighborPoints" is the number of the neighboring points
%      in XY plane, XT plane and YT plane; They can be 4, 8, 16 and 24. "8"
%      is a good option. For example, NeighborPoints = [8 8 8];
%
%  Output:
%
%  "Histogram": keeps LBP-TOP distribution of all the pixels in the current frame with [3][dim];
%      here, "3" deote the three planes of LBP-TOP, i.e., XY, XZ and YZ planes.
%      Each value of Histogram[i][j] is between [0,1]

%%
[height, width] = size(VolData);

XYNeighborPoints = NeighborPoints(1);

%%
if XYNeighborPoints<=8
  outClass='uint8';
elseif XYNeighborPoints>8 && XYNeighborPoints<=16
   outClass='uint16';
elseif XYNeighborPoints>16 && XYNeighborPoints<=32
   outClass='uint32';
elseif XYNeighborPoints>32 && XYNeighborPoints<=64
   outClass='uint64';   
else
   outClass='double';
end

%%
    % normal code
    nDim = 2^(NeighborPoints(1)/2);
    Histogram = zeros(1, nDim);

XCSLBP =zeros([height width], outClass);
   
        for yc = BorderLength + 1 : height - BorderLength
            
            for xc = BorderLength + 1 : width - BorderLength

                CenterVal = VolData(yc, xc);
                %% In XY plane
                BasicLBP = 0;
                FeaBin = 0;
                contXY = 1;
                vXYneighbor = zeros(1,8);
              % filtDimsR = [3, 3];
                
                % stores the neighbors in a vector
                for p = 0 : XYNeighborPoints - 1
                     X = floor(xc + FxRadius * cos((2 * pi * p) / XYNeighborPoints) + 0.5);
                     Y = floor(yc - FyRadius * sin((2 * pi * p) / XYNeighborPoints) + 0.5);
                     vXYneighbor(1, contXY) = VolData(Y, X);
                     contXY = contXY + 1; 
                end    
  
                % loop to calculate CS-LDP
                for kXY = 1: 4  
                    
                    if kXY == 1
                    p1XY =  vXYneighbor(1) - vXYneighbor(5);
                    pXY =   vXYneighbor(1) - CenterVal;
                    pcXY =  vXYneighbor(5) - CenterVal;
                    
                    end
                        
                    if kXY == 2
                    p1XY =  vXYneighbor(8) - vXYneighbor(4);
                    pXY =   vXYneighbor(3) - CenterVal;
                    pcXY =  vXYneighbor(7) - CenterVal;
                    
                    end
                    
                    if kXY == 3
                    p1XY =  vXYneighbor(7) - vXYneighbor(3);
                    pXY =   vXYneighbor(2) - CenterVal;
                    pcXY =  vXYneighbor(6) - CenterVal;
                   
                    end
                    
                    if kXY == 4
                    p1XY =  vXYneighbor(6) - vXYneighbor(2);
                    pXY =   vXYneighbor(4) - CenterVal;
                    pcXY =  vXYneighbor(8) - CenterVal;
                    
                    end
                  
                   CurrentVal = (p1XY + CenterVal) + (pXY*pcXY);
                   
                   if CurrentVal <=0
                        BasicLBP = BasicLBP + 2 ^ FeaBin;   
                   end
                   FeaBin = FeaBin + 1;   
                end

                XCSLBP(yc, xc)=cast(BasicLBP,  outClass);

                    Histogram(1, BasicLBP + 1) = Histogram(1, BasicLBP + 1) + 1;
 
            end
        end
%% crop the margins resulting from zero padding
%     XCSLBP=XCSLBP(( filtDimsR(1)+1 ):( end-filtDimsR(1) ),...
%      ( filtDimsR(2)+1 ):( end-filtDimsR(2)));

%% normalization
for j = 1 : 1
    Histogram(j, :) = Histogram(j, :)./sum(Histogram(j, :));
end