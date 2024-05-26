//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

//Some notes:
//We are treating one 'unit' of size as 1mm in physical space

$fn = 350; //Amount of 'resolution' to give to shape primitives (less == more blocky, reduce if renders or the editor are too slow or if you just like blocky air purifiers)

filterDiameter = 60;

barrelHeight = 22;

//Barrel
linear_extrude(height = barrelHeight){
    difference(){
        circle(d = filterDiameter + 2);
        circle(d = filterDiameter - 3);
    }
}

//Vanes
numVanes = 8; //number of vanes
fanGap = 13; //Amount of space between vanes and the fan plane
rotateVanes = 22; //Amount of rotation to apply to the vanes (aesthetic)
vaneThickness = 1;
vaneYOffset = -0.5; //This offset prevents the vanes from looking 'twisty'. You will probably need to modify this if you change the vane thickness

for (a = [0 : numVanes - 1]) {
    rotate(a * 360 / numVanes + rotateVanes) {
        translate([0, vaneYOffset, 0]){
            linear_extrude(height = barrelHeight - fanGap){
                square([(filterDiameter / 2), vaneThickness]);
            }
        }
    }
}

//Circle in the center of the grate; for aesthetics/making it harder to stick your fingers in
linear_extrude(height = barrelHeight - fanGap){
    difference(){
        circle(d = filterDiameter/2 + 3);
        circle(d = filterDiameter/2);
    }
}

//Fan plane
fanPlaneHeight = 4;
screwHoleDiameter = 6;
fanPlaneWidth = 63;
fanPlaneDepth = 63;

//distance of the screwholes from the center of the fan plane
screwDistance = 25;

translate([0, 0, barrelHeight]){
    difference(){
        cube([fanPlaneWidth, fanPlaneDepth, fanPlaneHeight], center = true);
        
        translate([0,0,-3])
            linear_extrude(height = fanPlaneHeight + 2)
                circle(d = filterDiameter - 3);
        
        //extra Z-axis height is to make sure they go all the way through the plane
        translate([screwDistance, screwDistance, - 3])
            linear_extrude(height = fanPlaneHeight + 2)
                circle(d = screwHoleDiameter);
        
        translate([-screwDistance, screwDistance, - 3])
            linear_extrude(height = fanPlaneHeight + 2)
                circle(d = screwHoleDiameter);
        
        translate([screwDistance, -screwDistance, - 3])
            linear_extrude(height = fanPlaneHeight + 2)
                circle(d = screwHoleDiameter);
        
        translate([-screwDistance, -screwDistance, - 3])
            linear_extrude(height = fanPlaneHeight + 2)
                circle(d = screwHoleDiameter);
    }
}