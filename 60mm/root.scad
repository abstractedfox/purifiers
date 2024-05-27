$fn = 200; //Amount of 'resolution' to give to shape primitives (less == more blocky, reduce or override it if renders or the editor are too slow or if you just like blocky air purifiers)

filterDiameter = 60;

numVanes = 8; //number of vanes

//Fan plane
fanPlaneHeight = 4;
screwHoleDiameter = 6;
fanPlaneWidth = 63;
fanPlaneDepth = 63;

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

module screwPlane(size, omitCutouts, setScrewDistance){
    screwDistance = setScrewDistance;
    difference(){
        difference(){
            cube([size, size, fanPlaneHeight], center = true);
            
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
