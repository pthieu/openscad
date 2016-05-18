//General
$fn = 72;
tolerance = 0.6;
wall = 2;


// Joint 1, closest to knuckles
r_L1_size = (16.4+tolerance)/2;
r_L1_ring = 5/2;


rotate_extrude(angle = 360, convexity = 10)
translate([r_L1_ring+r_L1_size, 0, 0])
circle(r = r_L1_ring);