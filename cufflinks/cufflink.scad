//General
$fn=18;
tolerance = 0.6;
wall = 2;

r_stop = 2;
l_stop = 14/2 - r_stop; // full link length minus radius of ends
depth_stop = 2;

import("dickbutt.stl");

// import("cufflink-dice.stl");
// difference(){
//   translate([0,1,19])
//   rotate([0,-55,0])
//   rotate([0,0,45])
//   cube([15,15,15], center=true);
// }