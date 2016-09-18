//General
$fn = 72;
tolerance = 0.5;
wall = 2;

r_pipe = 24.1/2+tolerance/2; // includes pipe wall

translate([r_pipe+wall, r_pipe+wall, 0])
difference(){
  cylinder(r=r_pipe+wall, h=10);
  cylinder(r=r_pipe, h=10+0.001);
}