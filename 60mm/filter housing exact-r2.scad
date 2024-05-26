//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.


//Some notes:
//At the time of this writing, OpenSCAD visualizes in a very weird way until you actually render, so if it looks bizarre and physically impossible, try rendering

$fn = 250; //Amount of 'resolution' to give to shape primitives (less == more blocky, reduce if renders or the editor are too slow or if you just like blocky air purifiers)

filterDiameter = 66; //6cm filter diameter, add 3 for (2mm wall width) + (1mm wiggle room to fit the filter)

housingHeight = 86;

maxwidth = 69; //of the entire housing, ie screwplanes


//Internal vanes
numVanes = 8; //number of vanes
centerGap = 6; //space in the center where the vanes don't meet
vaneHeightReduction = 30; //space between flow conditioner vanes and these vanes (if set to 0, the vanes will go up to the height of the part)
vaneThickness = 1.5;
maxInnerDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

extension = 0; //depth to extend the vanes below the housing of the flow conditioner

//clarity note: this enclosing difference() is to mask out the portion of the inner vanes that would otherwise intersect with the filter
difference(){
    for (a = [0 : numVanes - 1]) {
        rotate(a * 360 / numVanes) {
            translate([centerGap, -1, 0]){
                cube([(filterDiameter / 2) - centerGap, vaneThickness, housingHeight - vaneHeightReduction]);
            }
        }
    }
    
    linear_extrude(height = housingHeight){
        difference(){
            circle(d = filterDiameter + 2);
            circle(d = maxInnerDiameter);
        }
    }
}

//The actual housing part
beams = 16;
opposingBeams = 16; //beams that go the other way
beamwidth = 4;
wallwidth = 3;
amountOfTwist = 69;

//clarity: this difference() masks out bits of the beam vortex that would otherwise exceed maxwidth, and prevents them from intersecting with the screw holes
difference(){
    translate([0,0,0]){ //load-bearing translate so the enclosing difference() will consider both beams to be a single object
        linear_extrude(height = housingHeight, twist = amountOfTwist){
            for (a = [0 : beams - 1]) {
                rotate(a*360/beams) {
                    translate([filterDiameter/2, -1, -extension]){
                        square([wallwidth, beamwidth]);
                    }
                }
            }
        }
        
        linear_extrude(height = housingHeight, twist = -amountOfTwist){
            for (a = [0 : opposingBeams - 1]) {
                rotate(a*360/opposingBeams) {
                    translate([filterDiameter/2, -1, -extension]){
                        square([wallwidth, beamwidth]);
                    }
                }
            }
        }
    }
    
    translate([0,0, housingHeight / 2])
        difference(){
            cube([maxwidth + 100, maxwidth + 100, housingHeight], true);
            cube([maxwidth,maxwidth, housingHeight], true);
    }
    
    //Subtract a little extra around the screwholes so the vanes don't end up inside them
    //Prevent any vane from entering the screwhole area
    translate([0,0, housingHeight - 2]){
        screwHoleCutouts(1, fanPlaneHeight);
    }
    //Use a spherical shape to taper slightly so it doesn't look like such a hard cut
    translate([0, 0, housingHeight - 2]){
        scale([1,1,2.5]){
            screwHoleTaper();
        }
    }
    
}

//Rings that further enclose/strengthen the housing vortex.
//I'm sure someone could come up with more flexible math; these will scale with the rest of the housing, but if you change the number of slats, they will no longer line up to the intersections
translate([0,0, (housingHeight / 6) * 5  - 2]){
    linear_extrude(height = beamwidth, center = true){
        difference(){
            circle(d = filterDiameter + 5);
            circle(d = filterDiameter);
        }
    }
}

translate([0,0, housingHeight / 1.5 - 1]){
    linear_extrude(height = beamwidth, center = true){
        difference(){
            circle(d = filterDiameter + 5);
            circle(d = filterDiameter);
        }
    }
}
    
translate([0,0, housingHeight / 2 - 1]){
    linear_extrude(height = beamwidth, center = true){
        difference(){
            circle(d = filterDiameter + 5);
            circle(d = filterDiameter);
        }
    }
}
    
translate([0,0, housingHeight / 3 - 1]){
    linear_extrude(height = beamwidth, center = true){
        difference(){
            circle(d = filterDiameter + 5);
            circle(d = filterDiameter);
        }
    }
}
    
translate([0,0, housingHeight / 6 - 1]){
    linear_extrude(height = beamwidth, center = true){
        difference(){
            circle(d = filterDiameter + 5);
            circle(d = filterDiameter);
        }
    }
}


//Fan plane
fanPlaneHeight = 4;
screwHoleDiameter = 6;
screwDistance = 26; //distance of the screwholes from the center of the fan plane

//Splitting this off into its own module so we can reuse it to make the screwhole cutouts, and to (politely) keep the vortex from intersecting with them
module screwHoleCutouts(taperAmnt, height){
    rotate([180,0,0]){
        translate([screwDistance, screwDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
                
        translate([-screwDistance, screwDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
        
        translate([screwDistance, -screwDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
        
        translate([-screwDistance, -screwDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
    }
}

module screwHoleTaper(){
    translate([screwDistance, screwDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
            
    translate([-screwDistance, screwDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
    
    translate([screwDistance, -screwDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
    
    translate([-screwDistance, -screwDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
}

module screwPlane(zPos, omitCutouts){
    translate([0,0,zPos])
    difference(){
        difference(){
            cube([maxwidth, maxwidth, fanPlaneHeight], center = true);
            
            if (!omitCutouts){
                translate([0,0,-3])
                    linear_extrude(height = fanPlaneHeight + 2)
                        circle(d = filterDiameter + 1);
            }
        }
        
        if (!omitCutouts){
            screwHoleCutouts(1, fanPlaneHeight + 2);
        }
    }
}

screwPlane(housingHeight - 2, false); //Screw plane on top
screwPlane(0, true); //Solid base (no holes)
