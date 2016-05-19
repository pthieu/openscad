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
mirror([0,0,1])
chuteTunnel();

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

module chuteTunnel(){
  h_chute_tunnel = 40;
  skew([0, 60, 0, 0, 0, 0])
  difference(){
    cube([w_chute_inner+wall*2, depth_chute_inner+wall*2, h_chute_tunnel]);
    translate([wall,wall,0])
    cube([w_chute_inner, depth_chute_inner, h_chute_tunnel]);
  }
  translate([0,(depth_chute_inner+wall*2)/2,0])
  nutBracket();
}

/*skew takes an array of six angles:
 *x along y
 *x along z
 *y along x
 *y along z
 *z along x
 *z along y
 */
module skew(dims) {
matrix = [
  [ 1, dims[0]/45, dims[1]/45, 0 ],
  [ dims[2]/45, 1, dims[4]/45, 0 ],
  [ dims[5]/45, dims[3]/45, 1, 0 ],
  [ 0, 0, 0, 1 ]
];
multmatrix(matrix)
  children();
}

module nutBracket(){
  h = 3;
  l = 10;
  w = 10;
  r_m3 = 3/2;
  translate([0,0,h/2])
  difference(){
    cube([l,w,h], center=true);
    cylinder(r=r_m3, h=h*2, center=true);
  }
}