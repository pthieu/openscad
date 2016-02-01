use <text_on_OpenSCAD/text_on.scad>;

width = 27.25;
height  = 22.25;
depth  = 10.00; // seen from bird's eye view of scad file

side_wall = 3.0;

teeth_y = 20.00;    
teeth_d = 5.25; // diameter

//filament wheel has radius 85mm
protrude_length = 75-width/2; // amount to come out of 2020 bar 
support_tip_length = 10;
support_tip_space = 2.5;

font_size = 4;

translate([0,1,0]) rotate([0,0,0]) tool_clip();
// extension
translate([width/2-1,0,0]) // -1 on x for spacing from rotate
rotate([0,0,-15])
union(){
  translate([(protrude_length+support_tip_length)/2,0,(depth-font_size)/2])
  rotate([90,0,0])
  text_extrude("PGT",size=font_size,extrusion_height=1, center=false, halign="center");
  
  cube([protrude_length,3,depth]);
  translate([protrude_length,0,0])
  difference(){
    color("orange")
    cube([support_tip_length,3,depth]);
    color("purple")
    translate([support_tip_length/2,0,depth/2-support_tip_space/2])
    cube([support_tip_length,3,support_tip_space]);
  }
}

module tool_clip()
{
  difference()
  {
    union()
    {
        color("blue") translate([-width/2,-1,0]) cube([width,height,depth]);  
    }

    union()
    {
       color("blue") translate([-width/2+side_wall,side_wall,-1]) 
       cube([width-2*side_wall,height,depth*2]);
           // cylinder(20, r=5/2,$fn=20);
    }
  }

  
  color("lightblue") translate([-width/2+2.3,teeth_y/2+2,0]) 
  rotate([0,0,15]) cube([3,height/2-3,depth]);  

  color("lightblue") translate([+width/2-5,teeth_y/2+3,0]) 
  rotate([0,0,-15]) cube([3,height/2-3,depth]);

  color("red")  translate([0,teeth_d/2,0]) cylinder(depth, r=teeth_d/2,$fn=20);

  color("orange")  translate([-width/2+teeth_d/2,teeth_d/2+teeth_y/2,0]) 
  cylinder(depth, r=teeth_d/2,$fn=20);
  color("orange")  translate([ width/2-teeth_d/2,teeth_d/2+teeth_y/2,0]) 
  cylinder(depth, r=teeth_d/2,$fn=20);
}