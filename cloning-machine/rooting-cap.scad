//General
$fn = 72;
tolerance = 0.5;
wall = 1;
r_cover = 65/2; // cap
r_cover_body = r_cover-1;
r_foam = 40;
r_stem_hole = 20;
r_cover_cap = r_cover_body + 5; // 5mm rim?
h_cover = 30 + wall; // total height including rim

difference(){
  union(){
    cylinder(r=r_cover_body-tolerance, h=h_cover);
    cylinder(r=r_cover_cap, h=wall);
  }
  translate([0,0,h_cover/2-wall])
  cube([r_foam, r_foam, h_cover], center=true);
  translate([0,0,h_cover/2])
  cylinder(r=r_stem_hole/2, h=h_cover);
}