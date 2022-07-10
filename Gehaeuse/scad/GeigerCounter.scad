screwHolesExtra=0.15;

$fs=0.1;
$fa=2;

module geigerBody() {   
    height=50;
    width=116;
    depth=71;
    borderWidth=3;
    spacerHeight=2;
    spacerDia=6;
    spacerPadding=1;
    screwDia=3;

    batteryWidth=56;
    batteryDepth=100;
    batteryHeight=23;
    
    // Some extra padding in X axis
    spacerPaddingX=-0.2;

    module box() {
        batteryScrewSize=8;
        module batteryScrew() {
            difference() {
                cube([batteryScrewSize, batteryScrewSize, batteryHeight]);
                #translate([batteryScrewSize/2, batteryScrewSize/2, borderWidth]) cylinder(h=batteryHeight, d=screwDia);
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
        
        module screwSpacer() {
            translate([0, 0, borderWidth]) cylinder(h=spacerHeight, d=spacerDia);
        }
        
        translate([spacerPadding + spacerPaddingX + borderWidth + spacerDia/2, spacerPadding + borderWidth + spacerDia/2, 0]) screwSpacer();
        translate([width - spacerDia/2-borderWidth - spacerPadding - spacerPaddingX, spacerPadding + borderWidth + spacerDia/2, 0]) screwSpacer();
        translate([width - spacerDia/2-borderWidth - spacerPadding - spacerPaddingX, depth - borderWidth - spacerDia/2 - spacerPadding, 0]) screwSpacer();
        translate([spacerPadding + spacerPaddingX + borderWidth + spacerDia/2, depth- borderWidth - spacerDia/2 - spacerPadding, 0]) screwSpacer();
    };
    
    module holes() {
        module screw() {
            translate([0, 0, -1])
            cylinder(h=spacerHeight+borderWidth+2, d=screwDia);
        }
        
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
        
        // lcd holder holes (one hole that goes through both sides)
        lcdHolderHoleDia=3.2;
        lcdHolderHoleFromTop=5;
        translate([-1, depth/2, borderWidth+height-borderWidth-lcdHolderHoleFromTop])
        rotate([0, 90, 0]) cylinder(d=lcdHolderHoleDia, h=width+2);
        
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

geigerBody();