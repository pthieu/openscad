//General
$fn = 12;
tolerance = 0.5;
wall = 2;

pieces = 4;

l_fixture = 610-tolerance*pieces;

l_cover = (l_fixture - (60 - tolerance)*2)/pieces;
// l_cover = 10;
cover_wall = 1;
w_cover_inner = 70+tolerance/2;
w_cover_outter = w_cover_inner+cover_wall*2;
h_top_plane = 0.3+0.2*2;
h_cover = 8;


// main plane
cube([l_cover, w_cover_outter, h_top_plane]);

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