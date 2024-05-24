//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.


filterD = 63; //6cm filter diameter, add 3 for (2mm wall width) + (1mm wiggle room to fit the filter)
//irl filter height is 8.5cm

flowConditionerHeight = 45; //in mm

maxwidth = 65; //max width of the whole enclosure, affects screw plane dimensions

linear_extrude(height = flowConditionerHeight)
difference(){
    circle(d = filterD + 2);
    circle(d = filterD - 3);
}


count = 8; //number of vanes

centerGap = 5; //space in the center where the vanes don't meet
fanGap = 10; //space between flow conditioner vanes and fan plane
extension = 25; //depth to extend the vanes below the housing of the flow conditioner
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

vaneThiccness = 1;

difference(){
    for (a = [0 : count - 1]) {
        rotate(a*360/count) {
        translate([centerGap, -1, -extension]) 
            cube([(filterD / 2) - centerGap, vaneThiccness, flowConditionerHeight - fanGap + extension]);
        }
    }
    
translate([0,0,-extension - 1]) //extra - 1 to eliminate plane fighting
    linear_extrude(height = extension + 1)
    difference(){
        circle(d = filterD + 2);
        circle(d = extensionDiameter);
    }
}

//more vanes!!!!!! >:3
//let's have these extend into the center less
smallerCenterGap = centerGap + 4;
difference(){
    for (a = [0 : count - 1]) {
        rotate(a*360/count + 23) {
        translate([smallerCenterGap, -1]) 
            cube([(filterD / 2) - smallerCenterGap, vaneThiccness, flowConditionerHeight - fanGap]);
        }
    }
    
translate([0,0,-extension - 1]) //extra - 1 to eliminate plane fighting
    linear_extrude(height = extension + 1)
    difference(){
        circle(d = filterD + 2);
        circle(d = extensionDiameter);
    }
}

//and now? fucken Circles

insideCircle(filterD - 12);
insideCircle(filterD - 22);
insideCircle(filterD - 33);
insideCircle(filterD - 44);
insideCircle(filterD - 51);
circleGapFromFilter = 15;

module insideCircle(diameter){
    thicc = 2;
    translate([0,0,circleGapFromFilter])
    linear_extrude(height = flowConditionerHeight - fanGap - circleGapFromFilter)
    difference(){
        circle(d = diameter);
        circle(d = diameter - thicc);
    }
}


//fan attach

fanPlaneHeight = 4;
screwHole = 6;
screwDistance = 26;

module screwPlane(zPos){
    //minkowski(){
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
        //sphere(1);
    //}
}

screwPlane(flowConditionerHeight);
screwPlane(2);

/*
translate([28, 28, 0])
    cube([2, 2, flowConditionerHeight]);

translate([-30, 28, 0])
    cube([2, 2, flowConditionerHeight]);

translate([28, -30, 0])
    cube([2, 2, flowConditionerHeight]);

translate([-30, -30, 0])
    cube([2, 2, flowConditionerHeight]);*/

//filter supports
/*
filtersupports = 8;
supportheight = 7;
translate([0,0,-supportheight + 1])
    for (a = [0 : filtersupports]){
        rotate(a*360/filtersupports - 20) {
            translate([filterD / 2  + 1, -1, -1]) 
                    cube([2, 2, supportheight]);
        }
    }*/