$fn=6;

l = 430;
w = 190;
h = 160;
boundary = 1;

pole_r = 12;
pole_wall = 2;

differenc(){
  cube([l,w,h]);
  translate([boundary/2,boundary/2,0])
    cube([l-boundary,w-boundary,h]);
}

translate([pole_r, pole_r, 0])
  supportBeam();

//translate([pole_r, w-pole_r, 0])
//  hollow_pole(h, pole_r, pole_wall);


module hollow_pole(h, r_out, wall){
  difference(){
    cylinder(h=h/3, r=r_out);
    cylinder(h=h/3, r=r_out-wall);
  }
}

module supportBeam(){
  union(){
    
    hollow_pole(h, pole_r, pole_wall);
  }
}