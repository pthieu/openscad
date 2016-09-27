//General
$fn = 72;
tolerance = 0.5;
wall = 2;
r_m3 = 1.5;

l_cover = 60;
// l_cover = 10;
cover_wall = 1;
w_cover_inner = 70+tolerance/2;
w_cover_outter = w_cover_inner+cover_wall*2;
h_top_plane = 0.3+0.2*2;
h_cover = 8;

r_fan = 57/2;
w_grill_spoke = 2;
d_fan_screw = 50;

// main plane
difference(){
  cube([l_cover, w_cover_outter, h_top_plane]);
  translate([l_cover/2, w_cover_outter/2, -0.01])
  cylinder(h=h_top_plane+1, r=r_fan);

  color("blue")
  translate([l_cover/2-d_fan_screw/2, w_cover_outter/2-d_fan_screw/2, -0.01]){
    cylinder(r=r_m3);
    translate([d_fan_screw,0,0])
    cylinder(r=r_m3);
    translate([0,d_fan_screw,0])
    cylinder(r=r_m3);
    translate([d_fan_screw,d_fan_screw,0])
    cylinder(r=r_m3);
  }
}

translate([0, (w_cover_outter-w_grill_spoke)/2, 0]){
  cube([l_cover, w_grill_spoke, h_top_plane]);

  translate([r_fan+w_grill_spoke*5/4,-r_fan-w_grill_spoke/2,0])
  rotate([0,0,90])
  cube([l_cover, w_grill_spoke, h_top_plane]);
}

difference(){
  cube([l_cover, w_cover_outter, h_cover]);
  translate([0, cover_wall, 0])
  cube([l_cover, w_cover_outter-cover_wall*2, h_cover+0.001]);
}

translate([0, cover_wall*2, 0])
difference(){
  cube([l_cover, w_cover_inner-cover_wall*2, h_cover]);
  translate([0, cover_wall, 0])
  cube([l_cover, w_cover_inner-cover_wall*2*2, h_cover+0.001]);
}