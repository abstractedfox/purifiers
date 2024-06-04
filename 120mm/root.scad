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
maxInnerFilterDiameter = 38; //maximum diameter that can be used inside the filter

enclosureDiameter = 120; //Diameter of the main enclosure

//Fan plane
screwPlaneHeight = 3;
screwHoleDiameter = 6;
screwDistanceInner = 25;
fanPlaneWidthInner = filterDiameter + 5; //We assume the fan plane will always be a square, so this also counts as its depth

wallWidth = 3; //where we can use a global wall width, use this

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