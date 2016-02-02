use <text_on_OpenSCAD/text_on.scad>;
$fn=24;

width = 27.25;
height  = 22.25;
depth  = 10.00; // seen from bird's eye view of scad file

side_wall = 3.0;

teeth_y = 20.00;    
teeth_d = 5.25; // diameter

//filament wheel has radius 85mm
protrude_length = 100; // amount to come out of 2020 bar 
support_tip_length = 10;
support_tip_space = 2.5;
support_tip_y = 3;

support_tip_head_width = 50;

font_size = 4;

translate([0,1,0]) rotate([0,0,0]) tool_clip();
// extension
translate([width/2-1,0,0]) // -1 on x for spacing from rotate
rotate([0,0,-20])
union(){
  color("blue")
  difference(){
    translate([protrude_length-support_tip_length,0,depth/2-support_tip_space/2])
    union(){
      // support that goes into slot
      translate([0,0,0.1])
      cube([support_tip_length,support_tip_y,support_tip_space-0.2]);
      translate([0,0,-depth/2+support_tip_space/2])
      // side angles up to tip
      linear_extrude(height=depth)
      polygon([[0,0], [support_tip_length,0], [support_tip_length+1.2,-support_tip_y]], height=10);

    }
    translate([protrude_length-support_tip_length,0,0])
    fullTipHead();
  }
  translate([protrude_length-support_tip_length,0,depth/2-support_tip_space/2])
  tipHead();
  difference(){
    union(){
      translate([(protrude_length+support_tip_length)/2,0,(depth-font_size)/2])
      rotate([90,0,0])
      text_extrude("PGT",size=font_size,extrusion_height=1, center=false, halign="center");
      cube([protrude_length,3,depth]);
    }
    color("purple")
    translate([protrude_length-support_tip_length,0,depth/2-support_tip_space/2])
    cube([support_tip_length,3,support_tip_space]);
    
    translate([protrude_length-support_tip_length,0,0])
    fullTipHead();
  }
}

module tipHead(){
  translate([7.5,6,-support_tip_head_width/2])
  rotate([90,0,20])
    difference(){
      roundedcube(8,support_tip_head_width,10,3);
      color("orange")
      translate([1,1,0])
      roundedcube(6,support_tip_head_width-2,10,3);
    }
}

module fullTipHead(){
  translate([7.5,6,-support_tip_head_width/2])
  rotate([90,0,20])
    roundedcube(8,support_tip_head_width,10,3);
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

module roundedcube(xdim ,ydim ,zdim,rdim){
  hull(){
    translate([rdim,rdim,0]) cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);

    translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
  }
}