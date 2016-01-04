use <text_on.scad>;

h=0.3;
font_size=25;

translate([0,font_size*2,0])
text_extrude("HAPPY", extrusion_height=h, center=false, size=font_size);
translate([0,font_size,0])
text_extrude("NEW", extrusion_height=h, center=false, size=font_size);
text_extrude("YEAR", extrusion_height=h, center=false, size=font_size);
translate([0,-font_size,0])
text_extrude("2016", extrusion_height=h, center=false, size=font_size);