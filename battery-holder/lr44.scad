use <MCAD/triangles.scad>;

tolerance = 0.5;

// Battery specs
lr44_h = 5.5;
lr44_r = 12/2;
lr44_n = 4+2; // number of batteries + extra space for springs
lr44_tol_mult = 1.05; // Tolerance multiplier

// Case specs
wall = 1;
case_l = lr44_r*2 + wall*2;
case_w = lr44_h*(lr44_n)*lr44_tol_mult + wall*2;
case_h = lr44_r*2 + wall*2;

difference(){
  // Outter cube
  cube([case_l, case_w, case_h], center=true);
  // Inner cube space
  translate([0,0,case_h/3])
  scale([1,lr44_tol_mult,1])
  cube([case_l-wall*2, lr44_h*lr44_n, case_h-wall*2], center=true);
  // Battery space
  rotate([-90,0,0])
  scale([lr44_tol_mult,lr44_tol_mult,lr44_n*lr44_tol_mult])
  cylinder(h=lr44_h, r=lr44_r, center=true, $fn=20);
}