//General
$fn = 72;
tolerance = 0.5;
wall = 2;

rotate([-90,0,0])
clip();

module clip() {
  h_bar = wall*2 + 6.1;
  l_bar = 26.4 + wall*2; // length of metal + extra space after and before
  depth_bar = 5;

  r_holder = 105/2; // dimensions of bag holder
  r_holder_outter = r_holder+28.4;
  h_holder = wall;

  // this is the side bar clip
  // color("blue")
  // difference(){
  //   cube([l_bar, depth_bar, h_bar+wall*2]); // outter clip
  //   translate([-wall,0,wall-tolerance/2])
  //   cube([l_bar, depth_bar, h_bar+tolerance]); // spacing of metal bar
  // }
  // this is the extension of the side clip into the circular clip
  // translate([l_bar,0,0])
  // cube([28.4, depth_bar, h_bar+wall*2]);
  
  // Below is the clip for the circular garbage bag holder
  // top plate
  color("blue")
  translate([r_holder_outter+l_bar-wall,0,h_bar+wall])
  garbageHolder();
  // bottom plate
  translate([r_holder_outter+l_bar-wall,0,0])
  garbageHolder();
  // middle portion
  translate([r_holder_outter+l_bar-wall,0,wall])
  difference(){
    cylinder(r=r_holder+wall, h=h_bar);
    killOutsideQuarters();
    color("red")
    cylinder(r=r_holder, h=h_bar);
  }

  l_clip_holster = 10;
  w_clip_holster = l_clip_holster;
  h_clip_holster = wall*2;
  // screw holster
  translate([r_holder_outter+l_bar-wall-r_holder,-l_clip_holster,0]){
    difference(){
      cube([l_clip_holster,w_clip_holster,h_clip_holster]);
      translate([l_clip_holster/2,l_clip_holster/2])
      cylinder(r=1.5,h=h_clip_holster); // m3 slot
    }
  }

  module garbageHolder(){
    difference(){
      union(){
        cylinder(r=r_holder_outter, h=h_holder);
      }
      killOutsideQuarters();
    }
  }

  module killOutsideQuarters() {
    // Below cubes to kill off 3 quarters of the circle
    cylinder(r=r_holder, h=h_bar);
    color("purple")
    rotate([0,0,-45])
    translate([0,-r_holder_outter,0])
    cube([r_holder_outter*2,r_holder_outter*2,h_bar+wall*2]);
    translate([-r_holder_outter,0,0])
    cube([r_holder_outter*2,r_holder_outter*2,h_bar+wall*2]);
    color("red")
    cylinder(r=r_holder, h=h_holder);
  }
}