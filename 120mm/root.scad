//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

//root.scad: Common parameters/functions

resolutionProd = 400;
resolutionTesting = 25;
resolution = resolutionTesting;

$fn = resolution;

baseHeight = 32;

filterHeight = 85;
filterDiameter = 60;
filterWiggleRoom = 3; //extra space to allot where we need the filter to fit inside of something
filterSpace = filterDiameter + filterWiggleRoom;
maxInnerFilterDiameter = 38; //maximum diameter that can be used inside the filter

enclosureDiameter = 120; //Diameter of the main enclosure
wallWidth = 3; //where we can use a global wall width, use this

//Fan plane
screwPlaneHeight = 3;
screwHoleDiameter = 6;
screwDistanceDefault = 25;
screwDistanceInner = 25;
fanPlaneWidthInner = filterDiameter + 5; //We assume the fan plane will always be a square, so this also counts as its depth
screwDistanceOuter = 54;

shroudHeight = 10; //height for wherever we use a 'shroud' to discourage airflow from entering through the edges of the enclosure

tolerance = 0.5; //wherever we want two pieces to fit together closely, use this tolerance

module screwHoleCutouts(taperAmnt = 1, height = 5, setScrewDistance = screwDistanceDefault){
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

module screwPlane(size, omitCutouts = false, setScrewDistance = screwDistanceDefault, overrideFilterCutout = filterDiameter){
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