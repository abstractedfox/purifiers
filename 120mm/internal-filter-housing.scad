//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

//Some notes:
//This part is rendered 'upside down' in this document, in that the top is at [0, 0, 0]. For this reason, when we refer to the 'top' in variables and comments, that is referring to the effective 'top' of the part when it's installed

$fn = 25; //overriding this since the editor can be slow with this part at high $fn, but it's recommended to comment it out and use the one inherited from root.scad when you go to actually export

/*
color([1,0,0,0.2])
translate([0,10,0])
cube([100,10,filterHeight]);*/

housingHeight = filterHeight;

numVanes = 6; //number of inner vanes
centerGap = 6; //space in the center where the vanes don't meet
inletGrateGap = 40; //Gap from the inlet grate to the vanes
maxInnerFilterDiameter = 38; //maximum diameter that the vanes can occupy inside the filter
vaneWidth = 1.5;

shroudDepth = 10; //Wherever we put a 'shroud' in the filter (to try to force more air through it instead of around it), this is how large it should be

//Inner-filter vanes
difference(){
    for (a = [0 : numVanes - 1]) {
        rotate(a*360/numVanes) {
            translate([centerGap, -1, 0]){
                cube([(filterSpace / 2) - centerGap, vaneWidth, housingHeight - inletGrateGap]);
            }
        }
    }
    
    //mask out part of the vanes that we don't want to touch the filter
    linear_extrude(height = housingHeight){
        difference(){
            circle(d = filterSpace + 2);
            circle(d = maxInnerFilterDiameter);
        }
    }
}

//Vertical slats
slats = 18;
slatwidth = 2;
slatDepth = 10;

linear_extrude(height = housingHeight + screwPlaneHeight, twist = 0){
    for (a = [0 : slats - 1]) {
        rotate(a*360/slats) {
            translate([filterSpace / 2, -1, 0]){ 
                square([slatDepth, slatwidth]);
            }
        }
    }
}

//top (as in literal top when installed; sits at the bottom of the model in openscad)
topHeight = 2;
translate([0, 0, -topHeight]){
    linear_extrude(height = topHeight){
        circle(d = topDiameter);
    }
}

//Slats that go on the 'top' (bottom of the model, top when printed)
topThings = slats;
topDiameter = filterSpace + 6;

//top things, to be honest these are a complete shot in the dark but I just kind of feel like they will promote airflow
topThingsHeight = 5;
topThingsLength = (topDiameter / 2) + slatDepth - 3;

rotate([180,0,0]){
    linear_extrude(height = topThingsHeight){
        for (a = [0 : topThings - 1]) {
            rotate(a*360/topThings) {
                //the y axis -1 prevents the individual objects from being slightly offset with the vertical slats
                translate([0, -1, 0]) {
                    square([topThingsLength, slatwidth]);
                }
            }
        }
    }
}

//Supporting circles
circleThickness = 5; //ie from the center
translate([0,0, (housingHeight / 6) * 5  - 2]){
    linear_extrude(height = slatwidth, center = true){
        difference(){
            circle(d = filterSpace + circleThickness);
            circle(d = filterSpace);
        }
    }
}
    
translate([0,0, housingHeight / 1.5 - 1]){
    linear_extrude(height = slatwidth, center = true){
        difference(){
            circle(d = filterSpace + circleThickness);
            circle(d = filterSpace);
        }
    }
}
    
translate([0,0, housingHeight / 2 - 1]){
    linear_extrude(height = slatwidth, center = true){
        difference(){
            circle(d = filterSpace + circleThickness);
            circle(d = filterSpace);
        }
    }
}
    
translate([0,0, housingHeight / 3 - 1]){
    linear_extrude(height = slatwidth, center = true){
        difference(){
            circle(d = filterSpace + circleThickness);
            circle(d = filterSpace);
        }
    }
}
    
translate([0,0, housingHeight / 6 - 1]){
    linear_extrude(height = slatwidth, center = true){
        difference(){
            circle(d = filterSpace + circleThickness);
            circle(d = filterSpace);
        }
    }
}

//Screw plane; increase its height by half the height of the screw plane so the internal volume matches the filter correctly
translate([0, 0, housingHeight + (screwPlaneHeight / 2)]){
    color([0, 1, 0, 0.5]){
        screwPlane(fanPlaneWidthInner, false, screwDistanceInner);
    }
}
