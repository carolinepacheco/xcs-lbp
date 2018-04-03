# An eXtended Center-Symmetric Local Binary Pattern for Background Modeling and Subtraction in Videos

Last Page Update: **26/03/2018**


We propose an eXtended Center-Symmetric Local Binary Pattern (XCS-LBP) descriptor for background modeling and subtraction in videos. By combining the strengths of the original LBP and the similar CS ones, it appears to be robust to illumination changes and noise, and produces short histograms, too. The experiments conducted on both synthetic and real videos (from the Background Models Challenge) of outdoor urban scenes under various conditions show that the proposed XCS-LBP outperforms its direct competitors for the background subtraction task.

THE XCS-LBP DESCRIPTOR
---------------------------------------------------
<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/XCS-LBP/master/docs/xcslbp.png" border="0" /></p>


COMPARISON OF LBP AND VARIANTS
---------------------------------------------------
<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/XCS-LBP/master/docs/table.png" border="0" /></p>


EXPERIMENTAL RESULTS
---------------------------------------------------


We’ve compared XCS-LBP with three other texture descriptors among the reviewed ones, namely :
 
* Original LBP Ojala et al. (2002),
* CS-LBP Heikkila et al. (2009) and
* CS-LDP Xue et al. (2011)


---------------------------------------------------
Background subtraction results using the GMM method on synthetic scenes – (a) original frame, (b) ground truth,(c) LBP, (d) CS-LBP, (e) CS-LDP and (f) proposed XCS-LBP.

<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/XCS-LBP/master/docs/visualresults.png" border="0"/></p>



---------------------------------------------------
Performance of the different descriptors on syn-thetic videos of the BMC using the GMM method. 

<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/XCS-LBP/master/docs/result.png" border="0" /></p>


Citation
--------
If you use this code for your publications, please cite it as:
```
@inproceedings{silva Caroline
author    = {Silva, Caroline and Bouwmans, Thierry and Frelicot, Carl},
title     = {An eXtended Center-Symmetric Local Binary Pattern for Background Modeling and Subtraction in Videos},
booktitle = {International Joint Conference on Computer Vision, Imaging and Computer Graphics Theory and Applications (VISAPP},
year      = {2015},
url       = {https://www.researchgate.net/publication/270895993_An_eXtended_Center-Symmetric_Local_Binary_Pattern_for_Background_Modeling_and_Subtraction_in_Videos}
```