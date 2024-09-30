import math

f = open("coefficient3.mi","w")

f.write("#File_format=Hex\n")
f.write("#Address_depth=2048\n")
f.write("#Data_width=48\n")

n = 100

# x = 0

for i in range(0,2048):
    alpha1 = math.sin(2*math.pi*n/24000) * 0.95
    alpha = round(alpha1 *536870912, 0)
    alpha = int(alpha) >> 4

    y11 = math.cos(2*math.pi*n/24000) #correct
    y12 = round (y11 * 1073741824, 0) #correct
    y1 = (int(y12) & 0x03FFFFFC) >> 2 #before shift 32848976 after shift 16424488

    if (n <= 1000):
        f.write("%06x%06x \n" % (alpha, y1))
        #print(x)
        # if(x == 1735):
        #     #print(n)
        #     print("alpha1 is ",alpha1)
        #     print("alpha is ",alpha)
        #     print("y11 is ",y11)
        #     print("y12 is ",y12)
        #     print("y1 is ",y1)
        n = n + 0.5
    else :
        f.write("%06x%06x \n" % (0, 0))
        n = n + 0.5

#    x = x+1    

# print((1039481936 >> 1 & 0x01FFFFFE))
# 1039481936.0 = 111101111101010011110001010000

