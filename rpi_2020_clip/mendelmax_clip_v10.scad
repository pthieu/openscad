// nischi 
// mendel max clip

breite = 27.25;
tiefe  = 22.25;
hoehe  = 10.00;

dicke1 = 3.0;
dicke2 = 3.6;

misumi = 20.00;    
misumi_hole = 5.25;

// lochtiefe  7.00
// lochbreite 5.25

translate([0,0,0]) rotate([0,0,0]) tool_clip();

module tool_clip()
{
  difference()
  {
    union()
    {
        color("blue") translate([-breite/2,-1,0]) cube([breite,tiefe,hoehe]);  
    }

    union()
    {
       color("blue") translate([-breite/2+dicke1,dicke1,-1]) 
       cube([breite-2*dicke1,tiefe,hoehe*2]);
           // cylinder(20, r=5/2,$fn=20);
    }
  }

  color("lightblue") translate([-breite/2+2.3,misumi/2+2,0]) 
  rotate([0,0,15]) cube([3,tiefe/2-3,hoehe]);  

  color("lightblue") translate([+breite/2-5,misumi/2+3,0]) 
  rotate([0,0,-15]) cube([3,tiefe/2-3,hoehe]);

  color("red")  translate([0,misumi_hole/2,0]) cylinder(hoehe, r=misumi_hole/2,$fn=20);

  color("orange")  translate([-breite/2+misumi_hole/2,misumi_hole/2+misumi/2,0]) 
  cylinder(hoehe, r=misumi_hole/2,$fn=20);
  color("orange")  translate([ breite/2-misumi_hole/2,misumi_hole/2+misumi/2,0]) 
  cylinder(hoehe, r=misumi_hole/2,$fn=20);
}