use <MCAD/boxes.scad>;
// use <libs.scad>;
use <text_on.scad>;

$fn=36;

l_arm = 75;
w_arm = 10;
h_arm = 4.5;

r_servo_axle = 3.4+0.35;
l_servo_horn = 28;

l_switch = 7.5+0.3;
w_switch = 26;
x_switch = l_arm-l_switch;
y_switch = w_arm/2-w_switch/2;

h_horn = 1.5;
l_horn_slot = l_arm-w_arm/2-l_switch;
w_horn_slot = 4.5;
y_horn_slot = w_arm/2-w_horn_slot/2;
z_horn_slot = h_arm-h_horn; // 1.5 is height of horn

b_axle_triangle_h = 20; // used for horn not being rectangle

r_screw = 3/2+0.125; // m3 screw
y_screw = 23/2-r_screw;

difference(){
  union(){
    //arm body
    translate([w_arm/2,0,0])
      cube([l_arm-w_arm/2,w_arm,h_arm]);
    //servo to arm area
    translate([w_arm/2,w_arm/2,0])
      cylinder(r=w_arm/2,h=h_arm);
    //switch
    translate([x_switch+l_switch/2,y_switch+w_switch/2,h_arm/2])
      // cube([l_switch,w_switch,h_arm]);
    roundedBox([l_switch,w_switch,h_arm],0.75,true);
  }
  //servo horn axle
  translate([w_arm/2+0.5,w_arm/2,0])
    cylinder(r=r_servo_axle,h=h_arm);
  
  //horn slot on arm
  translate([w_arm/2,y_horn_slot,z_horn_slot])
    cube([l_horn_slot,w_horn_slot,h_arm]);

  //m3 screw holes
  translate([l_arm-r_screw-1.25,w_arm/2,0]){
    translate([0,y_screw,0])
      cylinder(r=r_screw, h=h_arm);
    mirror([0,1,0])
      translate([0,y_screw,0])
      cylinder(r=r_screw, h=h_arm);
  }

  // horn is not a rectable, so we have to add some extra spacing
  translate([b_axle_triangle_h/2+w_arm/2+0.5,w_arm/2,h_arm-h_horn/2])
    rotate([0,0,-90])
      isoTriangle(b=r_servo_axle*2, h=b_axle_triangle_h, z=h_horn, center=true);
}
translate([l_arm/2,w_arm/2-3.5/2,z_horn_slot])
  text_extrude("PGT",size=3.5,extrusion_height=h_arm-z_horn_slot, center=false);

module isoTriangle(b=10, h=10, z=10, center=false){
  translate(center==true ? [-b/2, -h/2, -z/2] : [0,0,0]) 
    linear_extrude(height=z)
      polygon(points=[[0,0],[b,0],[b/2,h]]);
}