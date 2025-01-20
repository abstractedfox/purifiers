//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

flowConditionerHeight = 50; //in mm
//$fn = 300;


linear_extrude(height = flowConditionerHeight){
    difference(){
        circle(d = filterDiameter + wallWidth);
        circle(d = filterDiameter);
    }
}

//Vanes
circleGapFromFilter = 15; //Distance of the inner circles (colored green in the editor viewer) from where the filter starts 
smallestCircle = filterDiameter - 44;
secondSmallestCircle = filterDiameter - 33;

centerGap = (smallestCircle / 2) - 1; //space in the center where the vanes don't meet
extraVanesCenterGap = (secondSmallestCircle / 2) - 1; //-1 to make sure the geometry intersects

fanGap = 0; //space between flow conditioner vanes and fan plane
extension = 25; //depth to extend the vanes below the housing of the flow conditioner

vaneThiccness = 1;
vaneYOffset = -1; //This offset prevents the vanes from looking 'twisty'. You will probably need to modify this if you change the vane thickness


//Screw planes
translate([0, 0, flowConditionerHeight - (screwPlaneHeight / 2)]){
    screwPlane(size = fanPlaneWidth, omitCutouts = false, setScrewDistance = screwDistanceDefault);
}

//We'll use the same parameters that dictate the size of the size of the screw planes for the filter housing so they'll look nicer together
translate([0, 0, screwPlaneHeight / 2]){
    screwPlane(size = filterSpace + wallWidth, omitCutouts = false, setScrewDistance = screwDistanceDefault);
}


//Shroud
//Hopefully this makes more air go through the filter instead of around it
union(){
    translate([0, 0, -shroudDepth]){
        linear_extrude(height = shroudDepth){
            difference(){
                circle(d = maxInnerFilterDiameter);
                circle(d = maxInnerFilterDiameter - vaneThiccness);
            }
        }
    }

    linear_extrude(height = 1){
        difference(){
            circle(d = filterDiameter);
            circle(d = maxInnerFilterDiameter - vaneThiccness);
        }
    }
}


//Choke factor is the multiple by which the cross section is resized
chokeFactor = 0.7;
linear_extrude(height = 30, scale = chokeFactor){
    difference(){
        circle(d = maxInnerFilterDiameter);
        circle(d = maxInnerFilterDiameter - (vaneThiccness/chokeFactor));
    }
}

