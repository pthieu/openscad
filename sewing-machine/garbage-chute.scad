//General
$fn = 36;
tolerance = 0.5;
wall = 2;
r_m3 = 3/2;

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

// T2 chute
h_chute_tunnel = 40;
angle_chute_tunnel = 40;
depth_tunnel_L1 = depth_chute_inner;

// T3 chute vertical extension
h_chute_vertical = 35;

// T1 main body
// difference(){
//   color("blue")
//   chuteBody();
//   // translate([-0.001,wall-0.001+6,wall*5])
//   // cube([w_chute_inner*2, depth_chute_inner-10, h_chute_side_wall*2]);
//   // translate([7,depth_chute_inner,h_chute_inner])
//   // cube([w_chute_inner-10, wall*3, h_chute_main_wall+0.001]);
// }
// // chuteConnector();

// // T2 chute diagonal tunnel
// mirror([0,0,1])
// chuteTunnel();

// // T3 vertical extension
// color("green")
// translate([0,-13.44-depth_tunnel_L1/2+tolerance/1.31,-h_chute_vertical-h_chute_tunnel])
// chuteVertical(h=h_chute_vertical);

// T4 chute diagonal tunnel -- has offset on nut brackets
// color("pink")
// translate([0,-13.44-depth_tunnel_L1/2+tolerance/1.31,-h_chute_vertical-h_chute_tunnel])
// mirror([0,0,1]){
//   chuteTunnel(y_nut_offset=0.55);
// }

// rotate([0,180,0]) // only for isolation and supports 
// // T5 red tube
// mirror([0,0,1])
// translate([0,-35.55,h_chute_vertical+h_chute_tunnel])
// color("red")
// chuteTube();

// T6 twist tube
color("violet")
translate([0,-(depth_chute_inner+wall*2)-22.1139,-h_chute_tunnel*2-h_chute_vertical])
chuteTwist(y_nut_offset=0.55);

// T7 diagonal tunnel
// translate([0,0,-h_chute_tunnel*3-h_chute_vertical])
// rotate([0,0,60])
// translate([-w_chute_inner+0.36+wall,-95.893-wall*2-depth_chute_inner,0])
// mirror([0,0,1])
// chuteTunnel();

module chuteTwist(y_nut_offset=0){
  translate([w_chute_inner/2+wall, depth_chute_inner/2+wall])
  mirror([0,0,1])
  skew([0, 50, 0, 0, -50, 0])
  linear_extrude(height=h_chute_tunnel, twist=-60, slices=500, $fn=36)
  difference(){
    square(size=[w_chute_inner+wall*2, depth_chute_inner+wall*2], center=true);
    square(size=[w_chute_inner, depth_chute_inner], center=true);
  }
  difference(){
    union(){
      //top nut brackets
      // right nut bracket -- top
      translate([0,y_nut_offset,-3]){
        translate([0,(depth_chute_inner+wall*2)/2,0])
        nutBracket(l=20);
        // left nut bracket -- top
        translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
        rotate([0,0,180])
        nutBracket(l=20);
      }
      // bottom nut brackets
      rotate([0,0,60])
      translate([-6.05-10,-79.85-wall-depth_chute_inner/2-5,-h_chute_tunnel]){
      // translate([-5.05+20/2,-80.23-wall-depth_chute_inner/2+5,-h_chute_tunnel]){
        // right nut bracket -- bottom
        translate([0,(depth_chute_inner+wall*2)/2,0])
        nutBracket(l=20);
        // left nut bracket -- bottom
        translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
        rotate([0,0,180])
        nutBracket(l=20);
      }
    }
    translate([w_chute_inner/2+wall, depth_chute_inner/2+wall])
    mirror([0,0,1])
    skew([0, 50, 0, 0, -50, 0])
    linear_extrude(height=h_chute_tunnel, twist=-60, slices=100, $fn=72)
    square(size=[w_chute_inner, depth_chute_inner], center=true);
  }
}

module chuteVertical(h=10){
  difference(){
    union(){
      cube([w_chute_inner+wall*2, depth_chute_inner+wall*2, h]);
      // top nut brackets
      translate([0,0.55,h_chute_vertical-3]) {
        // right nut bracket -- bottom
        translate([0,(depth_chute_inner+wall*2)/2,0])
        nutBracket(l=20);
        // left nut bracket -- bottom
        translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
        rotate([0,0,180])
        nutBracket(l=20);
      }
      // bottom nut brackets
      translate([0,0.55,0]) {
        // right nut bracket -- bottom
        translate([0,(depth_chute_inner+wall*2)/2,0])
        nutBracket(l=20);
        // left nut bracket -- bottom
        translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
        rotate([0,0,180])
        nutBracket(l=20);
      }
    }
    translate([wall,wall,0])
    cube([w_chute_inner, depth_chute_inner, h]);
  }
}


module chuteTube(){
  // T3 cylindrical tube
  // tube side wall
  translate([0,13.44,h_chute_tunnel])
  rotate([90,0,0])
  linear_extrude(height=wall)
  polygon([
    [0,0],
    [w_chute_inner+wall*2,0],
    [w_chute_inner+wall*2,75]
  ]);
  // tube other side wall
  translate([0,13.44-depth_tunnel_L1-wall,h_chute_tunnel])
  rotate([90,0,0])
  linear_extrude(height=wall)
  polygon([
    [0,0],
    [w_chute_inner+wall*2,0],
    [w_chute_inner+wall*2,75] // then change this
  ]);
  // tube opening end nut bracket
  translate([w_chute_inner+wall,13.44-depth_tunnel_L1-wall*2,h_chute_tunnel])
  cube([wall,depth_tunnel_L1+wall*2,20]); // tube top end skew repair
  // tube body
  translate([0,13.44-depth_tunnel_L1-wall*1.5,h_chute_tunnel])
  cube([wall,depth_tunnel_L1+wall,wall]); // tube top end skew repair
  skew([0, 0, 0, 0, 0, 40]){ // if you change this
    translate([0,-11.05,h_chute_tunnel])
    rotate([0,90,0])
    difference(){
      cylinder(r=depth_tunnel_L1/2+wall, h=w_chute_inner+wall*2);
      translate([0,0,wall])
      cylinder(r=depth_tunnel_L1/2, h=w_chute_inner+wall*2+0.002);
      translate([0,-depth_tunnel_L1/2-wall*1.5,-0.001])
      cube([depth_tunnel_L1/2+wall,depth_tunnel_L1+wall*3,w_chute_inner+wall*2+0.002]);
    }
  }

  // bracket
  translate([0,-35,h_chute_tunnel]) {
    difference(){
      union(){
        // right nut bracket -- bottom
        translate([0,(depth_chute_inner+wall*2)/2,0])
        nutBracket(l=20);
        // left nut bracket -- bottom
        translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
        rotate([0,0,180])
        nutBracket(l=20);
      }
      translate([0,0,-1])
      cube([w_chute_inner+wall, depth_chute_inner, h_chute_inner]);
    }
  }
}

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
  x_connector = 49;
  w_connector = 6;
  w_connector_space = 3;
  depth_connector = 10;
  h_connector = h_chute_inner+h_chute_side_wall;
  step_connector = h_connector/10;
  h_arm_head = step_connector*4;
  w_arm_head = w_connector_space-tolerance;
  depth_arm_head = depth_connector-tolerance;
  h_arm = 39;
  w_arm_leg = 10;
  x_arm_leg_hole = w_arm_leg/2+1;

  // Connector for metal bracket and chute body
  translate([x_connector, depth_chute_inner+depth_connector/2+wall*2,h_connector/2]){
    difference(){
      cube([w_connector,depth_connector,h_connector], center=true);
      cube([w_connector_space+0.001,depth_connector+0.001,h_chute_inner+h_chute_side_wall+0.001], center=true);
      translate([0,0,-h_connector/4.125])
      for(i=[0:step_connector:h_connector/2]){
        translate([0,0,i])
        rotate([0,90,0])
        cylinder(r=r_m3, h=w_connector+0.001, center=true);
      }
    }
  }
  //arm
  // translate([x_connector, depth_chute_inner+depth_connector/2+wall*2,h_connector/2])
  // translate([(-w_connector_space+tolerance)/2,(-depth_connector+tolerance)/2,-w_connector+h_arm_head])
  // mirror([0,0,1])
  // difference(){
  //   cube([w_arm_head,depth_arm_head,h_arm_head*2]);
  //   translate([0,depth_arm_head/2,h_arm_head/2])
  //   rotate([0,90,0])
  //   cylinder(r=r_m3,h=w_connector+0.001, center=true);
  // }
  // translate([
  //   x_connector+(-w_connector_space+tolerance)/2,
  //   (-depth_connector+tolerance)/2+depth_chute_inner+depth_connector/2+wall*2,
  //   0
  // ]){
  //   mirror([0,0,1])
  //   cube([w_arm_head,depth_arm_head,h_arm]);
  //   translate([0,0,-h_arm])
  //   difference(){
  //     cube([w_arm_leg,w_arm_leg-tolerance,wall]);
  //     color("red")
  //     translate([x_arm_leg_hole,depth_arm_head/2,0])
  //     cylinder(r=r_m3, h=w_connector+0.001, center=true);
  //   }
  // }
}

module chuteTunnel(y_nut_offset=0){
  difference(){
    union(){
      // main tunnel body
      skew([0, 0, 0, 0, -angle_chute_tunnel, 0])
      cube([w_chute_inner+wall*2, depth_tunnel_L1+wall*2, h_chute_tunnel]);

      //top nut brackets
      // right nut bracket -- top
      translate([0,y_nut_offset,0]){
        translate([0,(depth_chute_inner+wall*2)/2,0])
        nutBracket(l=20);
        // left nut bracket -- top
        translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
        rotate([0,0,180])
        nutBracket(l=20);
      }

      // bottom nut brackets
      translate([0,-35,h_chute_tunnel-3]){
        // right nut bracket -- bottom
        translate([0,(depth_chute_inner+wall*2)/2,0])
        nutBracket(l=20);
        // left nut bracket -- bottom
        translate([w_chute_inner+wall*2,(depth_chute_inner+wall*2)/2,0])
        rotate([0,0,180])
        nutBracket(l=20);
      }
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
  offset_m3 = r_m3*2;
  translate([0,0,h/2])
  difference(){
    cube([l,w,h], center=true);
    translate([-l/2+r_m3+offset_m3,0,0])
    cylinder(r=r_m3, h=h*2, center=true);
  }
}