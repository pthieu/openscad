use <text_on.scad>;

//General
$fn=72;
tolerance = 0.6;
wall = 2;

module decorations(){
  color("purple")
  translate([0,0,h_base-1+h_words/2])
  scale(2)
  import("Dickbutt_worked_v2.stl");
}