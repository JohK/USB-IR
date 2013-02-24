$fn=50;

brd_width = 25.4;
brd_length = 63.5;
brd_height = 8;

wall = 1;

o_width = brd_width+2*wall;
o_length = brd_length+2*wall;
o_height = brd_height+2*wall;
o_cornrad = 5;

// screw 1 x:-16.51  y: 3.81
// screw 2 x:-39.37  y: 3.81
// screw 3 x:-16.51  y:21.59

y_irled = 15.24;
z_irled = 7.5;

x_sled = -30.48;
y_sled = 6.35;

y_usb = brd_width/2;


translate([0, 0, wall]) board();


color("Yellow", 0.5)
difference(){
	square_rounded(l=o_length,w=o_width,h=o_height, r=o_cornrad, center=true);
	square_rounded(l=brd_length,w=brd_width,h=brd_height, r=o_cornrad-wall, center=true);
	translate([0,0,6]) cube([250,250,10], center=true);
}

translate([0,0,-o_height/2+wall+0.75])
difference(){
	square_rounded(l=brd_length,w=brd_width,h=1.5, r=o_cornrad-wall, center=true);
	square_rounded(l=brd_length-2,w=brd_width-2,h=2+0.1, r=o_cornrad-wall-1, center=true);
}

//	


/*difference() {

color("Yellow", 0.5)
hull() {
	translate([wall-o_cornrad, o_cornrad-wall, 0]) cylinder(r=o_cornrad, l=1, h=o_height);
	translate([o_cornrad-wall-brd_length, o_cornrad-wall, 0]) cylinder(r=o_cornrad, l=1, h=o_height);
	translate([o_cornrad-wall-brd_length, wall-o_cornrad+brd_width, 0]) cylinder(r=o_cornrad, l=1, h=o_height);
	translate([wall-o_cornrad, wall-o_cornrad+brd_width, 0]) cylinder(r=o_cornrad, l=1, h=o_height);
}


translate([0,0,wall])
hull() {
	translate([wall-o_cornrad, o_cornrad-wall, 0]) cylinder(r=o_cornrad-wall, l=1, h=brd_height);
	translate([o_cornrad-wall-brd_length, o_cornrad-wall, 0]) cylinder(r=o_cornrad-wall, l=1, h=brd_height);
	translate([o_cornrad-wall-brd_length, wall-o_cornrad+brd_width, 0]) cylinder(r=o_cornrad-wall, l=1, h=brd_height);
	translate([wall-o_cornrad, wall-o_cornrad+brd_width, 0]) cylinder(r=o_cornrad-wall, l=1, h=brd_height);
}

//translate([-brd_length, 0, wall]) cube([brd_length, brd_width, brd_height]);

// ir-LED hole
translate([-brd_length, y_irled, z_irled]) rotate([0, -90, 0]) hole_led(d=5);

// status LED hole
translate([x_sled, y_sled, o_height-wall]) hole_led(d=2);

// usbA
translate([0,y_usb,wall+4]) hole_usbAm();

translate([-o_length,-2*wall,o_height-wall-3]) cube([250,250,10]);
};*/


module board() {
	color("DarkGreen") translate([-brd_length, 0, 0]) cube([brd_length, brd_width, 1.5]);
	translate([-24.75, 0, 0.7]) import_stl("../board/irusb.stl");
}

module hole_led(d=5, h=5, cld=0.2) {
	translate([0,0, h/2]) cylinder(r=d/2+cld/2, h=h, center=true);
}

module hole_usbAm(l=15, clw=0.2, clh=0.2) {
	translate([l/2,0,0]) cube([l,12+clw,4.5+clh], center=true);
}



module square_rounded(l=60,w=25,h=10,r=5, center=false) {
	translate(center ? [0,0,0] : [l/2,w/2,0])
	hull() for(m=[[0,0,0], [1,0,0], [l-r*2,w-r*2,0], [0,1,0]])
		mirror(m) translate([l/2-r, w/2-r, 0]) cylinder(h=h,r=r, center=center);
}