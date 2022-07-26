#!/bin/bash

openscad -o ../Geigerzaehler_body.stl Body.scad
openscad -o ../Geigerzaehler_battery.stl Battery.scad
openscad -o ../Geigerzaehler_display.stl Display.scad
