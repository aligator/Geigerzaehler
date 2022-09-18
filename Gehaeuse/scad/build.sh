#!/bin/bash

openscad -o ../Geigerzaehler_body.stl Body.scad
openscad -o ../Geigerzaehler_battery.stl Battery.scad
openscad -o ../Geigerzaehler_display.stl Display.scad
openscad -o ../Geigerzaehler_mcuv3_frame.stl ControllerMCUv3Frame.scad
openscad -o ../Geigerzaehler_DISTANZ.stl Distance.scad
