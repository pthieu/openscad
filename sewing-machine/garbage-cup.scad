$fn = 128;
wall = 1.5;
r_inner = 105/2; // dimensions of bag holder
l_rim = 5;
h_cup = 40;
h_rim = 2;

depth_cup_max = 36/2;

color("pink")
cup();

module cup(){
  difference(){
    union(){
      //rim
      difference(){
        cylinder(r=r_inner+l_rim, h=h_rim);
        translate([-r_inner-10,depth_cup_max+l_rim,0])
        cube([r_inner*3, r_inner*3, h_cup]);
      }
      // outer wall of cup
      difference(){
        cylinder(r=r_inner+wall, h=h_cup);
        translate([-r_inner+wall,depth_cup_max+wall,0])
        cube([r_inner*4, r_inner*4, h_cup]);
      }
    }
    // hole of cup
    translate([0,0,-h_rim])
    difference(){
      cylinder(r=r_inner, h=h_cup+0.01);
      translate([-r_inner,depth_cup_max,h_rim])
      cube([r_inner*2, r_inner*2, h_cup]);
    }
  }
}