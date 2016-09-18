esp_w = 13; // inside space width
esp_l = 20;
esp_ps = 2.0; // pin spacing
esp_po = 1.3; // pin offset of first pin from side (aligned)
esp_po = 3.9; // pin offset of first pin from side (centered)
esp_pc = 7; // pin count (one side)
esp_h = 4	; // ESP Socket height
esp_d = 1;

wd = 1.1; // wire diameter

sw = 8.5; // 7*2.54; // width of chasis
sl = 7.5; // length of chassis, have to extend esp_l for inner space

x_offset_from_outer_wall = -0.5;
x_offset_from_inner_wall = 0;

y_offset_outer_wire = 0.5;


difference() {
	// base block;
	translate([-sw*2.54/2,0,0]) cube([sw*2.54,sl*2.54,esp_h]);
	// esp body
	translate([-esp_w/2,0,1]) cube([esp_w,esp_l,5]);


	for(i = [1:esp_pc]) {
		// middle wire bevel
		translate([0,esp_po+(i-1)*esp_ps,3])
			cube([esp_w+wd*0.5,wd,5],center=true);

		// right side outter wire hole
		translate([((sw-1)*2.54)/2+x_offset_from_outer_wall,2.54/2+(i-1)*2.54+y_offset_outer_wire,esp_h/2+0.1])
			#cylinder(r=wd/1.5/cos(180/8),h=esp_h,$fn=8,center=true);
		
		// left side outter wire hole	
		translate([((sw-1)*2.54)/-2-x_offset_from_outer_wall,2.54/2+(i-1)*2.54+y_offset_outer_wire,esp_h/2+0.1])
			#cylinder(r=wd/1.5/cos(180/8),h=esp_h,$fn=8,center=true);

		// right side wire bevel
		hull() {
			translate([((sw-1)*2.54)/2+x_offset_from_outer_wall,2.54/2+(i-1)*2.54+y_offset_outer_wire,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
			translate([esp_w/2+wd+x_offset_from_inner_wall,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
		}

		// left side wire bevel
		hull() {
			translate([((sw-1)*2.54)/-2-x_offset_from_outer_wall,2.54/2+(i-1)*2.54+y_offset_outer_wire,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
			translate([-esp_w/2-wd-x_offset_from_inner_wall,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
		}

		// both sides inner wire bevel
		// also the inner wire holes
		hull() {
			// right side inner wire holes
			translate([esp_w/2+wd+x_offset_from_inner_wall,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
				// left side inner wire holes
			translate([-esp_w/2-wd-x_offset_from_inner_wall,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
		}

	}

}


module esp_dummy() {
	translate([-esp_w/2,0,1.2]) cube([esp_w,esp_l,1.1]);
}