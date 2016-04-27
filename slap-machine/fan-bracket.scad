//General
$fn=12;
tolerance = 0.6;

r_bar = (5+tolerance)/2; // Actual bar diameter is 3.7-3.8mm
h_bar = 3;

wall = 2;

r_sleeve = r_bar + wall;
h_sleeve = h_bar;

// rotate([0,90,0])
difference(){
  cylinder(r=r_sleeve, h=h_sleeve);
  cylinder(r=r_bar, h=h_bar);
  translate([0,-r_bar/4,0])
  cube([r_bar*3, r_bar/2, h_bar]);
}