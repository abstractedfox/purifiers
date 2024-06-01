//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

$fn = 50; //overriding this since the editor can be very slow with this part at high $fn, but it's recommended to comment it out and use the one inherited from root.scad when you go to actually export

flowConditionerHeight = 35; //in mm

maxwidth = fanPlaneWidth; //max width of the whole enclosure, affects screw plane dimensions

linear_extrude(height = flowConditionerHeight){
    difference(){
        circle(d = filterDiameter + wallWidth);
        circle(d = filterDiameter);
    }
}

//Vanes
circleGapFromFilter = 15; //Distance of the 'circles' from the filter
smallestCircle = filterDiameter - 44;
secondSmallestCircle = filterDiameter - 33;

centerGap = (smallestCircle / 2) - 1; //space in the center where the vanes don't meet
extraVanesCenterGap = (secondSmallestCircle / 2) - 1; //-1 to make sure the geometry intersects

fanGap = 0; //space between flow conditioner vanes and fan plane
extension = 25; //depth to extend the vanes below the housing of the flow conditioner
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter

vaneThiccness = 1;
vaneYOffset = -1; //This offset prevents the vanes from looking 'twisty'. You will probably need to modify this if you change the vane thickness

//clarity note: This difference() creates the 'extension' area of the vanes below the rest of the flow conditioner, it masks out the area of the vanes that would otherwise intersect with the filter
difference(){
    for (a = [0 : numVanes - 1]) {
        rotate(a*360/numVanes) {
            translate([centerGap, vaneYOffset, -extension]) 
                cube([(filterDiameter / 2) - centerGap, vaneThiccness, flowConditionerHeight - fanGap + extension]);
        }
    }
    
    translate([0, 0, -extension]){ //extra - 1 to eliminate plane fighting
        linear_extrude(height = extension){
            difference(){
                circle(d = filterDiameter + 2);
                circle(d = extensionDiameter);
            }
        }
    }
}

//Extra vanes
color([1, 0, 0]){ 
    for (a = [0 : numVanes - 1]){
        rotate(a*360/numVanes + 23){
            translate([extraVanesCenterGap, -1]){
                cube([(filterDiameter / 2) - extraVanesCenterGap, vaneThiccness, flowConditionerHeight - fanGap]);
            }
        }
    }
}

//Circles!!
module insideCircle(diameter){
    circleThickness = 2;
    difference(){
        circle(d = diameter);
        circle(d = diameter - circleThickness);
    }
}

color([0, 1, 0, 0.5]){
    translate([0, 0, circleGapFromFilter]){
        linear_extrude(height = flowConditionerHeight - fanGap - circleGapFromFilter){
            insideCircle(filterDiameter - 12);
            insideCircle(filterDiameter - 22);
            insideCircle(secondSmallestCircle);
            insideCircle(smallestCircle);
        }
    }
}

//Screw planes
translate([0, 0, flowConditionerHeight - (screwPlaneHeight / 2)]){
    screwPlane(size = fanPlaneWidth, omitCutouts = false, setScrewDistance = screwDistance);
}

//We'll use the same parameters that dictate the size of the size of the screw planes for the filter housing so they'll look nicer together
translate([0, 0, screwPlaneHeight / 2]){
    screwPlane(size = filterSpace + wallWidth, omitCutouts = false, setScrewDistance = screwDistance);
}


//Shroud
//Hopefully this makes more air go through the filter instead of around it
shroudDepth = 10;
union(){
    translate([0, 0, -shroudDepth]){
        linear_extrude(height = shroudDepth){
            difference(){
                circle(d = extensionDiameter);
                circle(d = extensionDiameter - vaneThiccness);
            }
        }
    }

    //color([0, 0, 0, 0.8])

    linear_extrude(height = 1){
        difference(){
            circle(d = filterDiameter);
            circle(d = extensionDiameter);
        }
    }
}