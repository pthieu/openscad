$fn = 6;

l = 190;
w = 180;
h = 15;

wall = 2.5;
base = 2.5;

l_in = l - wall*2;
w_in = w - wall*2;
h_in = h;

tray_offset = w/4;

translate([-tray_offset,0,h/2])
  union(){
    translate([-l/8,0,0])
      cube([l/4,wall,h], true);
    cube([wall,w,h], true);
  }

difference(){
  translate([0,0,h/2]) cube([l,w,h], true);
  translate([0,0,h/2+base]) cube([l_in, w_in, h_in], true);
}