use <text_on.scad>;

//General
$fn=72;
tolerance = 0.6;
wall = 2;

r_base = (75-tolerance)/2;
h_base = 5;

r_platform = r_base+4;
h_platform = h_base;

h_words = 3;

cylinder(r=r_base, h=h_base);
translate([0,0,h_base])
cylinder(r=r_platform, h=h_platform);

translate([0,10,0])
decorations();

module decorations(){
  color("purple")
  translate([0,0,h_base-1+h_words/2])
  scale(2)
  import("Dickbutt_worked_v2.stl");

  color("blue")
  translate([0,-r_base/1.55,h_base*2+h_words/2])
  text_extrude("Farran",size=10,extrusion_height=h_words, center=true);
  color("blue")
  translate([0,-r_base/1.1,h_base*2+h_words/2])
  text_extrude("Dickbutt Cup",size=6,extrusion_height=h_words, center=true);
}