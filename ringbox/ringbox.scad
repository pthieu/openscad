use <MCAD/triangles.scad>;

$fn = 100;
width = 100; // x
depth = 100; // y
height = 50; // z
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
ringbase_lw = 60;
ringbase_h = 5;
ringbase_wall = 1.5;

//electronics cover
elec_tolerance = 0.2;
elec_l = width - (wallThickness * 2) - elec_tolerance;
elec_w = width - (wallThickness * 2) - elec_tolerance;
elec_h = 3;
elec_z = height-elec_h/2+30;
elec_pillar_lw = ringbase_lw+ringbase_wall;
elec_pillar_h = height-elec_h-wallThickness;

//speaker
speaker_outter_l = 30;
speaker_outter_w = 30;
speaker_outter_h = 2; // total height of slot (includes wall?)
speaker_inner_l = 27.5;
speaker_inner_w = 27.5;
speaker_inner_h = 1; // height of slot thing that gets slotted into rails
speaker_slot_wall = 2;
speaker_x = width/2 + hingeOuter/2+hingeFingerSlop;
speaker_z = speaker_outter_h/2+wallThickness;
speaker_insertion_size = 4;

bottom();
top();

module bottom() {
	union() {
		// cover for electronics
		translate([-width/2 - fingerLength, 0, elec_z])
		difference(){
			union(){
				// top cover
				cube([elec_l, elec_w, elec_h], center=true);
				// support under cover (in the middle)
				translate([0,0,-elec_pillar_h/2-elec_h/2])
				cube([elec_pillar_lw, elec_pillar_lw, elec_pillar_h], center=true);
			}
			//cutout in the middle of cover
			translate([0,0,-height/4])
			cube([ringbase_lw+elec_tolerance,ringbase_lw+elec_tolerance,height], center=true);
		}

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

			// // latch cutout
			// translate([-width - fingerLength + (wallThickness/2), (-latchWidth/2) - (hingeFingerSlop/2), wallThickness]) {
			// 	cube([wallThickness/2 + .1, latchWidth + hingeFingerSlop, height]);
			// }

						
		}

		//latch cylinder
		// difference() {
		// 	translate([-width - fingerLength + (wallThickness/2), -latchWidth/2, height - 1]) {
		// 		rotate([-90,0,0]) {
		// 			cylinder(r = 1, h = latchWidth);
		// 		}
		// 	}
		// 	// front wall wipe
		// 	translate([-width - fingerLength - 5, -depth/2,0]) {
		// 		cube([5,depth,height]);
		// 	}
		// }

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
		// support slot for speaker
		translate([speaker_x,0,speaker_z])
		difference(){
			//outter cube
			cube([speaker_outter_l,speaker_outter_w,speaker_outter_h], center=true);
			//inner cut bottom
			translate([0,0,-speaker_inner_h/2])
			cube([speaker_inner_l,speaker_inner_w,speaker_inner_h], center=true);
			//inner cut top (z)
			translate([0,0,speaker_inner_h/2])
			cube([
				speaker_inner_l-speaker_slot_wall,
				speaker_inner_w-speaker_slot_wall,
				speaker_inner_h],
				center=true
			);
			//bottom and top clears (x axis)
			cube([speaker_outter_l,speaker_inner_w-speaker_slot_wall*2,speaker_outter_h], center=true);
			translate([speaker_outter_l/2,0,0])
			cube([speaker_outter_l,speaker_inner_w-speaker_slot_wall,speaker_outter_h], center=true);
			//top (x axis), clearing top (z-axis)
			translate([speaker_outter_l/2,0,-speaker_inner_h/2])
			cube([speaker_inner_l,speaker_inner_w,speaker_inner_h], center=true);
			// middle insertion spacing
			translate([0,0,speaker_inner_h/2])
			cube([
				speaker_insertion_size,
				speaker_inner_w,
				speaker_inner_h],
				center=true
			);
		}

		difference() {
			translate([fingerLength, -depth/2, 0]) {
				cube([width,depth,height - .5]);
			}
	
			translate([fingerLength + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), height]);
			}
		}

		// //latch
		// translate([width + fingerLength - wallThickness - 1.5, (-latchWidth/2), 0]) {
		// 	cube([1.5, latchWidth, height - .5 + 4]);
		// }
		// translate([width + fingerLength - wallThickness, -latchWidth/2, height - .5 + 3]) {
		// 	rotate([-90,0,0]) {
		// 		cylinder(r = 1, h = latchWidth);
		// 	}
		// }

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
