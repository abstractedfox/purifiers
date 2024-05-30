//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

$fn = 50; //overriding this since the editor can be very slow with this part at high $fn, but it's recommended to comment it out and use the one inherited from root.scad when you go to actually export

unitHeight = 10;

linear_extrude(height = unitHeight){
    difference(){
        circle(d = filterDiameter + wallWidth);
        circle(d = filterDiameter);
    }
}

translate([0, 0, unitHeight]){
    screwPlane(size = fanPlaneWidth, omitCutouts = false, setScrewDistance = screwDistance);
}

screwPlane(size = fanPlaneWidth, omitCutouts = false, setScrewDistance = screwDistance);