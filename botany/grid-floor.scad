//General
$fn = 36;
tolerance = 0.5;
wall = 2;
h = 1;
r = 55/2 + tolerance;
spacing = wall+5;

difference(){
  grid();
  translate([r,r,-0.01])
  difference(){
    cylinder(r=100, h=h*2);
    cylinder(r=r, h=h*2);
  }
}

module grid(){
  line(r);
  translate([r*2,-wall/2,0])
  rotate([0,0,90])
  line(r);
}

module line(radius){
  for(i=[1:1:radius*2-1]) {
    if(i%spacing == 0) {
      translate([i,0,0])
      cube([wall, radius*2, h]);
    }
  }
}
