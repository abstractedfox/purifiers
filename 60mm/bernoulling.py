import math

maxInnerFilterDiameter = 38
outletDiameterMultiplier = 0.8

a1 = math.pi * pow(maxInnerFilterDiameter / 2, 2)
a2 = math.pi * pow((maxInnerFilterDiameter * outletDiameterMultiplier)/ 2, 2)

v1 = 1 #we don't know what the initial velocity actually is, but that's (probably) ok because we just want to be able to see how it changes
v2 = (a1 / a2) * v1 #continuity equation

rho = 1.225 #we also don't know what the density is and uhh gasses are compressible so we'll just say that density is an international standard atmosphere at sea level (1.225 Kg/m^3) i'm sure it's fine

deltaP = (1/2) * rho * (pow(v2, 2) - pow(v1, 2)) #bernoulli's equation, solved for the difference in pressure

print("and your difference in pressure is", deltaP)
