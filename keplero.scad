// 1unit = 1mm -- will most likely have to scale in slicer

$fn=72;

// Credit card attributes
r_corner = 3;
l = 85.60+1; // +2 for shrinkage
w = 53.98+0.5; // +1 for shrinkage
h = 1.3; // credit card 0.8mm, with extruded words 1.3mm

// Notches (rail keeping card in)
l_notch = l;
w_notch = 0.6;
h_notch = 0.5;

// Outer case attributes
h_case = h+h_notch+0.5;
w_case = w+12;
r_corner_case = 1.5;


// Magnet attributes
offset_mag_large = 2;
r_mag_large = 5+0.25;
offset_mag_small_y = (w_case-w)/4;
r_mag_small = 1.5+0.25;
r_mag_offset_x = 5;
h_mag = 2;


offset_case = (r_mag_large+offset_mag_large)*2;

module creditCard(size, radius)
{
  x = size[0];
  y = size[1];
  z = size[2];

  linear_extrude(height=z)
  hull()
  {
    // place 4 circles in the corners, with the given radius
    // bottom left
    translate([(-x/2)+(radius), (-y/2)+(radius), 0])
    circle(radius, true);
    // bottom right
    translate([(x/2)-(radius), (-y/2)+(radius), 0])
    circle(radius, true);
    // top left
    translate([(-x/2)+(radius), (y/2)-(radius), 0])
    circle(radius, true);
    // top right
    translate([(x/2)-(radius), (y/2)-(radius), 0])
    circle(radius, true);
  }
}
difference(){
  union(){
    difference(){
      difference(){
        translate([-offset_case/2,0,0]) creditCard([l+offset_case,w_case,h_case], r_corner);
        // Extra +5 on creditCard is so the corners don't close in too early and 
        // it's straightgoing forward the whole way
        
        // Top half of credit card
        translate([0,0,h_case-h_notch]) creditCard([l,w,h], r_corner);
        // bottom half of credit card
        translate([0,0,h_case-h_notch-h]) creditCard([l,w,h], r_corner);
        
        // left small magnet radius clear
        translate([l/2-r_corner,w/2-r_corner,h_case-h_notch])
        cube([r_corner*2,r_corner*2,h*2],true);
        // right small magnet radius clear
        translate([l/2-r_corner,-w/2+r_corner,h_case-h_notch])
        cube([r_corner*2,r_corner*2,h*2],true);
      }
    }
    translate([-l/2,-w/2,h_case-h_notch])
    cube([l_notch,w_notch,h_notch]);
    
    translate([-l/2,w/2-w_notch,h_case-h_notch])
    cube([l_notch,w_notch,h_notch]);
  }
  // large magnet at bottom
  translate([-(l/2+r_mag_large+offset_mag_large),0,0]) cylinder(h_mag, r=r_mag_large, true);
  // left small magnet
  translate([l/2-r_mag_offset_x,w/2+offset_mag_small_y,0]) cylinder(h_mag, r=r_mag_small, true);
  // right small maget
  translate([l/2-r_mag_offset_x,-(w/2+offset_mag_small_y),0]) cylinder(h_mag, r=r_mag_small, true);