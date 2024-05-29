//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

//root.scad: Common parameters/functions

$fn = 200; //Amount of 'resolution' to give to shape primitives (less == more blocky, reduce or override it if renders or the editor are too slow or if you just like blocky air purifiers)

filterHeight = 85;
filterDiameter = 60;
filterWiggleRoom = 3; //extra space to allot where we need the filter to fit inside of something
filterSpace = filterDiameter + filterWiggleRoom;

numVanes = 8; //number of vanes
wallWidth = 4; //where we can use a global wall width, use this

//Fan plane
fanPlaneHeight = 4;
screwHoleDiameter = 6;
fanPlaneWidth = filterDiameter + wallWidth; //We assume the fan plane will always be a square, so this also counts as its depth. Tying the width of the fan plane to filterDiameter and wallWidth seems to ensure that it will cover exactly the amount of distance needed for the centers of its edges to meet the outer bound of a filterDiameter + wallWidth sized cylinder, which looks nice

//distance of the screwholes from the center of the fan plane
screwDistance = 25;

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

filterCutout = filterDiameter + 1;

module screwPlane(size, omitCutouts, setScrewDistance, overrideFilterCutout = filterDiameter){
    screwDistance = setScrewDistance;
    difference(){
        difference(){
            cube([size, size, fanPlaneHeight], center = true);
            
            if (!omitCutouts){
                translate([0, 0, -3])
                    linear_extrude(height = fanPlaneHeight + 2)
                        circle(d = overrideFilterCutout);
            }
        }
        
        if (!omitCutouts){
            screwHoleCutouts(1, fanPlaneHeight + 2);
        }
    }
}
