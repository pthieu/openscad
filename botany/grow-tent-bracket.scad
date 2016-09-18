//General
$fn = 72;
tolerance = 0.5;
wall = 2; // wall is actually *2 this

r_pipe = 24.1/2+tolerance/2; // includes pipe wall
l_pipe_hole = 25.4;

r_corner = 2;
h_bracket = (r_pipe+wall)*2;

pipeHole();
translate([l_pipe_hole*2+r_corner*2,l_pipe_hole+r_corner*2,0])
rotate([0,0,90])
pipeHole();

hull(){
  pillars();
  translate([l_pipe_hole*2,0,0])
  pillars();
  translate([l_pipe_hole*2+r_corner*2,l_pipe_hole*2,0])
  rotate([0,0,90])
  pillars();
}

module pipeHole(){
  translate([0, r_pipe+wall+r_corner, r_pipe+wall+r_corner])
  rotate([0,90,0])
  difference(){
    union(){
      translate([0,0,l_pipe_hole/2])
      cube([h_bracket,h_bracket,l_pipe_hole], center=true);
      cylinder(r=r_pipe+wall, h=l_pipe_hole);
    }
    cylinder(r=r_pipe, h=l_pipe_hole+0.001);
  }
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