//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

filterD = 60; //6cm
//irl filter height is 8.5cm

flowConditionerHeight = 22; //4cm

linear_extrude(height = flowConditionerHeight)
difference(){
    circle(d = filterD + 2);
    circle(d = filterD - 3);
}


count = 8; //number of vanes

centerGap = 0; //space in the center where the vanes don't meet
fanGap = 13; //space between flow conditioner vanes and fan plane
extension = 0; //depth to extend the vanes below the housing of the flow conditioner
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

difference(){
    for (a = [0 : count - 1]) {
        rotate(a*360/count - 22) {
            translate([centerGap, -0.5, -extension])
                linear_extrude(height=flowConditionerHeight - fanGap + extension)
                    square([(filterD/2) - centerGap, 1]);
                //cube([(filterD / 2) - centerGap, 2, flowConditionerHeight - fanGap + extension]);
        }
    }
    
translate([0,0,-extension - 1]) //extra - 1 to eliminate plane fighting
    linear_extrude(height = extension + 1)
    difference(){
        circle(d = filterD + 2);
        circle(d = extensionDiameter);
    }
}

//grate circle
linear_extrude(height=flowConditionerHeight - fanGap + extension)
difference(){
    circle(d = filterD/2 + 3);
    circle(d = filterD/2);
}


//fan attach

fanPlaneHeight = 4;
screwHole = 7; //increased from 6 when adding minkowski rounding
screwDistance = 26;

translate([0,0,flowConditionerHeight])
difference(){
    difference(){
        cube([63, 63, fanPlaneHeight], center = true);
        translate([0,0,-3])
            linear_extrude(height = fanPlaneHeight + 2)
                circle(d = filterD);
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