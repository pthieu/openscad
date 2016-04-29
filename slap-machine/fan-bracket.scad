//General
$fn=72;
tolerance = 0.6;

r_bar = (40+tolerance)/2; // Actual bar diameter is 3.7-3.8mm
h_bar = 3;
w_slit = 2;
wall = 2;

r_sleeve = r_bar;
h_sleeve = h_bar;

// Fin shape of fan
w = 0.5; // width of each slice in curve
depth = 7; // how deep curve is (or how fat)

fanHeadBracket();

module fanHeadBracket(){
  difference(){
    union(){
      cylinder(r=r_sleeve, h=h_sleeve);
      // Fan head bracket wall
      cylinder(r=r_sleeve+2, h=h_sleeve);
      // Fan head bracket fins
      fanHeadBracketFin();
      rotate([0,0,90])
      fanHeadBracketFin();
      rotate([0,0,180])
      fanHeadBracketFin();
      rotate([0,0,270])
      fanHeadBracketFin();
    }
    // cylinder(r=r_bar-wall, h=h_bar);
    // Slit in ring
    translate([0,-w_slit/2,0])
    rotate([0,0,-45])
    cube([r_bar*3, w_slit, h_bar]);
    // Under fan head, makes circular clearing
    color("blue")
    translate([0,0,-h_bar*10])
    cylinder(r=r_bar, h=h_bar*10);
  }
}

module fanHeadBracketFin(){
  z_fin_offset = 3; // z offset of fins
  a = 28; // wideness/2
  b = 11+z_fin_offset; // height/2
  h = 1; // height of slices in curve
  w_bladeHook = 6;
  h_bladeHook = 4;
  h_bladeHookSlot = 2;
  translate([-a/2,-r_bar+depth/2,z_fin_offset]){
    rotate([180,0,0])
    hull() {
      fanBladeHullStick();
      for(x=[0:7:a]) {
        y = sqrt((pow(a*b,2)-pow(b*x,2))/pow(a,2));
        // translate([x,0,0])
        // cube([w,depth,y]);
        translate([x,0,y])
        fanBladeHullStick();
      }
    }
    translate([0, -depth/2, -b-w/2-h_bladeHook])
    color("red")
    difference(){
      cube([w_bladeHook, depth, h_bladeHook]);
      translate([wall+1, 0, (h_bladeHook -h_bladeHookSlot)])
      cube([w_bladeHook, depth, h_bladeHookSlot]);
    }
  }
}

module fanBladeHullStick(){
  r = w/2;
  translate([r,-depth/2,r])
  rotate([-90,0,0])
  cylinder(r=r, h=depth);
}
