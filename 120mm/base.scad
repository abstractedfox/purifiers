//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

//r3: extended screwDistanceInner to 27 to match the dimensions used for inner filter housing r2

inletDiameter = 40; //interior of filter is 40mm

baseHeight = 32;

maxwidth = 120; //of the entire housing, ie screwplanes

screwHole = 6;
screwDistanceOuter = 54;

/*
module screwPlane(zPos){
    translate([0,0,zPos])
    difference(){
        difference(){
            cube([maxwidth, maxwidth, screwPlaneHeight], center = true);
            translate([0,0,-3])
                linear_extrude(height = screwPlaneHeight + 2)
                    circle(d = inletDiameter + 1, $fn = 200);
        }
        translate([screwDistanceInner, screwDistanceInner, - 3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
        
        translate([-screwDistanceInner, screwDistanceInner, -3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
        
        translate([screwDistanceInner, -screwDistanceInner, -3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
        
        translate([-screwDistanceInner, -screwDistanceInner, -3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
        
        
        
        translate([screwDistanceOuter, screwDistanceOuter, - 3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
        
        translate([-screwDistanceOuter, screwDistanceOuter, -3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
        
        translate([screwDistanceOuter, -screwDistanceOuter, -3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
        
        translate([-screwDistanceOuter, -screwDistanceOuter, -3])
            linear_extrude(height = screwPlaneHeight + 2)
                circle(d = screwHole, $fn = 200);
    }
}*/

//screwPlane(baseHeight - 2);
//module screwPlane(size, omitCutouts, setScrewDistance = screwDistanceDefault, overrideFilterCutout = filterDiameter)

translate([0, 0, baseHeight - (screwPlaneHeight / 2)])
screwPlane(size = enclosureDiameter, omitCutouts = false, overrideFilterCutout = maxInnerFilterDiameter);


//spikes
spikeHeight = baseHeight - screwPlaneHeight;
module spike(xPos, yPos, zPos){
    translate([xPos, yPos, zPos]){
        rotate([180,0,0]){
            linear_extrude(height = zPos, scale = 0.3){
                circle(d = 10);
            }
        }
    }
}

spikeDistance = screwDistanceOuter - 6;
spike(spikeDistance, spikeDistance, spikeHeight);
spike(-spikeDistance, spikeDistance, spikeHeight);
spike(spikeDistance, -spikeDistance, spikeHeight);
spike(-spikeDistance, -spikeDistance, spikeHeight);

//Grate

centerGap = 0; //space in the center where the vanes don't meet
fanGap = 0; //space between flow conditioner vanes and fan plane
extension = 0;
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter
count = 8;

//note: i have no idea why we have to subtract 0.5 from z to get this to line up correctly, but we do
translate([0, 0, baseHeight - screwPlaneHeight - 0.5]){
        for (a = [0 : count - 1]) {
            rotate(a*360/count - 22) {
                translate([0, -0.5, 0])
                    linear_extrude(height=screwPlaneHeight)
                        square([(inletDiameter/2) - centerGap + 1, 1]);
            }
        }
        

    //grate circle
    linear_extrude(height=screwPlaneHeight - fanGap + extension)
    difference(){
        circle(d = inletDiameter/2 + 2);
        circle(d = inletDiameter/2);
    }
}
