//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

filterD = 66; //6cm filter diameter, add 3 for (2mm wall width) + (1mm wiggle room to fit the filter)


//irl filter height is 8.5cm
//we're going to leave some slack so we won't require a perfect joining of this piece and the flow conditioner/exact fit of the filter
housingHeight = 85;

maxwidth = 69; //of the entire housing, ie screwplanes

owo = "chrisisgr8 engineering";

module christext(){
    /*
    translate([-2,-20,1])
    //rotate([60,0,0])
            linear_extrude(height = 2)
            text("chrisisgr8 engineering", 
                     size=4,
                     font="Acumin Variable Concept:style=ExtraCondensed UltraBlack Italic",
                     halign="center",
                     valign="center");*/
}

//christext();

//note: this looks really fucky until you render it because of the way we're using subtracts to mask things out

/*
linear_extrude(height = housingHeight)
difference(){
    circle(d = filterD + 2);
    circle(d = filterD - 3);
}*/


count = 8; //number of vanes

centerGap = 6; //space in the center where the vanes don't meet
//fanGap = 40; //space between flow conditioner vanes and fan plane
fanGap = 30;
extension = 0; //depth to extend the vanes below the housing of the flow conditioner
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

//vanes
difference(){
    for (a = [0 : count - 1]) {
        rotate(a*360/count) {
        translate([centerGap, -1, -extension]) 
            cube([(filterD / 2) - centerGap, 1.5, housingHeight - fanGap + extension]);
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
slats = 16;
slatwidth = 4;

supportslats = 16; //slats that go the other way
wallwidth = 3;

swirls = 1; //swirl1!!!

difference(){
    //cool vortex
    translate([0,0,0]){ //load-bearing translate
        linear_extrude(height = housingHeight, twist = 69)
        for (a = [0 : slats - 1]) {
                rotate(a*360/slats) {
                translate([filterD/2, -1, -extension]) 
                    //cube([2, 3, housingHeight]);
                    square([wallwidth, slatwidth]);
                }
        }
        linear_extrude(height = housingHeight, twist = -69)
        for (a = [0 : supportslats - 1]) {
                rotate(a*360/supportslats) {
                translate([filterD/2, -1, -extension]) 
                    //cube([2, 3, housingHeight]);
                    square([wallwidth, slatwidth]);
                }
        }
    }

    //mask out the bits of the vortex that end up beyond the screw plane
    
    translate([0,0, housingHeight / 2])
        difference(){
            cube([maxwidth + 100, maxwidth + 100, housingHeight], true);
            cube([maxwidth,maxwidth, housingHeight], true);
    }
    
    //put this here too so it isn't interrupted by the vortex
    christext();
}


//stick a circle in the middle, bitches love circles
/*
translate([0,0, housingHeight - 1])
    linear_extrude(height = 2)
        difference(){
            circle(d = filterD + 5); //no idk why this is the difference that makes the circle look like it's the same width as the housing twisties
            circle(d = filterD);
        }*/


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
fanPlaneHeight = 4;

//note that screwholes in this document were given one extra mm from the center, and made 1mm larger to compensate, because they were having overlap issues with the void for the filter
    
screwHole = 6;
//screwHole = 7; //compensate for minkowski
screwDistance = 26;

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

//minkowski(){
screwPlane(housingHeight - 2);
//    sphere(1);
//}

//base 
//minkowski(){
    difference(){
        cube([maxwidth, maxwidth, fanPlaneHeight], center = true);
        
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
        
        christext();
    //}
    //sphere(1);
}
