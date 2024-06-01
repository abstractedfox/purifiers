//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

//Some notes:
//This part is rendered 'upside down' in this document, in that the top is at [0, 0, 0]. For this reason, when we refer to the 'top' in variables and comments, that is referring to the effective 'top' of the part when it's installed

$fn = 25; //overriding this since the editor can be slow with this part at high $fn, but it's recommended to comment it out and use the one inherited from root.scad when you go to actually export

housingHeight = filterHeight;
fanPlaneHeight = 3; //We don't have to worry as much about durability of the screw plane for an internal part, so we'll make it 3mm

numVanes = 6; //number of inner vanes
centerGap = 6; //space in the center where the vanes don't meet
inletGrateGap = 40; //Gap from the inlet grate to the vanes
maxInnerFilterDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

shroudDepth = 10; //Wherever we put a 'shroud' in the filter (to try to force more air through it instead of around it), this is how large it should be

//Inner vanes
difference(){
    for (a = [0 : numVanes - 1]) {
        rotate(a*360/numVanes) {
            translate([centerGap, -1, 0]){
                cube([(filterSpace / 2) - centerGap, 1.8, housingHeight - inletGrateGap]);
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

linear_extrude(height = housingHeight, twist = 0){
    for (a = [0 : slats - 1]) {
        rotate(a*360/slats) {
            translate([filterSpace/2, -1, 0]){ 
                square([slatDepth, slatwidth]);
            }
        }
    }
}

//top
linear_extrude(height = fanPlaneHeight)
    circle(d = topDiameter);

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
                translate([0, -1, 0]) {
                    square([topThingsLength, slatwidth]);
                }
            }
        }
    }
}

//Supporting circles
    translate([0,0, (housingHeight / 6) * 5  - 2])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterSpace + 5);
        circle(d = filterSpace);
    }
    
    translate([0,0, housingHeight / 1.5 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterSpace + 5);
        circle(d = filterSpace);
    }
    
translate([0,0, housingHeight / 2 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterSpace + 5);
        circle(d = filterSpace);
    }
    
    translate([0,0, housingHeight / 3 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterSpace + 5);
        circle(d = filterSpace);
    }
    
        translate([0,0, housingHeight / 6 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterSpace + 5);
        circle(d = filterSpace);
    }

//screw plane
screwDistance = 27;  //increased distance from 26 to 27mm because we were having wall width issues in cura
    
    //refactor note because i don't want to forget this when we come back to fix it: at the moment, the functions in root.scad are hardcoded to use 'screwDistance' for their screw distances. we renamed that to screwDistanceInner in that document, and the reason it still works is because THE INTERPRETER LOOKS AT THE ONE HERE AND GOES OH YEAH OK SURE I FOUND SCREWDISTANCE ITS RIGHT HERE GUYS

translate([0, 0, housingHeight]){
    color([0, 1, 0, 0.5]){
        screwPlane(fanPlaneWidthInner, false, screwDistanceInner);
    }
}
