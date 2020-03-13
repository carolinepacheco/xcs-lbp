#This function is to compute the XCSLBP features
#Reference:
#Caroline Silva, Thierry Bouwmans, Carl Fr?licot, "An eXtended Center-Symmetric Local Binary Pattern
#for Background Modeling and Subtraction in Videos," International
#Conference on Computer Vision Theory and Applications (VISAPP),
#March 2015, 1-8.

#Copyright 2014 by Caroline Pacheco do E.Silva
#If you have any problem, please feel free to contact Caroline Pacheco do E.Silva.
#lolyne.pacheco@gmail.com


#%%
import cv2
import numpy as np

def XCSLBP(image):
    
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    imgXCSLBP = np.zeros_like(gray_image) 
    neighboor = 3 
    
    for ih in range(0,image.shape[0] - neighboor): # loop para linha 
        for iw in range(0,image.shape[1] - neighboor):
            ### Get natrix image 3 by 3 pixel
            img = gray_image[ih:ih+neighboor,iw:iw+neighboor] 
            g0, g1, g2, g3= img[1,2], img[2,2], img[2,1], img[2,0]
            g4, g5, g6, g7 = img[1,0], img[0,0], img[0,1], img[0,2] 
            neighbor = np.array([g0, g1, g2, g3], dtype="float32")
            opp_neighbor= np.array([g4, g5, g6, g7], dtype="float32")
            center = img[1,1]
        
            x_1 = ((neighbor - opp_neighbor) + center)
            x_2 = ((neighbor - center)*(opp_neighbor - center)) 
        
            xcslbp = ((x_1 + x_2) >= 0)*1.0
        
            ### Convert the binary operated values to a decimal (digit)
            where_xcslbp_vector = np.where(xcslbp)[0]

            num = np.sum(2**where_xcslbp_vector) if len(where_xcslbp_vector) >= 1 else 0
            imgXCSLBP[ih+1,iw+1] = num

    return imgXCSLBP