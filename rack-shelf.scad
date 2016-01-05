use <MCAD/triangles.scad>;

$fn=72;

l = 430;
w = 190;
h = 160;
boundary = 1;

pole_r = 12;
pole_wall = 2;

l_platform = 175;
h_platform = 20;

l_lock = 20;
w_lock = h;
h_lock = 5;

// difference(){
//   cube([l,w,h]);
//   translate([boundary/2,boundary/2,0])
//     cube([l-boundary,w-boundary,h]);
// }


difference(){
  union(){
    translate([pole_r, pole_r, 0])
    rotate([0,0,-75])
      supportBeam(h, pole_r, pole_wall);

    translate([pole_r, w-pole_r, 0])
    rotate([0,0,-105])
      supportBeam(h, pole_r, pole_wall);

    translate([l-pole_r, pole_r, 0])
    rotate([0,0,75])
      supportBeam(h, pole_r, pole_wall);

    translate([l-pole_r, w-pole_r, 0])
    rotate([0,0,105])
      supportBeam(h, pole_r, pole_wall);
    }
    translate([l_platform/2,20,h/3-h_lock])
    cube([l_lock,w_lock,h_lock]);
}


module supportBeam(h, r_out, wall){
  difference(){
    union(){
      cylinder(h=h/3, r=r_out);

      translate([-r_out,r_out,r_out+h/3])
      rotate([90,0,90])
      hull()
      {
        r_platform_node = 1;
        translate([-r_out+r_platform_node,-r_out-r_platform_node,0])
        cylinder(h=r_out*2, r=r_platform_node);

        translate([-r_out+r_platform_node,-h_platform-r_out-r_platform_node,0])
        cylinder(h=r_out*2, r=r_platform_node);

        translate([l_platform-r_out,-r_out-r_platform_node*3,0])
        cylinder(h=r_out*2, r=r_platform_node*3);
      }
    } 
    cylinder(h=h/3, r=r_out-wall);
  }
}