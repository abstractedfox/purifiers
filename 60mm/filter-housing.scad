//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.


//Some notes:
//At the time of this writing, OpenSCAD visualizes this part in a weird way until you actually render, so if it looks bizarre and physically impossible, try rendering

include <root.scad>

housingHeight = filterHeight;
maxwidth = filterSpace + wallWidth; //we use this parameter to ensure the width of the screw planes meets the outer bounds of the vortex

//Use anywhere we want to mask geometry from escaping maxwidth
module outerBounds(){
    translate([0,0, housingHeight / 2]){
        difference(){
            cube([maxwidth + 100, maxwidth + 100, housingHeight], true);
            cube([maxwidth, maxwidth, housingHeight], true);
        }
    }
}

module cylinderBounds(){
    difference(){
        linear_extrude(height = housingHeight * 2, center = true){
            circle(d = maxwidth + 100);
        }
        
        linear_extrude(height = housingHeight * 2, center = true){
            circle(d = maxwidth);
        }
    }
}

//Internal vanes
centerGap = 6; //space in the center where the vanes don't meet
vaneHeightReduction = 30; //space between flow conditioner vanes and these vanes (if set to 0, the vanes will go up to the height of the part)
vaneThickness = 1.5;

//clarity note: this enclosing difference() is to mask out the portion of the inner vanes that would otherwise intersect with the filter
difference(){
    for (a = [0 : numVanes - 1]) {
        rotate(a * 360 / numVanes) {
            translate([centerGap, -1, 0]){
                cube([(filterSpace / 2) - centerGap, vaneThickness, housingHeight - vaneHeightReduction]);
            }
        }
    }
    
    linear_extrude(height = housingHeight){
        difference(){
            circle(d = filterSpace + 2);
            circle(d = maxInnerFilterDiameter);
        }
    }
}

//The actual housing part
beams = 16;
opposingBeams = 16; //beams that go the other way
beamwidth = 4;
amountOfTwist = 69;

//clarity: this difference() masks out bits of the beam vortex that would otherwise exceed maxwidth, and prevents them from intersecting with the screw holes
difference(){
    union(){
        linear_extrude(height = housingHeight, twist = amountOfTwist){
            for (a = [0 : beams - 1]) {
                rotate(a*360/beams) {
                    translate([filterSpace / 2, -1, 0]){
                        square([wallWidth, beamwidth]);
                    }
                }
            }
        }
        
        linear_extrude(height = housingHeight, twist = -amountOfTwist){
            for (a = [0 : opposingBeams - 1]) {
                rotate(a*360/opposingBeams) {
                    translate([filterSpace/2, -1, 0]){
                        square([wallWidth, beamwidth]);
                    }
                }
            }
        }
    }
    
    outerBounds();
    cylinderBounds();
    
    //Subtract a little extra around the screwholes so the vanes don't end up inside them
    
    //Prevent any amount of vane from entering the immediate screwhole area
    translate([0,0, housingHeight - 2]){
        screwHoleCutouts(1, screwPlaneHeight);
    }
    //Use a spherical shape to taper below it slightly so it doesn't look like such a hard cut
    translate([0, 0, housingHeight - 2]){
        scale([1,1,2.5]){
            screwHoleTaper();
        }
    }
    
}

//Rings that further enclose/strengthen the housing vortex.
//I'm sure someone could come up with more flexible math; these will scale with the rest of the housing, but if you change the number of slats, they will no longer line up to the intersections.
//We'll also mask out any extra circle that appears outside maxwidth
difference(){
    union(){ 
        translate([0,0, (housingHeight / 6) * 5  - 2]){
            linear_extrude(height = beamwidth, center = true){
                difference(){
                    circle(d = filterSpace + wallWidth + 10);
                    circle(d = filterSpace);
                }
            }
        }

        translate([0,0, housingHeight / 1.5 - 1]){
            linear_extrude(height = beamwidth, center = true){
                difference(){
                    circle(d = filterSpace + wallWidth + 1);
                    circle(d = filterSpace);
                }
            }
        }
            
        translate([0,0, housingHeight / 2 - 1]){
            linear_extrude(height = beamwidth, center = true){
                difference(){
                    circle(d = filterSpace + wallWidth + 1);
                    circle(d = filterSpace);
                }
            }
        }
            
        translate([0,0, housingHeight / 3 - 1]){
            linear_extrude(height = beamwidth, center = true){
                difference(){
                    circle(d = filterSpace + wallWidth + 1);
                    circle(d = filterSpace);
                }
            }
        }
            
        translate([0,0, housingHeight / 6 - 1]){
            linear_extrude(height = beamwidth, center = true){
                difference(){
                    circle(d = filterSpace + wallWidth + 1);
                    circle(d = filterSpace);
                }
            }
        }
    }

    outerBounds();
    cylinderBounds();
}

//Screw planes
//We offset the z positions of the planes so they won't invade the part of the enclosure meant for the filter
translate([0, 0, housingHeight - (screwPlaneHeight / 2)]){
    screwPlane(size = maxwidth, omitCutouts = false, setScrewDistance = screwDistanceDefault, overrideFilterCutout = filterSpace); //Screw plane on top
}

translate([0, 0, -(screwPlaneHeight / 2)]){
    screwPlane(maxwidth, omitCutouts = true); //Solid base (no holes)
}


//Shroud (to encourage air to go through and not around)
translate([0, 0, (screwPlaneHeight / 2)]){
    linear_extrude(height = shroudDepth){
        difference(){
            circle(d = maxInnerFilterDiameter);
            circle(d = maxInnerFilterDiameter - vaneThickness);
        }
    }
}