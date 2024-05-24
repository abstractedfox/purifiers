//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

filterD = 66; //6cm filter diameter, add 3 for (2mm wall width) + (1mm wiggle room to fit the filter)

$fn = 200; //smooth gemoetry!

//irl filter height is 8.5cm
//we're going to leave some slack so we won't require a perfect joining of this piece and the flow conditioner/exact fit of the filter
housingHeight = 85;

maxwidth = 69; //of the entire housing, ie screwplanes
fanPlaneHeight = 3;

count = 6; //number of inner vanes

centerGap = 6; //space in the center where the vanes don't meet
fanGap = 40; //Inner vanes extend fully in this design to support the 'top' of the enclosure during printing
extension = 0; //depth to extend the vanes below the housing of the flow conditioner
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

//vanes
difference(){
    for (a = [0 : count - 1]) {
        rotate(a*360/count) {
        translate([centerGap, -1, -extension]) 
            cube([(filterD / 2) - centerGap, 1.8, housingHeight - fanGap + extension]);
        }
    }
    
    //mask out part of the vanes that we don't want to touch the filter
    linear_extrude(height = housingHeight)
    difference(){
        circle(d = filterD + 2);
        circle(d = extensionDiameter);
    }
}

//actual filter housing part thingy
slats = 18;
slatwidth = 2;

supportslats = 18; //slats that go the other way
wallwidth = 10;

swirls = 1; //swirl1!!!

/*
scale([1,1,0.5]) //stretch it vertically
translate([15,0,0])
rotate([90,0,0])
linear_extrude(2) //thickness 
circle(d = housingHeight / 2 ); //make it half the height so when we stretch it vertically it will cover the entire thing
*/

//outer vanes/supports
difference(){
    translate([0,0,0]){ //load-bearing translate
        linear_extrude(height = housingHeight, twist = 0)
        for (a = [0 : slats - 1]) {
                rotate(a*360/slats) {
                translate([filterD/2, -1, -extension]) 
                    //cube([2, 3, housingHeight]);
                    square([wallwidth, slatwidth]);
                }
        }
        linear_extrude(height = housingHeight, twist = 0)
        for (a = [0 : supportslats - 1]) {
                rotate(a*360/supportslats) {
                translate([filterD/2, -1, -extension]) 
                    //cube([2, 3, housingHeight]);
                    square([wallwidth, slatwidth]);
                }
        }
    }
}

//top things
topThingsHeight = 6;
//spaceFromCenter = filterD / 2;

//topThingsLength = 15;
//spaceFromCenter = 28;
topThingsLength = maxwidth / 2 + wallwidth - 1.5;
spaceFromCenter = 0;

//topThingsLength = filterD / 2;
//spaceFromCenter = 10;

translate([0,0,0]){
    /*
    rotate([180,0,0])
    linear_extrude(height = 4)
    for (a = [0 : slats - 1]) {
            rotate(a*360/slats) {
            translate([spaceFromCenter, -1, -extension])
                //cube([2, 3, housingHeight]);
                square([topThingsLength, slatwidth]);
            }
    }*/        
    
    rotate([180,0,0])
    linear_extrude(height = topThingsHeight)
    for (a = [0 : supportslats - 1]) {
            rotate(a*360/supportslats) {
            translate([spaceFromCenter, -1, -extension]) 
                //cube([2, 3, housingHeight]);
                square([topThingsLength, slatwidth]);
            }
    }
}


//stick a circle in the middle, bitches love circles

    translate([0,0, (housingHeight / 6) * 5  - 2])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterD + 5);
        circle(d = filterD);
    }
    
    translate([0,0, housingHeight / 1.5 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterD + 5);
        circle(d = filterD);
    }
    
translate([0,0, housingHeight / 2 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterD + 5);
        circle(d = filterD);
    }
    
    translate([0,0, housingHeight / 3 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterD + 5);
        circle(d = filterD);
    }
    
        translate([0,0, housingHeight / 6 - 1])
linear_extrude(height = slatwidth, center = true)
    difference(){
        circle(d = filterD + 5);
        circle(d = filterD);
    }
    
    

        


//fan attach

//note that screwholes in this document were given one extra mm from the center, and made 1mm larger to compensate, because they were having overlap issues with the void for the filter
    
screwHole = 6;
screwDistance = 27;  //increased distance from 26 to 27mm because we were having wall width issues in cura

module screwPlane(zPos){
    translate([0,0,zPos])
    difference(){
        difference(){
            cube([maxwidth, maxwidth, fanPlaneHeight], center = true);
            translate([0,0,-3])
                linear_extrude(height = fanPlaneHeight + 2)
                    circle(d = filterD + 1);
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

screwPlane(housingHeight - 1);
//base 
linear_extrude(height = fanPlaneHeight)
    circle(d = filterD + 6);
//cube([maxwidth, maxwidth, fanPlaneHeight], center = true);
