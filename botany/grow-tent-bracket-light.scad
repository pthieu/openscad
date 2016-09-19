//General
$fn = 72;
tolerance = 0.5;
wall = 3; // wall is actually *2 this

r_pipe = 24.1/2+tolerance/2; // includes pipe wall
l_pipe_hole = 25.4+r_pipe+wall;

r_corner = 3;
h_bracket = (r_pipe+wall)*2;

r_outter = r_pipe+wall;

translate([r_outter,r_outter,r_outter]) {
  rotate([0,0,90])
  rodEntry();
  rotate([0,90,90])
  rotate([0,0,-90])
  rodEntry(axisCorner=true, touchGround=true);
  rotate([90,-90,90])
  rotate([0,0,90])
  rodEntry(axisCorner=true, touchGround=true, rotateHoles=-90);
  sphere(r=r_outter);
}
union(){
  color("red")
  translate([r_corner,r_corner,0])
  cube([r_outter-r_corner,r_outter-r_corner,r_outter]);
  translate([0,r_corner,r_corner])
  cube([r_outter-r_corner,r_outter-r_corner,r_outter]);
  translate([r_corner,0,r_corner])
  cube([r_outter-r_corner,r_outter-r_corner,r_outter]);

  // Center piller cornering
  pillar();
  // Left bottom ground cornering
  color("red")
  translate([0,0,r_corner*2])
  rotate([0,90,0])
  pillar();
  color("red")
  translate([0,r_outter*2-r_corner*2,r_corner*2])
  rotate([0,90,0])
  pillar();

  // Left bottom ground cornering
  color("red")
  translate([0,0,r_corner*2])
  rotate([-90,0,0])
  pillar();
  color("red")
  translate([r_outter*2-r_corner*2,0,r_corner*2])
  rotate([-90,0,0])
  pillar();

}

module rodEntry(touchGround=false, axisCorner=true, rotateHoles=0){
  difference(){
    union(){
      cylinder(r=r_outter, h=l_pipe_hole);
      if (axisCorner){
        translate([-r_outter+r_corner,0,0])
        cube([r_outter-r_corner,r_outter,l_pipe_hole]);
        translate([-r_outter,0,0])
        cube([r_outter-r_corner,r_outter-r_corner,l_pipe_hole]);
      }
      if(touchGround){
        color("blue")
        translate([0,r_outter/2,0])
        cube([r_outter-r_corner,r_outter/2,l_pipe_hole]);
        color("blue")
        translate([r_outter/2,0,0])
        cube([r_outter/2,r_outter-r_corner,l_pipe_hole]);
      }
    }
    translate([0,0,r_outter])
    cylinder(r=r_pipe, h=l_pipe_hole);
    // Below is the m3 holes
    rotate([0,0,rotateHoles]){
      translate([0,0,l_pipe_hole/1.5])
      rotate([90,0,0])
      cylinder(r=1.5+tolerance/2, h=r_outter*2);
      translate([0,0,l_pipe_hole/1.5])
      rotate([0,90,0])
      cylinder(r=1.5+tolerance/2, h=r_outter*2);
    }
  }
}


module pillar(){
  translate([0,0,r_corner]){
    union(){
      // color("red")
      // translate([r_corner,r_corner,h_bracket])
      // sphere(r=r_corner);
      translate([r_corner,r_corner,0])
      cylinder(r=r_corner, h=l_pipe_hole+r_outter-r_corner);
      color("red")
      translate([r_corner,r_corner,0])
      sphere(r=r_corner);
    }
  }
}