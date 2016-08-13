//General
$fn = 72;
tolerance = 0.5;
wall = 1;
r_hole = 65/2;
r_cover_body = r_hole - tolerance/2;
r_cover_body_inner = r_cover_body - wall;
r_cover_cap = r_cover_body + 5; // 5mm rim?
h_cover = 60 + wall; // total height including rim

// seed cage
r_cage = r_hole/2;
h_cage = 5;

// outter slits
z_slit = 10;
h_slits = h_cover-wall*3-z_slit;
w_slit = wall*12;

mirror([0,0,1]) {
  // Main body
  difference(){
    union(){
      cylinder(r=r_cover_body, h=h_cover);
      cylinder(r=r_cover_cap, h=wall*1.5);
    }
    // Inner body space
    translate([0,0,wall])
    cylinder(r=r_cover_body_inner-wall*5, h=h_cover-wall*3);
    slit(w_slit=14);
    rotate([0,0,30])
    slit(w_slit=14);
    rotate([0,0,60])
    slit(w_slit=14);
    rotate([0,0,90])
    slit(w_slit=14);
    rotate([0,0,120])
    slit(w_slit=14);
    rotate([0,0,150])
    slit(w_slit=14);
    rotate([0,0,180])
    slit(w_slit=14);
  }
  // seed cage
  difference() {
    translate([0,0,h_cover-wall*2-h_cage])
    union(){
      color("green")
      cylinder(r=r_cage, h=h_cage);
      color("blue")
      translate([0,0,h_cage/2])
      cylinder(r=r_cage+wall, h=h_cage/2);
    }
    // seed cage inner hole
    translate([0,0,h_cover-wall*2-h_cage])
    cylinder(r=r_cage-wall*2, h=h_cage);
    // slits for cage
    slit(w_slit=4);
    rotate([0,0,30])
    slit(w_slit=4);
    rotate([0,0,60])
    slit(w_slit=4);
    rotate([0,0,90])
    slit(w_slit=4);
    rotate([0,0,120])
    slit(w_slit=4);
    rotate([0,0,150])
    slit(w_slit=4);
    rotate([0,0,180])
    slit(w_slit=4);
  }
  // Tiny seed cage
  translate([0,0,h_cover-wall*2-h_cage/4]){
    difference() {
      color("purple")
      cylinder(r=5, h=h_cage/4);
      cylinder(r=5-wall, h=h_cage/4);
      translate([0,0,-wall*12])
      rotate([0,0,45])
      slit(w_slit=1);
      translate([0,0,-wall*12])
      rotate([0,0,135])
      slit(w_slit=1);
    }
  }
}

module slit(w_slit=w_slit) {
  color("red")
  translate([0,0,h_slits/2+wall+z_slit]) {
    cube([r_hole*2, w_slit, h_slits], center=true);
  }
}