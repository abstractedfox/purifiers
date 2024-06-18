//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

//height of this enclosure
unitHeight = 100; //in mm

//Main cylinder
linear_extrude(height = unitHeight){
    difference(){
        circle(d = enclosureDiameter);
        circle(d = enclosureDiameter - wallWidth);
    }
}

vaneCount = 16; //number of vanes
centerGap = 53; //distance from the ends of the vanes to the center of the housing
fanGap = 20; //space between inner housing vanes and fan plane
baseGap = 10 + tolerance; //space between inner housing vanes and the base of the unit
vaneThiccness = 1;

//vanes
//Removing these for now since they would otherwise interfere with the shroud on the bottom, which seems more useful tbh
/*
for (a = [0 : vaneCount - 1]) {
    rotate(a * 360/ vaneCount) {
        //The vanes like to fight with the outer bounds of the main housing cylinder, so we'll move them inward by an extra -1 (centerGap - 1)
        
        translate([centerGap - 1, 0, baseGap]){
            cube([(enclosureDiameter / 2) - centerGap, vaneThiccness, unitHeight - fanGap - baseGap]);
        }
    }
}*/

//Screw planes
translate([0, 0, (screwPlaneHeight / 2)]){
    screwPlane(size = enclosureDiameter, setScrewDistance = screwDistanceOuter, overrideFilterCutout = enclosureDiameter);
}

translate([0, 0, unitHeight - (screwPlaneHeight / 2)]){
    screwPlane(size = enclosureDiameter, setScrewDistance = screwDistanceOuter, overrideFilterCutout = enclosureDiameter);
}