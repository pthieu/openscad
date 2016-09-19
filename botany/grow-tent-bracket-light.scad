//General
$fn = 72;
tolerance = 0.5;
wall = 3; // wall is actually *2 this

r_pipe = 24.1/2+tolerance/2; // includes pipe wall
l_pipe_hole = 25.4+r_pipe+wall;

r_outter = r_pipe+wall;

translate([r_outter,r_outter,r_outter]) {
  rodEntry();
  rotate([0,90,0])
  rotate([0,0,-90])
  rodEntry();
  rotate([90,0,0])
  rotate([0,0,90])
  rodEntry();
  sphere(r=r_outter);
}

module rodEntry(){
  difference(){
    cylinder(r=r_outter, h=l_pipe_hole);
    translate([0,0,r_outter])
    cylinder(r=r_pipe, h=l_pipe_hole);
    // Below is the m3 holes
    translate([0,0,l_pipe_hole/1.5])
    rotate([90,0,0])
    cylinder(r=1.5+tolerance/2, h=r_outter*2);
    translate([0,0,l_pipe_hole/1.5])
    rotate([0,90,0])
    cylinder(r=1.5+tolerance/2, h=r_outter*2);
  }
}