use <../libraries/text_on_OpenSCAD/text_on.scad>;

//General
$fn = 72;
tolerance = 0.6;
wall = 2;

// Joint 1, closest to knuckles
r_L1_size = (16+tolerance)/2;
r_L1_tube = 5/2;

l_L1_legs  = 15+1;
w_L1_legs = 2;
l_L1_back_legs = 9+1;

l_L1_notch = 3;
r_L1_notch = 3/2;

l_L3_legs = 5;
h_L3_bracket = 10;
r_L3_size = (18+tolerance)/2;

w_finger_shell = 1.2;

r_finger_shell = r_L1_size;

// l1Ring();
// translate([0,0,l_L1_legs])
// // rotate([180,0,0])
// l2Ring();
// translate([0,0,-l_L1_back_legs])
l3Ring();

// piece after knuckle
module l3Ring(){
  l3Legs();
  // rotate([-60,0,0])
  l3Bracket();
};

// finger Tip Piece
module l2Ring(){
  color("blue")
  translate([-(r_L1_tube+r_L1_size+w_L1_legs*2-1), 0, 10.15])
  rotate([0,-90,0])
  text_extrude("PGT",size=6,extrusion_height=3, center=true);
  l2Legs();
  translate([0,0,l_L1_legs])
  l2Dome();
}

// L1 Ring
module l1Ring(){
  rotate_extrude(angle = 360, convexity = 10)
  translate([r_L1_tube+r_L1_size, 0, 0])
  circle(r = r_L1_tube);

  l1Legs();
  l1BackLegs();

  translate([0,0,l_L1_legs])
  l1Notches();
}

module l1Notches(){
  l1Notch();
  mirror([1,0,0])
  l1Notch();
}

module l1Notch(){
  // side notches
  translate([r_L1_tube*2+r_L1_size-tolerance-1, 0, 0])
  rotate([0,90,0])
  cylinder(r=r_L1_notch-tolerance/3, h = l_L1_notch);
  translate([r_L1_tube*2+r_L1_size-tolerance+l_L1_notch-1, 0, 0])
  sphere(r=r_L1_notch-tolerance/3);
}

module l1Legs(){
  l1Leg();
  mirror([1,0,0])
  l1Leg();

  l1LegSupport();
  mirror([1,0,0])
  l1LegSupport();
}

module l1LegSupport(){
  translate([r_L1_tube*2+r_L1_size-w_L1_legs,0,r_L1_tube])
  rotate([0,72,0])
  cube([w_L1_legs*1.5, w_L1_legs*3, w_L1_legs], center=true);
}
module l1Leg(){
  translate([r_L1_tube+r_L1_size-w_L1_legs/2, -w_L1_legs*1.5, r_L1_tube])
  cube([w_L1_legs, w_L1_legs*3, l_L1_legs]);
}

module l1BackLeg(){
  rotate([180,0,0])
  translate([r_L1_tube+r_L1_size-w_L1_legs/2, -w_L1_legs*1.5, r_L1_tube-1])
  cube([w_L1_legs, w_L1_legs*3, l_L1_back_legs]);
  translate([0,0,-l_L1_back_legs])
  l1Notches();
}

module l1BackLegs(){
  l1BackLeg();
  mirror([1,0,0])
  l1BackLeg();

  rotate([180,0,0]){
    l1LegSupport();
    mirror([1,0,0])
    l1LegSupport();
  }
}

module l2Legs(){
  l2Leg();
  mirror([1,0,0])
  l2Leg();
}

module l2Leg(){
  // legs
  difference(){
    translate([w_L1_legs,0,-1])
    l1Leg();
    translate([r_L1_tube+r_L1_size+w_L1_legs/2, 0, 0])
    rotate([0,90,0])
    cylinder(r=r_L1_notch+tolerance/1.5, h=l_L1_notch);
  }
  // Sockets/notch holders
  translate([r_L1_tube+r_L1_size+w_L1_legs/2, 0, 0])
  rotate([0,90,0])
  difference(){
    cylinder(r=r_L1_notch+wall, h=l_L1_notch);
    cylinder(r=r_L1_notch+tolerance/1.5, h=l_L1_notch);
  }
  translate([r_L1_tube+r_L1_size-w_L1_legs, -w_L1_legs*1.5, r_L1_tube+l_L1_legs-1-w_L1_legs])
  cube([w_L1_legs*2, w_L1_legs*3, w_L1_legs]);
}

module l2Dome(){
  translate([0,0,-wall*4-1])
  difference(){
    cylinder(r=r_L1_size+w_finger_shell, h=wall*6);
    translate([0,0,-0.001])
    cylinder(r=r_L1_size+tolerance/2, h=wall*6+0.01);
    // bottom finger cutout
    translate([0,-10,0])
    scale([1.5,1,1])
    sphere(r=6);
  }
  translate([0,0,wall*2-1.1])
  difference(){
    sphere(r=r_L1_size+w_finger_shell);
    sphere(r=r_L1_size+tolerance/2);
    translate([0,0,-15/2])
    cube([30,30,15], center=true);
  }
}

module l3Legs(){
  l3Leg();
  mirror([1,0,0])
  l3Leg();
}

module l3Leg(){
  rotate([180,0,0])
  difference(){
    translate([w_L1_legs+r_L1_tube+r_L1_size-w_L1_legs/2, -w_L1_legs*1.5, r_L1_tube-1])
    cube([w_L1_legs, w_L1_legs*3, l_L3_legs]);
    // holes in legs
    translate([r_L1_tube+r_L1_size+w_L1_legs/2, 0, 0])
    rotate([0,90,0])
    cylinder(r=r_L1_notch+tolerance/1.5, h=l_L1_notch);
  }
  // support notches/holes
  translate([r_L1_tube+r_L1_size+w_L1_legs/2, 0, 0]){
    rotate([0,90,0])
    difference(){
      cylinder(r=r_L1_notch+wall, h=l_L1_notch);
      cylinder(r=r_L1_notch+tolerance/1.5, h=l_L1_notch);
    }
    translate([-w_L1_legs,-w_L1_legs*1.5,-l_L3_legs-r_L1_tube])
    cube([w_L1_legs*2, w_L1_legs*3, w_L1_legs]);
  }
}

module l3Bracket(){
  translate([0,0,-h_L3_bracket/1.5])
  difference(){
    translate([0,0,-l_L3_legs-r_L1_tube/2])
    difference(){
      cylinder(r=r_L3_size+wall/2, h=h_L3_bracket);
      translate([0,0,-0.001])
      cylinder(r=r_L3_size, h=h_L3_bracket+0.002);
    }
    // slot at bottom of finger
    translate([0,-r_L3_size-1,-r_L1_tube/2])
    cube([r_L3_size*1.25,r_L3_size,h_L3_bracket+0.001], center=true);
  }
}