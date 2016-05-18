//General
$fn = 18;
tolerance = 0.5;
wall = 2;

w_chute_inner = 80;
depth_chute_inner = 35;
h_chute_inner = 10;

depth_chute_side_wall = depth_chute_inner+wall*2;
h_chute_side_wall = 30;

h_chute_main_wall = 20;

chuteBody();

module chuteBody(){
  // main body
  difference(){
    cube([w_chute_inner+wall*2, depth_chute_inner+wall*2, h_chute_inner]);
    translate([wall,wall,0])
    cube([w_chute_inner, depth_chute_inner, h_chute_inner]);
  }
  // side wall
  translate([0,0,h_chute_inner])
  cube([wall, depth_chute_side_wall, h_chute_side_wall]);
  // main wall
  color("blue")
  translate([0,depth_chute_inner+wall,h_chute_inner])
  cube([w_chute_inner+wall*2, wall, h_chute_main_wall]);
}
