//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

filterD = 119; //diameter of the cylinder

$fn = 600;

//height of this enclosure
flowConditionerHeight = 100; //in mm

maxwidth = 120; //max width of the whole enclosure, affects screw plane dimensions

linear_extrude(height = flowConditionerHeight)
difference(){
    circle(d = filterD + 2);
    circle(d = filterD - 3);
}


//square(69, center = true); //representative of the size of the screw planes of the inner filter enclosure, for seeing spatial relations
//circle(d = 84); //same as above but for the filter enclosure (size considers vanes)


count = 16; //number of vanes

centerGap = 52; //space in the center where the vanes don't meet
fanGap = 20; //space between flow conditioner vanes and fan plane
extension = 0; //depth to extend the vanes below the housing of the flow conditioner
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

vaneThiccness = 1;


//vanes
difference(){
    for (a = [0 : count - 1]) {
        rotate(a*360/count) {
        translate([centerGap, -1, -extension]) 
            cube([(filterD / 2) - centerGap, vaneThiccness, flowConditionerHeight - fanGap + extension]);
        }
    }
    
    //mask out part of the vanes that we don't want to touch the filter
    /*
    linear_extrude(height = flowConditionerHeight)
    difference(){
        circle(d = filterD + 2);
        circle(d = extensionDiameter);
    }*/
}

//fan attach

fanPlaneHeight = 4;
screwHole = 6;
screwDistance = 54;

module screwPlane(zPos){
        translate([0,0,zPos])
        difference(){
            difference(){
                cube([maxwidth, maxwidth, fanPlaneHeight], center = true);
                translate([0,0,-3])
                    linear_extrude(height = fanPlaneHeight + 2)
                        circle(d = filterD - 3);
            }
            translate([screwDistance, screwDistance, - 3])
                linear_extrude(height = fanPlaneHeight + 2)
                    circle(d = screwHole);
            
            translate([-screwDistance, screwDistance, -3])
                linear_extrude(height = fanPlaneHeight + 2)
                    circle(d = screwHole);
            
            translate([screwDistance, -screwDistance, -3])
                linear_extrude(height = fanPlaneHeight + 2)
                    circle(d = screwHole);
            
            translate([-screwDistance, -screwDistance, -3])
                linear_extrude(height = fanPlaneHeight + 2)
                    circle(d = screwHole);
        }
}

screwPlane(flowConditionerHeight);
screwPlane(2);
