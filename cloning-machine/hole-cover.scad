//General
$fn = 72;
tolerance = 0.5;
wall = 1;
r_hole = 65/2;
r_cover_body = r_hole;
r_cover_body_inner = r_cover_body - wall;
r_cover_cap = r_cover_body + 5; // 5mm rim?
h_cover = 7 + wall; // total height including rim

difference(){
  union(){
    cylinder(r=r_cover_body, h=h_cover);
    cylinder(r=r_cover_cap, h=wall);
  }
  translate([0,0,-wall*2])
  cylinder(r=r_cover_body_inner, h=h_cover);
}