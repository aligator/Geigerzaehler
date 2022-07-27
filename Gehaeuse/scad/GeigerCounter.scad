use <ESP8266Models.scad>

screwHolesExtra=0.15;

$fs=0.1;
$fa=2;

height=50;
width=116;
depth=71;
spacerHeight=2;
spacerDia=6;
spacerPadding=1;
screwDia=3;

// Some extra padding in X axis (to be more like the orignal)
spacerPaddingX=-0.2;

borderWidth=3;

batteryWidth=56;
batteryDepth=100;
batteryHeight=23;
batteryCapHeight=borderWidth;
batteryScrewDia=screwDia;
batteryScrewSize=8;

displayScrewDia=3.2;
displaySpacerPositionX=11.25;
displaySpacerPositionY=8;
displaySpacerHeight=7;
displaySpacerDia=10;
displayCenterHoleWidth=98;
displayCenterHoleDepth=41;
displayHolderHoleDia=3.2;
displayHolderHoleDiaInner=screwDia;
displayHolderHoleFromTop=5;
displayHolderWidth=5;
displayHolderDepth=20;
displayHolderHeight=displayHolderHoleFromTop*2;

controllerWidth=100;
controllerDepth=65;

module batteryScrewHole() {
    translate([batteryScrewSize/2, batteryScrewSize/2, borderWidth])
        cylinder(h=batteryHeight, d=batteryScrewDia);
}

module geigerBody() {
    module screw() {
        translate([0, 0, -1])
        cylinder(h=spacerHeight+borderWidth+2, d=screwDia);
    }
    module screwSpacer() {
        translate([0, 0, borderWidth]) cylinder(h=spacerHeight, d=spacerDia);
    }
    module box() {
        module batteryScrew() {
            difference() {
                cube([batteryScrewSize, batteryScrewSize, batteryHeight]);
                batteryScrewHole();
            }
        }
        
        difference() {
            union() {
                cube([width, depth, height]);
                
                translate([borderWidth + width/2-batteryWidth/2-borderWidth, depth, 0]) {
                    cube([batteryWidth, batteryDepth, batteryHeight]);
                }
            }
                
            translate([borderWidth, borderWidth, borderWidth])
            cube([
                width-2*borderWidth, 
                depth-2*borderWidth, 
                height
            ]);
            
            translate([borderWidth + width/2-batteryWidth/2, depth+borderWidth, borderWidth]) {
                cube([
                    batteryWidth-2*borderWidth, 
                    batteryDepth-2*borderWidth, 
                    batteryHeight
                ]);
                
                batteryInnerCutoutWidth=batteryWidth-2*borderWidth-2*batteryScrewSize;
                translate([batteryScrewSize, -borderWidth, 0])
                cube([batteryInnerCutoutWidth, borderWidth+1, batteryHeight]);
            }
        };
        
        cube();
        
        translate([borderWidth + width/2-batteryWidth/2-borderWidth, depth, 0]) {
                translate([borderWidth, borderWidth, 0]) batteryScrew();
                translate([batteryWidth-borderWidth-batteryScrewSize, borderWidth, 0]) batteryScrew();
                translate([batteryWidth-borderWidth-batteryScrewSize, batteryDepth-borderWidth-batteryScrewSize, 0]) batteryScrew();
                translate([borderWidth, batteryDepth-borderWidth-batteryScrewSize, 0]) batteryScrew();
            }
        
        
        
        translate([spacerPadding + spacerPaddingX + borderWidth + spacerDia/2, spacerPadding + borderWidth + spacerDia/2, 0]) screwSpacer();
        translate([width - spacerDia/2-borderWidth - spacerPadding - spacerPaddingX, spacerPadding + borderWidth + spacerDia/2, 0]) screwSpacer();
        translate([width - spacerDia/2-borderWidth - spacerPadding - spacerPaddingX, depth - borderWidth - spacerDia/2 - spacerPadding, 0]) screwSpacer();
        translate([spacerPadding + spacerPaddingX + borderWidth + spacerDia/2, depth- borderWidth - spacerDia/2 - spacerPadding, 0]) screwSpacer();
    };
    
    module holes() {
        translate([spacerPadding + spacerPaddingX + borderWidth + spacerDia/2, spacerPadding + borderWidth + spacerDia/2, 0]) screw();
        translate([width - spacerDia/2-borderWidth - spacerPadding - spacerPaddingX, spacerPadding + borderWidth + spacerDia/2, , 0]) screw();
        translate([width - spacerDia/2-borderWidth - spacerPadding - spacerPaddingX, depth - borderWidth - spacerDia/2 - spacerPadding, 0]) screw();
        translate([spacerPadding + spacerPaddingX + borderWidth + spacerDia/2, depth - borderWidth - spacerDia/2 - spacerPadding, 0]) screw();
        
        // holes for the geiger counter module
        // power connector
        translate([width-borderWidth-1, borderWidth+36, borderWidth+5.5])
        cube([borderWidth+2, 11, 12]);
        
        // switch
        translate([width-borderWidth-1, borderWidth+26, borderWidth+12])
        cube([borderWidth+2, 9, 5]);
        
        // headphone connector
        headphoneHoleDia=8;
        headphoneHoleFromBottom=6.2;
        headphoneHoleY=48.5;
        headphoneHoleZ=14;
        translate([-1, borderWidth+headphoneHoleY, borderWidth+headphoneHoleZ])
        rotate([0, 90, 0]) cylinder(d=headphoneHoleDia, h=borderWidth+2);
        
        translate([2, headphoneHoleY-headphoneHoleDia/2+borderWidth, borderWidth+headphoneHoleZ])
        cube([borderWidth, headphoneHoleDia, height]);
        
        // display holder holes (one hole that goes through both sides)

        translate([-1, depth/2, borderWidth+height-borderWidth-displayHolderHoleFromTop])
        rotate([0, 90, 0]) cylinder(d=displayHolderHoleDia, h=width+2);
        
        // tubeCutout
        tubeCutoutWidth=80;
        translate([width / 2 - tubeCutoutWidth / 2, borderWidth + 5, 1.5])
        cube([80, 15, borderWidth]);
        
        // espUSBCutout
        translate([borderWidth + 24.4, -1, borderWidth + 28])
        cube([14, borderWidth+2, 7]);
        
        // batteryCableCutout (note the cutout in the original stl was not centered perfectly, now it is.)
        batteryCableCutoutWidth=13;
        batteryCableCutoutHeight=20;
        translate([width/2-batteryCableCutoutWidth/2, -1 + depth - borderWidth, borderWidth])
        cube([batteryCableCutoutWidth, borderWidth+2, batteryCableCutoutHeight]);
    }
    
    difference() {
        box();
        holes();
    }
}

module geigerBattery() {
    difference() {
        cube([batteryWidth, batteryDepth, batteryCapHeight]);
        translate([borderWidth, borderWidth, -borderWidth-1]) batteryScrewHole();
        translate([batteryWidth-borderWidth-batteryScrewSize, borderWidth, -borderWidth-1]) batteryScrewHole();
        translate([batteryWidth-borderWidth-batteryScrewSize, batteryDepth-borderWidth-batteryScrewSize, -borderWidth-1]) batteryScrewHole();
        translate([borderWidth, batteryDepth-borderWidth-batteryScrewSize, -borderWidth-1]) batteryScrewHole();
    }
}

module displayScrew() {
    translate([0, 0, -1])
    cylinder(h=displaySpacerHeight+borderWidth+2, d=displayScrewDia);
}

module displayHoles() {
    translate([displaySpacerPositionX, displaySpacerPositionY, 0]) displayScrew();
    translate([width - displaySpacerPositionX, displaySpacerPositionY, 0]) displayScrew();
    translate([width - displaySpacerPositionX, depth - displaySpacerPositionY, 0]) displayScrew();
    translate([displaySpacerPositionX, depth - displaySpacerPositionY, 0]) displayScrew();
}

module geigerDisplay() {
    
    module displayScrewSpacer() {
        translate([0, 0, borderWidth]) cylinder(h=displaySpacerHeight, d=displaySpacerDia);
    }
    
    difference() {
        union() {
            translate([displaySpacerPositionX, displaySpacerPositionY, 0]) displayScrewSpacer();
            translate([width - displaySpacerPositionX, displaySpacerPositionY, 0]) displayScrewSpacer();
            translate([width - displaySpacerPositionX, depth - displaySpacerPositionY, 0]) displayScrewSpacer();
            translate([displaySpacerPositionX, depth - displaySpacerPositionY, 0]) displayScrewSpacer();
            cube([width, depth, borderWidth]);
        }
        displayHoles();
        
        // center hole
        translate([width/2 - displayCenterHoleWidth/2, depth/2 - displayCenterHoleDepth/2, -1])
            cube([displayCenterHoleWidth, displayCenterHoleDepth, borderWidth+2]);
    }
            
    // side holder
    module displayHolder() {
        difference() {
            cube([displayHolderWidth, displayHolderDepth, displayHolderHeight]);
            translate([-1, displayHolderDepth/2, displayHolderHoleFromTop]) {
                rotate([0, 90, 0]) cylinder(d=displayHolderHoleDiaInner, h=width+2);
            }
        }
    }
    translate([borderWidth, depth/2 - displayHolderDepth/2, borderWidth])
        displayHolder();
    translate([width-borderWidth-displayHolderWidth, depth/2 - displayHolderDepth/2, borderWidth])
        displayHolder();
}

module controllerFrameBase() {
    difference() {  
        cube([controllerWidth, controllerDepth, borderWidth]);
        // Base the controller board holes on the display-holder hole position
        translate([-(width - controllerWidth) / 2, -(depth - controllerDepth) / 2, 0])
            displayHoles();
    }
}

module mcuFrame() {
    mcuCutoutWidth=59;
    mcuCutoutDepth=53;
    
    difference() {  
        controllerFrameBase();
        translate([controllerWidth-mcuCutoutWidth, controllerDepth-mcuCutoutDepth, -1]) {
            cube([mcuCutoutWidth+1, mcuCutoutDepth+1, borderWidth+2]);
        }
        
        translate([24, 35, 0]) {
            for (i = [0 : 3]) {
                NodeMCU_LV3_HolesLocate(i) {
                    translate([0, 0, -1])
                        cylinder(h=5, d=3);
                }
            }
        }
    }
}

translate([200, 0, 0])
    geigerBody();

translate([0, 100, 0])
    geigerBattery();

translate([0, -100, 0])
    geigerDisplay();

!mcuFrame();