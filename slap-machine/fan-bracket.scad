//General
$fn=72;
tolerance = 0.6;
wall = 2;

// Pole Bracket
r_pole = 10 + tolerance/2;
r_poleWrapper = r_pole + wall+1;
h_poleWrapper = 80; // Full size 80

// Fan head bracket
w_slit = 2;
r_fanHeadBracket = (40+tolerance)/2; // Actual bar diameter is 3.7-3.8mm
h_fanHeadBracket = 3;

z_poleWrapper = 3; // Pole Bracket

// Fin shape of fan
w = 0.5; // width of each slice in curve
depth_fanHeadBracketFin = 8; // how deep curve is (or how fat)
// translate([0,0,16]) {
//   fanHeadBracket();
//   translate([0,0,z_poleWrapper])
//   poleBracket();
// }
fanAdapter();

module fanAdapter(){
  r=(33.3+tolerance)/2;
  h=15;

  h_shell = 10;
  r_shell = r_fanHeadBracket-tolerance/2+0.15; //thickness of outter shell
  w_leg = 8;
  depth_leg = 4;

  r_axle = (4+tolerance)/2; // radius of the motor's axle
  h_axle = 27;
  w_slit = wall*2+0.1; // width of slit in axle, to give some tolerance

  l_axleSupport = r_shell*2-1;
  w_axleSupport = wall;
  h_axleSupport = h_shell-wall;

  // inner bracket on motor axle
  difference(){
    union(){
      cylinder(r=r_axle+wall*2, h=h_axle);
      axleSupport();  
      rotate([0,0,120])
      axleSupport();  
      rotate([0,0,240])
      axleSupport();  
    }
    translate([0,0,2])
    cylinder(r=r_axle, h=h_axle);
  }
  module axleSupport(){
    translate([-l_axleSupport/2,-w_axleSupport/2,0])
    cube([l_axleSupport,w_axleSupport,h_axleSupport]);
  }

  // Outter shell of axle bracket
  difference(){
    union(){
      translate([0,0,-2])
      cylinder(r=r_shell, h=h_shell);
    }
    cylinder(r=r, h=h);
    color("blue")
    difference(){
      cylinder(r=r_shell+10, h=h_shell+50);
      cylinder(r=r_shell, h=h_shell+50);
    }
  }
}

module poleBracket() {
  difference(){
    cylinder(r1=r_fanHeadBracket+wall, r2=r_poleWrapper, h=h_poleWrapper);
    cylinder(r=r_pole, h=h_poleWrapper);
  }
}

module fanHeadBracket() {
  difference() {
    union() {
      cylinder(r=r_fanHeadBracket, h=h_fanHeadBracket);
      // Fan head bracket wall
      cylinder(r=r_fanHeadBracket+2, h=h_fanHeadBracket);
      // Fan head bracket fins
      fanHeadBracketFin();
      rotate([0,0,90])
      fanHeadBracketFin();
      rotate([0,0,180])
      fanHeadBracketFin();
      rotate([0,0,270])
      fanHeadBracketFin();
    }
    // cylinder(r=r_fanHeadBracket-wall, h=h_fanHeadBracket);
    // Slit in ring
    // translate([0,-w_slit/2,0])
    // rotate([0,0,-47.5])
    // cube([r_fanHeadBracket*3, w_slit, h_fanHeadBracket]);
    // Under fan head, makes circular clearing
    color("blue")
    translate([0,0,-h_fanHeadBracket*10])
    cylinder(r=r_fanHeadBracket, h=h_fanHeadBracket*10);
  }
}

module fanHeadBracketFin() {
  z_fin_offset = 3; // z offset of fins
  a = 28; // wideness/2
  b = 11+z_fin_offset; // height/2
  h = 1; // height of slices in curve
  w_bladeHook = 5;
  h_bladeHook = 5;
  h_bladeHookSlot = 3.5;
  translate([-a/2,-r_fanHeadBracket+depth_fanHeadBracketFin/2,z_fin_offset]){
    rotate([180,0,0])
    hull() {
      fanBladeHullStick();
      for(x=[0:7:a]) {
        y = sqrt((pow(a*b,2)-pow(b*x,2))/pow(a,2));
        translate([x,0,y])
        fanBladeHullStick();
      }
    }
    translate([0, -depth_fanHeadBracketFin+2, -b-w/2-h_bladeHook])
    color("red")
    difference() {
      cube([w_bladeHook, depth_fanHeadBracketFin, h_bladeHook]);
      translate([wall+1, 0, (h_bladeHook -h_bladeHookSlot)])
      cube([w_bladeHook, depth_fanHeadBracketFin, h_bladeHookSlot]);
    }
  }
}

module fanBladeHullStick() {
  r = w/2;
  translate([r,-depth_fanHeadBracketFin/2,r])
  rotate([-90,0,0])
  cylinder(r=r, h=depth_fanHeadBracketFin+2);
}
