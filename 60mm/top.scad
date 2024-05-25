//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

$fn = 350; //Amount of 'resolution' to give to shape primitives (less == more blocky, reduce if renders or the editor are too slow or if you just like blocky air purifiers)

filterDiameter = 60; //6cm
//irl filter height is 8.5cm

barrelHeight = 22;

//Barrel
linear_extrude(height = barrelHeight)
difference(){
    circle(d = filterDiameter + 2);
    circle(d = filterDiameter - 3);
}


numVanes = 8; //number of vanes

centerGap = 0; //space in the center where the vanes don't meet
fanGap = 13; //space between vanes and the topmost fan

rotateVanes = 22; //Amount of rotation to apply to the vanes, for aesthetic purposes
vaneThickness = 1;
vaneYOffset = -0.5; //This offset prevents the vanes from looking 'twisty'. You will probably need to modify this if you change the vane thickness

//Vanes
for (a = [0 : numVanes - 1]) {
    rotate(a * 360 / numVanes + rotateVanes) {
        translate([centerGap, vaneYOffset, 0])
        
            linear_extrude(height = barrelHeight - fanGap)
                square([(filterDiameter / 2), vaneThickness]);
    }
}

//Circle in the center of the grate; for aesthetics/making it harder to stick your fingers in
linear_extrude(height=barrelHeight - fanGap)
difference(){
    circle(d = filterDiameter/2 + 3);
    circle(d = filterDiameter/2);
}


//Fan attach
fanPlaneHeight = 4;
screwHoleDiameter = 7;
fanPlaneWidth = 63;
fanPlaneDepth = 63;

//distance of the screwholes from the center of the fan plane
screwDistance = 26;

translate([0, 0, barrelHeight])
difference(){
    difference(){
        cube([fanPlaneWidth, fanPlaneDepth, fanPlaneHeight], center = true);
        //to be honest, I'm not sure why we decided the cutout in the screw plane needed to be bigger than the barrel of the rest of the part. perhaps this was to accommodate for fit?
        translate([0,0,-3])
            linear_extrude(height = fanPlaneHeight + 2)
                circle(d = filterDiameter);
    }
    
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