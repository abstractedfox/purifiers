//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

//root.scad: Common parameters/functions

$fn = 300; //Amount of 'resolution' to give to shape primitives (less == more blocky, reduce or override it if renders or the editor are too slow or if you just like blocky air purifiers)

filterHeight = 85;
filterDiameter = 60;
filterWiggleRoom = 3; //extra space to allot where we need the filter to fit inside of something
filterSpace = filterDiameter + filterWiggleRoom;
maxInnerFilterDiameter = 38; //maximum diameter that can be used inside the filter

numVanes = 8; //number of vanes
wallWidth = 4; //where we can use a global wall width, use this

shroudDepth = 10; //Wherever we put a 'shroud' in the filter (to try to force more air through it instead of around it), this is how large it should be

tolerance = 0.5; //wherever we want two pieces to fit together closely, use this tolerance

//Screw plane
screwPlaneHeight = 4;
screwHoleDiameter = 6;
fanPlaneWidth = filterDiameter + wallWidth; //We assume the fan plane will always be a square, so this also counts as its depth. Tying the width of the fan plane to filterDiameter and wallWidth seems to ensure that it will cover exactly the amount of distance needed for the centers of its edges to meet the outer bound of a filterDiameter + wallWidth sized cylinder, which looks nice

//distance of the screwholes from the center of the fan plane
screwDistanceDefault = 25;

module screwHoleCutouts(taperAmnt, height, setScrewDistance = screwDistanceDefault){
    rotate([180,0,0]){
        translate([setScrewDistance, setScrewDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
                
        translate([-setScrewDistance, setScrewDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
        
        translate([setScrewDistance, -setScrewDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
        
        translate([-setScrewDistance, -setScrewDistance, - 3]){
            linear_extrude(height = height, scale = taperAmnt){
                circle(d = screwHoleDiameter);
            }
        }
    }
}


module screwHoleTaper(setScrewDistance = screwDistanceDefault){
    translate([setScrewDistance, setScrewDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
            
    translate([-setScrewDistance, setScrewDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
    
    translate([setScrewDistance, -setScrewDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
    
    translate([-setScrewDistance, -setScrewDistance, 0]){
        sphere(d = screwHoleDiameter);
    }
}

filterCutout = filterDiameter + 1;

module screwPlane(size, omitCutouts, setScrewDistance = screwDistanceDefault, overrideFilterCutout = filterDiameter){
    screwDistance = setScrewDistance;
    difference(){
        difference(){
            cube([size, size, screwPlaneHeight], center = true);
            
            if (!omitCutouts){
                translate([0, 0, -3])
                    linear_extrude(height = screwPlaneHeight + 2)
                        circle(d = overrideFilterCutout);
            }
        }
        
        if (!omitCutouts){
            screwHoleCutouts(1, screwPlaneHeight + 2, setScrewDistance = screwDistance);
        }
    }
}
