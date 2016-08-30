esp_w = 12.7;
esp_l = 18;
esp_ps = 2.0; // pin space
esp_po = 1.3; // pin offset of first pin from side (aligned)
esp_po = 2.9; // pin offset of first pin from side (centered)
esp_pc = 7; // pin count (one side)
esp_h = 4; // ESP Socket height
esp_d = 1;

wd = 1; // wire diameter

sw = 8; // 7*2.54;
sl = 7;





difference() {
	// base block;
	translate([-sw*2.54/2,0,0]) cube([sw*2.54,sl*2.54,esp_h]);
	// esp body
	translate([-esp_w/2,0,1]) cube([esp_w,esp_l,5]);


	for(i = [1:esp_pc]) {
		translate([0,esp_po+(i-1)*esp_ps,3])
			cube([esp_w+wd*0.5,wd,5],center=true);

		translate([((sw-1)*2.54)/2,2.54/2+(i-1)*2.54,esp_h/2+0.1])
			#cylinder(r=wd/1.5/cos(180/8),h=esp_h,$fn=8,center=true);
			
		translate([((sw-1)*2.54)/-2,2.54/2+(i-1)*2.54,esp_h/2+0.1])
			#cylinder(r=wd/1.5/cos(180/8),h=esp_h,$fn=8,center=true);


		hull() {
			translate([((sw-1)*2.54)/2,2.54/2+(i-1)*2.54,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
			translate([esp_w/2+wd,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
		}

		hull() {
			translate([((sw-1)*2.54)/-2,2.54/2+(i-1)*2.54,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
			translate([-esp_w/2-wd,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
		}

		hull() {
			translate([esp_w/2+wd,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
			translate([-esp_w/2-wd,esp_po+(i-1)*esp_ps,esp_h])
				#cylinder(r=wd/2/cos(180/8),h=1.4,$fn=8,center=true);
		}

	}

}


module esp_dummy() {
	translate([-esp_w/2,0,1.2]) cube([esp_w,esp_l,1.1]);
}