//General
$fn = 36;
tolerance = 0.5;
wall = 2; // wall is actually *2 this

r_pipe = 24.1/2+tolerance/2; // includes pipe wall
// l_pipe_hole = 25.4;

r_corner = 2;
h_bracket = (r_pipe+wall)*2;

l_pipe_hole = h_bracket;

pipeHole();
translate([l_pipe_hole,r_corner*2+l_pipe_hole+h_bracket,0])
rotate([0,0,-90])
pipeHole();
translate([l_pipe_hole,0,r_corner*2+l_pipe_hole+h_bracket])
rotate([0,90,0])
pipeHole();

translate([h_bracket/2+r_corner+l_pipe_hole,h_bracket/2+r_corner,r_corner])
solidBlock();

module solidBlock(){
  translate([0,0,l_pipe_hole/2])
  cube([h_bracket+r_corner*2,h_bracket,l_pipe_hole], center=true);
  translate([0,0,l_pipe_hole/2])
  color("blue")
  cube([h_bracket,h_bracket+r_corner*2,l_pipe_hole], center=true);
  color("white")
  translate([0,0,l_pipe_hole/2])
  cube([h_bracket,h_bracket,l_pipe_hole+r_corner*2], center=true);

  translate([-h_bracket/2-r_corner,-h_bracket/2-r_corner,r_corner])
  rotate([0,90,0])
  pillars();

  translate([-h_bracket/2-r_corner,-h_bracket/2-r_corner,-r_corner])
  pillars();

  translate([h_bracket/2+r_corner,-h_bracket/2-r_corner,-r_corner])
  rotate([0,0,90])
  pillars();
}

module pipeHole(){
  translate([r_corner, r_pipe+wall+r_corner, r_pipe+wall+r_corner])
  rotate([0,90,0])
  difference(){
    union(){
      translate([0,0,l_pipe_hole/2])
      cube([h_bracket+r_corner*2,h_bracket,l_pipe_hole], center=true);
      translate([0,0,l_pipe_hole/2])
      color("blue")
      cube([h_bracket,h_bracket+r_corner*2,l_pipe_hole], center=true);
      color("white")
      cube([h_bracket,h_bracket,r_corner*2], center=true);
      cylinder(r=r_pipe+wall, h=l_pipe_hole);
    }
    translate([0,0,-r_corner-0.001])
    cylinder(r=r_pipe, h=l_pipe_hole+2.002);
  }
  pillars();
  translate([r_corner*2+h_bracket,0,0])
  rotate([0,0,90])
  pillars();
  translate([0,0,r_corner*2])
  rotate([0,90,0])
  pillars();

  translate([0,h_bracket+r_corner*2,0])
  rotate([0,0,-90])
  pillars();
}

module pillar(){
  translate([0,0,r_corner]){
    color("red")
    translate([r_corner,r_corner,h_bracket])
    sphere(r=r_corner);
    translate([r_corner,r_corner,0])
    cylinder(r=r_corner, h=h_bracket);
    color("red")
    translate([r_corner,r_corner,0])
    sphere(r=r_corner);
  }
}

module pillars(){
  pillar();
  translate([0,h_bracket,0])
  pillar();
  rotate([-90,-90,0])
  pillar();
  translate([0,0,h_bracket])
  rotate([-90,-90,0])
  pillar();
}