use <text_on.scad>;

//General
$fn=12;
tolerance = 0.6;
wall = 2;

h_armBase = 2;
w_armBase = 15;
l_armBase = 180;

h_head = 9 + 10; // with of hand = 9, + 10mm for screws
w_head = w_armBase;
l_head = 30;

h_headSlot = h_head;
w_headSlot = 3.3 + tolerance;
l_headSlot = l_head;

cube([l_armBase, w_armBase, h_armBase]);
translate([0,0,h_armBase])
difference(){
  cube([l_head, w_head, h_head]);
  translate([l_head/2,w_head/2,h_headSlot/2])
  cube([l_headSlot, w_headSlot, h_headSlot], center=true);
}