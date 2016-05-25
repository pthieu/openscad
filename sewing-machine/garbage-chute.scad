//General
$fn = 18;
tolerance = 0.5;
wall = 2;

w_chute_inner = 80;
depth_chute_inner = 45;
h_chute_inner = 10;

// left side slot cutout
h_chute_inner_slot = 4;
depth_chute_inner_slot = 18;

// side wall
depth_chute_side_wall = depth_chute_inner+wall*2;
h_chute_side_wall = 32;

// main wall
h_chute_main_wall = h_chute_side_wall;

difference(){
  chuteBody();
  // translate([-0.001,wall-0.001+6,wall*5])
  // cube([w_chute_inner*2, depth_chute_inner-10, h_chute_side_wall*2]);
  // translate([7,depth_chute_inner,h_chute_inner])
  // cube([w_chute_inner-10, wall*3, h_chute_main_wall+0.001]);
}
// mirror([0,0,1])
// chuteTunnel();
chuteConnector();

module chuteBody(){
  // main body
  difference(){
    union(){
      // main body
      cube([w_chute_inner+wall*2, depth_chute_inner+wall*2, h_chute_inner]);
      // right nut bracket
      translate([0,(depth_chute_inner+wall*2)/2,0])
      nutBracket(l=20);
      // left nut bracket
      translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
      rotate([0,0,180])
      nutBracket(l=20);
    }
    // hollow out
    translate([wall,wall,-0.5])
    cube([w_chute_inner, depth_chute_inner, h_chute_inner+1]);
    // slot on left side
    translate([w_chute_inner,wall,h_chute_inner-h_chute_inner_slot])
    cube([wall*3, depth_chute_inner_slot, h_chute_inner_slot+0.001]);
  }
  // side wall
  translate([0,wall,h_chute_inner])
  cube([wall, depth_chute_side_wall-wall, h_chute_side_wall]);
  // main wall
  color("blue")
  translate([0,depth_chute_inner+wall,h_chute_inner])
  cube([w_chute_inner+wall*2, wall, h_chute_main_wall]);
  // left side wall
  translate([w_chute_inner+wall*2,wall+depth_chute_inner_slot,h_chute_inner])
  rotate([0,-90,0])
  linear_extrude(height=wall)
  polygon([
    [0,0],
    [0,h_chute_side_wall-wall*2],
    [h_chute_side_wall,h_chute_side_wall-wall*2],
    [h_chute_side_wall,6],
  ]);
}

module chuteConnector(){
  x_connector = 46.7 + wall;
  w_connector = 6;
  w_connector_space = 3;
  h_connector = h_chute_inner+h_chute_side_wall;
  step_connector = h_connector/10;
  depth_connector = 5;

  // Connector for metal bracket and chute body
  translate([x_connector, depth_chute_inner+depth_connector/2+wall*2,h_connector/2])
  difference(){
    cube([w_connector,depth_connector,h_connector], center=true);
    cube([w_connector_space+0.001,depth_connector+0.001,h_chute_inner+h_chute_side_wall+0.001], center=true);
    translate([0,0,-h_connector/2.25])
    for(i=[0:step_connector:h_connector]){
      translate([0,0,i])
      rotate([0,90,0])
      cylinder(h=w_connector+0.001, center=true);
    }
  }
}

module chuteTunnel(){
  h_chute_tunnel = 30;
  angle_chute_tunnel = 40;
  depth_tunnel_L1 = depth_chute_inner;
  difference(){
    union(){
      skew([0, 0, 0, 0, -angle_chute_tunnel, 0])
      cube([w_chute_inner+wall*2, depth_tunnel_L1+wall*2, h_chute_tunnel]);
      // right nut bracket
      translate([0,(depth_chute_inner+wall*2)/2,0])
      nutBracket(l=20);
      // left nut bracket
      translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
      rotate([0,0,180])
      nutBracket(l=20);
    }
    skew([0, 0, 0, 0, -angle_chute_tunnel, 0])
    translate([wall,wall,-0.5])
    cube([w_chute_inner, depth_tunnel_L1, h_chute_tunnel+1]);
  }
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

module nutBracket(l=10){
  h = 3;
  w = 10;
  r_m3 = 3/2;
  offset_m3 = r_m3*2;
  translate([0,0,h/2])
  difference(){
    cube([l,w,h], center=true);
    translate([-l/2+r_m3+offset_m3,0,0])
    cylinder(r=r_m3, h=h*2, center=true);
  }
}