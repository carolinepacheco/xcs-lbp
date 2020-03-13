import matplotlib.pyplot as plt
from XCSLBP import *

# Read original image
imgnm = "002.jpg"
image = plt.imread(imgnm)

# Call XCSLBP function
imgXCSLBP = XCSLBP(image)

# Visualize results
vecimgLBP = imgXCSLBP.flatten()
fig = plt.figure(figsize=(20,8))
ax  = fig.add_subplot(1,3,1)
ax.imshow(image)
ax.set_title("Original image")
ax  = fig.add_subplot(1,3,2)
ax.imshow(imgXCSLBP,cmap="gray")
ax.set_title("XCSLBP image")
ax  = fig.add_subplot(1,3,3)
freq,lbp, _ = ax.hist(vecimgLBP,bins=2**8)
ax.set_ylim(0,40000)
lbp = lbp[:-1]
## print the XCSLBP values when frequencies are high
largeTF = freq > 5000
for x, fr in zip(lbp[largeTF],freq[largeTF]):
    ax.text(x,fr, "{:6.0f}".format(x),color="red")
    ax.set_title("XCSLBP histogram")
plt.show()
    
