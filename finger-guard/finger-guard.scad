//General
$fn = 72;
tolerance = 0.6;
wall = 2;

// Joint 1, closest to knuckles
r_L1_size = (16+tolerance)/2;
r_L1_tube = 5/2;

l_L1_legs  = 15+1;
w_L1_legs = 2;

l_L1_notch = 3;
r_L1_notch = 3/2;

w_finger_shell = 1.2;

l1Ring();
translate([0,0,l_L1_legs])
// rotate([180,0,0])
l2Ring();

// finger Tip Piece
module l2Ring(){
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
  cylinder(r=r_L1_notch, h = l_L1_notch);
  translate([r_L1_tube*2+r_L1_size-tolerance+l_L1_notch-1, 0, 0])
  sphere(r=r_L1_notch);
}

module l1Legs(){
  l1Leg();
  mirror([1,0,0])
  l1Leg();
}

module l1Leg(){
  translate([r_L1_tube+r_L1_size-w_L1_legs/2, -w_L1_legs, r_L1_tube-1])
  cube([w_L1_legs, w_L1_legs*2, l_L1_legs]);
}

module l2Legs(){
  l2Leg();
  mirror([1,0,0])
  l2Leg();
}

module l2Leg(){
  translate([w_L1_legs,0,0])
  l1Leg();
  translate([r_L1_tube+r_L1_size+w_L1_legs/2, 0, 0])
  rotate([0,90,0])
  difference(){
    cylinder(r=r_L1_notch+wall, h=l_L1_notch);
    cylinder(r=r_L1_notch+tolerance/2, h=l_L1_notch);
  }

  translate([r_L1_tube+r_L1_size-w_L1_legs, -w_L1_legs, r_L1_tube+l_L1_legs-1-w_L1_legs])
  cube([w_L1_legs*2, w_L1_legs*2, w_L1_legs]);
}

module l2Dome(){
  translate([0,0,-1])
  difference(){
    cylinder(r=r_L1_size+w_finger_shell, h=wall*2);
    cylinder(r=r_L1_size+tolerance/2, h=wall*2);
  }
}