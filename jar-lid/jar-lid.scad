//Title: Canning Jar Lid
//Author: Alex English - ProtoParadigm
//Date: 3-13-2012
//License: GPL2

//Notes: This uses Thread Library by syvwlch (http://www.thingiverse.com/thing:8793).  This file and the thread library file need to be in the same directory, or the path below changed to reflect the location of the thread library.  The main module to be used here is cap, which creates a lid for a canning jar.  It must be passed either the reg or wide variable, to create a lid for a regular, or a wide mouth canning jar.  If printed well, and well tightened, this lid is water tight, but not air tight.  The main shape of the lid is deliberately low-poly so it is easy to grip.  This lid is suitable for use in storing dry goods, non-food small parts, etc., for storing opened canned goods in the refrigerator, and probably for use in the freezer.  Additional accessories will be released that use this lid as the base.

include <Thread_Library.scad>;

$fn=72;

reg = 121 / 2; // Regular Mouth Jar Cap Inner Radius // 91mm for 3", 121mm for 3.75"
InnerBucketHole = 93; // 77mm for 3" buckets, probably 93mm for 3.75"
// wide = 87 / 2; // Wide Mouth Jar Cap Inner Radius
wall_thickness = 2;
cap_depth = 13; // 13mm for smaller cap 20mm for large whey cap
ring_height = cap_depth + wall_thickness;
thread_height = 20; // this is how much thread protrudes out i think
thread_quality = 45; //~10 for draft, 45, 60,72, or 90 for higher qualities, higher numbers dramatically increase render time, and increase the poly count, wich will increase file sizes and slicing times, but will make smoother curves

module ring (rad)
{
    difference()
    {
      cylinder(r=(rad+wall_thickness), cap_depth, $fa=30);
      trapezoidThreadNegativeSpace(length=cap_depth + wall_thickness, pitch=6, // 6 for the bcaa bucket cap, 6 for large whey cap
        pitchRadius=(rad-1.524), threadHeightToPitch=(1.524/6.35), profileRatio=1.66,
        threadAngle=30, RH=true, countersunk=0, clearance=0.1, backlash=0.1,
        stepsPerTurn=thread_quality); //threads and hole
    }
}

module cap(rad)
{
    translate([0,0,ring_height]) rotate([180, 0, 0]) difference()
    {
      union()
      {
        ring(rad); //Outer ring with threads
        translate([0,0,cap_depth]) {
          difference(){
            cylinder(r=(rad+wall_thickness), wall_thickness, $fa=30); //top surface
            cylinder(r=InnerBucketHole/2, wall_thickness*2, $fa=30); //top surface
          }
        }
      }
      translate([0, 0, ring_height]) rotate_extrude(convexity=10, $fa=1) translate([rad+wall_thickness, 0, 0]) rotate([0,0,40]) scale([wall_thickness, wall_thickness*2]) square(1, true); //chamfer on top edge
    }
}

cap(reg);
//cap(wide);
