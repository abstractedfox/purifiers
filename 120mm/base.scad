//Copyright 2024 Chris/abstractedfox.
//This work is not licensed for use as source or training data for any language model, neural network,
//AI tool or product, or other software which aggregates or processes material in a way that may be used to generate
//new or derived content from or based on the input set, or used to build a data set or training model for any software or
//tooling which facilitates the use or operation of such software.

include <root.scad>

translate([0, 0, baseHeight - (screwPlaneHeight / 2)]){
    difference(){
        screwPlane(size = enclosureDiameter, omitCutouts = false, overrideFilterCutout = maxInnerFilterDiameter);
        screwHoleCutouts(setScrewDistance = screwDistanceOuter);
    }
}

//spikes
spikeHeight = baseHeight - screwPlaneHeight;
module spike(xPos, yPos, zPos){
    translate([xPos, yPos, zPos]){
        rotate([180,0,0]){
            linear_extrude(height = zPos, scale = 0.3){
                circle(d = 10);
            }
        }
    }
}

spikeDistance = screwDistanceOuter - 6;
spike(spikeDistance, spikeDistance, spikeHeight);
spike(-spikeDistance, spikeDistance, spikeHeight);
spike(spikeDistance, -spikeDistance, spikeHeight);
spike(-spikeDistance, -spikeDistance, spikeHeight);

//Grate
fanGap = 0; //space between flow conditioner vanes and fan plane
extension = 0;
extensionDiameter = 38; //maximum diameter that the vanes can occupy inside the filter
grateCount = 8;

translate([0, 0, baseHeight - screwPlaneHeight]){
    for (a = [0 : grateCount - 1]) {
        rotate(a * 360 / grateCount - 22) {
            //note: offset of -0.5 is to prevent the grate elements from appearing 'twisty'
            translate([0, -0.5, 0]){
                linear_extrude(height = screwPlaneHeight){
                    square([(maxInnerFilterDiameter / 2) + 1, 1]);
                }
            }
        }
    }
        
    //grate circle
    linear_extrude(height=screwPlaneHeight - fanGap + extension){
        difference(){
            circle(d = (maxInnerFilterDiameter / 2) + 2);
            circle(d = maxInnerFilterDiameter / 2);
        }
    }
}
