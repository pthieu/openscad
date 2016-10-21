$fn = 128;
tolerance = 0.5;
wall = 1.5;
wall_base = 1;
r_inner = 105/2; // dimensions of bag holder
l_rim = 5;
h_cup = 40;
h_rim = 2;

l_base = 160;
depth_base = 90;
h_base = 37;
clearance_left_base = 15;

depth_cup_max = 36/2;

difference(){
  // base body
  cube([l_base,depth_base,h_base]);
  // hole in base
  translate([wall_base,wall_base,wall_base])
  cube([l_base-wall_base*2,depth_base-wall_base*2,h_base]);
  translate([r_inner+wall_base+tolerance+clearance_left_base,r_inner+wall_base*3+tolerance*2+l_rim,0])
  difference(){
    cylinder(r=r_inner+wall_base*2+tolerance, h=h_cup);
    translate([-r_inner-wall_base+tolerance,depth_cup_max+wall_base*2+tolerance,0])
    cube([r_inner*4, r_inner*4, h_cup]);
  }
}

// color("pink")
// translate([0,0,h_rim+wall])
// rotate([180,0,0])
// cup(_wall=wall);



module cup(_wall=1.5){
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
        cylinder(r=r_inner+_wall, h=h_cup);
        translate([-r_inner+_wall,depth_cup_max+_wall,0])
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