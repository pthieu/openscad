use <MCAD/triangles.scad>;
use <text_on.scad>;

$fn = 100;
width = 100; // x
depth = 100; // y
height = 50; // z
wallThickness = 3; // affects bottom as well
hingeOuter = 9; // hinge outter diameter
hingeInner = 3.1; // hinge hole
hingeInnerSlop = .3;
hingeFingerSlop = .3;
fingerLength = hingeOuter/1.65; //length of hinge coming out (x and z axis)
fingerSize = 10; // width of hinge circles (y axis) (not radius)
topFingerSize = fingerSize;
pos = -depth/2; //??
latchWidth = 8; // locking latch width (y axis)
z = 0;

tolerance = 0.4;
//ring base supports
ringbase_l = 65 + tolerance;
ringbase_w = 60 + tolerance;
ringbase_h = 10;
ringbase_wall = 3;

//electronics cover
elec_tolerance = 0.2;
elec_l = width - (wallThickness * 2) - elec_tolerance;
elec_w = width - (wallThickness * 2) - elec_tolerance;
elec_h = 3; // wall size?
elec_pillar_l = ringbase_l+ringbase_wall;
elec_pillar_w = ringbase_w+ringbase_wall;
elec_pillar_h = height-elec_h-wallThickness-elec_tolerance*2;
elec_z = elec_pillar_h+elec_h/2+wallThickness;

//speaker
speaker_outter_l = 58;
speaker_outter_w = 58;
speaker_outter_h = 2; // total height of slot (includes wall?)
speaker_inner_l = 53;
speaker_inner_w = 53;
speaker_inner_h = 1; // height of slot thing that gets slotted into rails
speaker_slot_wall = 4;
speaker_x = width/2 + hingeOuter/2+hingeFingerSlop + 10;
speaker_z = speaker_outter_h/2+wallThickness;
speaker_insertion_size = 8;

//switch holder
sw_tolerance = tolerance;
sw_l = 6 + sw_tolerance;
sw_w = 13.5 + sw_tolerance;
sw_h = 8 + sw_tolerance;
sw_z_offset = -4;

// bottom();
// translate([30,0,30])
// rotate([0,-90,0])
top();
// electronicsCover();
// translate([0,0,0.9+wallThickness])
// speaker_holder();
// translate([0,0,50])
// ledCovers();

module ledCovers(){
	length_subtract = 5;
	angle = 47;
	angle_front = 47;
	ledCover_wall = 2;
	outter_w = elec_w;
	outter_w_front = elec_w-28;
	outter_l = (elec_w-elec_pillar_w)/2+wallThickness/2-2;
	depth_offset = tan(90-angle)*(elec_w-elec_pillar_w)/2;
	depth_offset_front = tan(angle_front)*(elec_w-elec_pillar_w)/2;
	// translate([-outter_w-8.5,-outter_l-elec_pillar_w/2+wallThickness/2,0])
	// ledCover();
	// mirror([0,1,0])
	// translate([-outter_w-8.5,-outter_l-elec_pillar_w/2+wallThickness/2,0])
	// ledCover();
	color("blue")
	translate([-outter_w+(depth_offset_front-length_subtract)/8+1,outter_w_front/2-(depth_offset_front-length_subtract)/2+3,0])
	ledCover_front();

	module ledCover(){
		difference(){
			linear_extrude(height=10+wallThickness)
				polygon(points=[
					[0,0],
					[outter_w, 0],
					[outter_w-depth_offset+ledCover_wall, outter_l],
					[depth_offset-ledCover_wall, outter_l]
				]);
			translate([0,0,-ledCover_wall])
			linear_extrude(height=10+wallThickness)
				polygon(points=[
					[ledCover_wall*2,ledCover_wall],
					[outter_w-ledCover_wall*2, ledCover_wall],
					[outter_w-depth_offset, outter_l],
					[depth_offset, outter_l]
				]);
		}
	}
	module ledCover_front(){
		rotate([0,0,180])
		difference(){
			linear_extrude(height=10+wallThickness)
				polygon(points=[
					[0,0],
					[0, outter_w_front-length_subtract],
					[depth_offset_front-length_subtract, outter_w_front-depth_offset_front+length_subtract],
					[depth_offset_front-length_subtract, depth_offset_front-length_subtract*2]
				]);
			translate([-ledCover_wall,0,-ledCover_wall])
			linear_extrude(height=10+wallThickness)
				polygon(points=[
					[0,0],
					[0, outter_w_front-length_subtract],
					[depth_offset_front-length_subtract, outter_w_front-depth_offset_front+length_subtract],
					[depth_offset_front-length_subtract, depth_offset_front-length_subtract*2]
				]);
		}
	}
}

module electronicsCover(){
// cover for electronics
	translate([-width/2 - fingerLength, 0, elec_z])
	difference(){
		union(){
			// top cover
			cube([elec_l, elec_w, elec_h], center=true);
			// support under cover (in the middle)
			translate([0,0,-elec_pillar_h/2-elec_h/2])
			cube([
				elec_pillar_l,
				elec_pillar_w,
				elec_pillar_h], center=true);
		}
		//cutout in the middle of cover
		translate([0,0,-height/2.3])
		cube([
			ringbase_l+elec_tolerance,
			ringbase_w+elec_tolerance,
			height], center=true);
	}
}

module bottom() {
	union() {
		// ring base support
		color("blue")
		translate([-width/2 - fingerLength, 0, ringbase_h/2+wallThickness])
		difference() {
			cube([
				ringbase_l+ringbase_wall*2,
				ringbase_w+ringbase_wall*2,
				ringbase_h], center=true); // main supports
			cube([
				ringbase_l+ringbase_wall+tolerance,
				ringbase_w+ringbase_wall+tolerance,
				ringbase_h], center=true); // inner space
			cube([
				ringbase_l+ringbase_wall*2,
				ringbase_w/2+ringbase_wall*2,
				ringbase_h], center=true); // x axis space
			cube([
				ringbase_l/2+ringbase_wall*2,
				ringbase_w+ringbase_wall*2,
				ringbase_h], center=true); // y axis space
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
			union(){
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
				for  (i = [-depth/2 + fingerSize:fingerSize*2:depth/2]) {
					if (i > -width/4){
						translate([-fingerLength,i - fingerSize + hingeOuter/3/2,1]) {
							translate([(hingeOuter+hingeInner)/2+0.2,0,height-hingeOuter/2])
							rotate([90,3,0])
							linear_extrude(height=hingeOuter/3)
								polygon(points=[[0,0],[0,hingeOuter],[hingeOuter,hingeOuter]]);
						}
					}
				}
			}
			// finger cutouts
			for  (i = [-depth/2 + fingerSize:fingerSize*2:depth/2]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,height*2]);
				}
			}
			// center rod
			translate([0, -depth/2, height]) {
				rotate([-90,0,0]) {
					cylinder(r = hingeInner/2-0.1, h = depth);
				}
			}
		}
		// Switch holder
		translate([-width+sw_l/2-wallThickness/2, depth/2-sw_w+wallThickness, height-sw_h+sw_z_offset])
		difference(){
			cube([sw_l+wallThickness,sw_w+wallThickness,sw_h+wallThickness], center=true);
			translate([0,0,wallThickness/2])
			cube([sw_l,sw_w,sw_h], center=true);
		}
		translate([-width+sw_l/2-wallThickness/2, -depth/2+sw_w-wallThickness, height-sw_h+sw_z_offset])
		difference(){
			cube([sw_l+wallThickness,sw_w+wallThickness,sw_h+wallThickness], center=true);
			translate([0,0,wallThickness/2])
			cube([sw_l,sw_w,sw_h], center=true);
		}
	}
}

module speaker_holder() {
	slide_h = 0.9;
	slide_tolerance = 0.8;
	slide_w = speaker_inner_w-speaker_slot_wall-slide_tolerance;
	slide_l = speaker_inner_l;
	speaker_r = 20;
	speaker_h = 7+1;
	speaker_tolerance = 0.4;
	speaker_wall = 1.5;
	speaker_ceiling = 2;
	rail_w = 2;
	rail_l = speaker_r*2+speaker_wall*3;
	wire_h = 5;
	wire_w = 8;
	wire_l = 10;
	wire_wall = 2;
	// translate([slide_l/2+depth/2-wallThickness*3,0,0])
	// difference(){
	// 	union(){
	// 		cube([slide_l, slide_w, slide_h],center=true);
	// 		translate([-speaker_insertion_size*1.3,0,0])
	// 		union(){
	// 			cube([
	// 				speaker_insertion_size-slide_tolerance,
	// 				speaker_inner_w-slide_tolerance*2,
	// 				slide_h],
	// 				center=true
	// 			);
	// 			translate([speaker_inner_l/2,0,0])
	// 			cube([
	// 				speaker_insertion_size-slide_tolerance,
	// 				speaker_inner_w-slide_tolerance*2,
	// 				slide_h],
	// 				center=true
	// 			);
	// 		}
	// 		// Speaker slot
	// 		translate([0,0,speaker_h/2+slide_h/2])
	// 		cylinder(r = speaker_r+speaker_wall, h = speaker_h, center=true);	
	// 		// Logo
	// 		translate([0,0,speaker_h+slide_h/2+1])
	// 		rotate([0,0,-90])
	// 		text_extrude("PGT", size=3.5, extrusion_height=2, center=true);
	// 		translate([0,0,speaker_h+slide_h/2])
	// 		cube([rail_l,rail_w,2], center=true);
	// 		translate([0,0,speaker_h+slide_h/2])
	// 		rotate([0,0,45])
	// 		cube([rail_l,rail_w,2], center=true);
	// 		translate([0,0,speaker_h+slide_h/2])
	// 		rotate([0,0,90])
	// 		cube([rail_l,rail_w,2], center=true);
	// 		translate([0,0,speaker_h+slide_h/2])
	// 		rotate([0,0,135])
	// 		cube([rail_l,rail_w,2], center=true);
	// 		// Railing
	// 		rotate([0,0,180])
	// 		translate([speaker_r+wire_l/3+0.15,0,wire_h/2-slide_h/2+wire_wall/4])
	// 		cube([wire_l-wire_wall*2, wire_w+wire_wall, wire_h+wire_wall/2], center=true);
	// 	}
	// 	rotate([0,0,180])
	// 	translate([speaker_r+wire_l/2,0,wire_h/2-slide_h/2])
	// 	cube([wire_l, wire_w, wire_h], center=true);
	// 	cylinder(r = speaker_r+speaker_tolerance, h = speaker_h*2+slide_h, center=true);
	// }
	wire_rail_l = wire_l + 22;
	// Speaker holder wire rail
	rotate([90,0,0]){
		difference(){
			color("purple")
			translate([wire_rail_l/2+11,0,wire_h/2-speaker_tolerance])
			difference(){
				cube([wire_rail_l+wire_h, wire_w-speaker_tolerance*2, wire_h-speaker_tolerance], center=true);
				translate([0,0,-speaker_wall/2])
				cube([wire_rail_l+wire_h, wire_w-speaker_tolerance*2-speaker_wall, wire_h-speaker_tolerance-speaker_wall/2], center=true);
			}
			translate([wire_rail_l/2-wire_h-speaker_tolerance*2,0,height/2-wallThickness-speaker_tolerance+slide_h])
			rotate([0,90,0])
			cube([height-wallThickness, wire_w-speaker_tolerance*2-speaker_wall, wire_h-speaker_tolerance-speaker_wall/2], center=true);
		}
		difference(){
			color("orange")
			translate([wire_rail_l/2-wire_h-speaker_tolerance/2,0,height/2-wallThickness+speaker_tolerance+slide_h])
			rotate([0,90,0])
			difference(){
				cube([height-wallThickness-1, wire_w-speaker_tolerance*2, wire_h-speaker_tolerance], center=true);
				translate([0,0,-speaker_wall/2])
				cube([height-wallThickness, wire_w-speaker_tolerance*2-speaker_wall, wire_h-speaker_tolerance-speaker_wall/2], center=true);
			}
			translate([0,0,speaker_wall])
			cube([wire_rail_l+wire_h, wire_w-speaker_tolerance*2-speaker_wall, wire_h-speaker_tolerance-speaker_wall/2], center=true);
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
			translate([speaker_inner_l/2,0,speaker_inner_h/2])
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

		// switch trigger
		translate([width-1,depth/2-wallThickness*2-sw_w,height-wallThickness+1]){
			sw_click_h=10;
			sw_click_r=1.5;
			cylinder(r=sw_click_r, h=sw_click_h);
			translate([4,-sw_click_r,-sw_click_h/2])
			rotate([90,0,180])
			linear_extrude(height=sw_click_r*2)
				polygon(points=[[0,-5],[0,sw_l],[sw_l,sw_l]]);
		}

		translate([width-1,-(depth/2-wallThickness*2-sw_w),height-wallThickness+1]){
			sw_click_h=10;
			sw_click_r=1.5;
			cylinder(r=sw_click_r, h=sw_click_h);
			translate([4,-sw_click_r,-sw_click_h/2])
			rotate([90,0,180])
			linear_extrude(height=sw_click_r*2)
				polygon(points=[[0,-5],[0,sw_l],[sw_l,sw_l]]);
		}
	}
}
