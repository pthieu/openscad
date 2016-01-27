use <MCAD/triangles.scad>;

$fn = 100;
width = 40; // x
depth = 40; // y
height = 10; // z
wallThickness = 1.5; // affects bottom as well
hingeOuter = 7; // hinge outter diameter
hingeInner = 4; // hinge hole
hingeInnerSlop = .3;
hingeFingerSlop = .3;
fingerLength = hingeOuter/1.65; //length of hinge coming out (x and z axis)
fingerSize = 6.5; // width of hinge circles (y axis) 
topFingerSize = fingerSize;
pos = -depth/2; //??
latchWidth = 8; // locking latch width (y axis)
z = 0;

//ring base supports
ringbase_lw = 20;
ringbase_h = 5;
ringbase_wall = 1.5;

bottom();
top();

module bottom() {
	union() {
		// ring base support
		translate([-width/2 - fingerLength, 0, ringbase_h/2+wallThickness])
		difference() {
			cube([ringbase_lw,ringbase_lw,ringbase_h], center=true); // main supports
			cube([ringbase_lw-ringbase_wall,ringbase_lw-ringbase_wall,ringbase_h], center=true); // inner space
			cube([ringbase_lw,ringbase_lw/2,ringbase_h], center=true); // x axis space
			cube([ringbase_lw/2,ringbase_lw,ringbase_h], center=true); // y axis space
		}

		// main box and cutout
		difference() {
			translate([-width - fingerLength, -depth/2, 0]) {
				cube([width,depth,height]);
			}
	
			translate([(-width - fingerLength) + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), height]);
			}

			// latch cutout
			translate([-width - fingerLength + (wallThickness/2), (-latchWidth/2) - (hingeFingerSlop/2), wallThickness]) {
				cube([wallThickness/2 + .1, latchWidth + hingeFingerSlop, height]);
			}

						
		}

		//latch cylinder
		difference() {
			translate([-width - fingerLength + (wallThickness/2), -latchWidth/2, height - 1]) {
				rotate([-90,0,0]) {
					cylinder(r = 1, h = latchWidth);
				}
			}
			// front wall wipe
			translate([-width - fingerLength - 5, -depth/2,0]) {
				cube([5,depth,height]);
			}
		}

		difference() {
			hull() {
				translate([0,-depth/2,height]) {
					rotate([-90,0,0]) {
						cylinder(r = hingeOuter/2, h = depth);
					}
				}
				translate([-fingerLength - .1, -depth/2,height - hingeOuter]){
					cube([.1,depth,hingeOuter]);
				}
				translate([-fingerLength, -depth/2,height-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,height]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts

			for  (i = [-depth/2 + fingerSize:fingerSize*2:depth/2]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,height*2]);
				}
			}
		}

		// center rod
		translate([0, -depth/2, height]) {
			rotate([-90,0,0]) {
				cylinder(r = hingeInner /2, h = depth);
			}
		}
	}
}

module top() {
	union() {
		difference() {
			translate([fingerLength, -depth/2, 0]) {
				cube([width,depth,height - .5]);
			}
	
			translate([fingerLength + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), height]);
			}

			
		}

		//latch
		translate([width + fingerLength - wallThickness - 1.5, (-latchWidth/2), 0]) {
			cube([1.5, latchWidth, height - .5 + 4]);
		}
		translate([width + fingerLength - wallThickness, -latchWidth/2, height - .5 + 3]) {
			rotate([-90,0,0]) {
				cylinder(r = 1, h = latchWidth);
			}
		}

		difference() {
			hull() {
				translate([0,-depth/2,height]) {
					rotate([-90,0,0]) {
						cylinder(r = hingeOuter/2, h = depth);
					}
				}
				translate([fingerLength, -depth/2,height - hingeOuter - .5]){
					cube([.1,depth,hingeOuter - .5]);
				}
				translate([-fingerLength/2, -depth/2,height-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,height]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts
			for  (i = [-depth/2:fingerSize*2:depth/2 + fingerSize]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,height*2]);
				}
				if (depth/2 - i < (fingerSize * 1.5)) {
					translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
						cube([fingerLength*2,depth,height*2]);
					}
				}
			}

			// center cutout
			translate([0, -depth/2, height]) {
				rotate([-90,0,0]) {
					cylinder(r = hingeInner /2 + hingeInnerSlop, h = depth);
				}
			}
		}
	}
}
