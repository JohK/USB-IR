$fn=50;

dim_brd = [63.5, 25.4, 10];
brd_thickness = 1.5;

brd_width = 25.4;
brd_length = 63.5;
brd_height = 10;

wall = 1;
wallv = [1,1,1];
cl_wall = 1;

o_width = brd_width+2*wall+2*cl_wall;
o_length = brd_length+2*wall+2*cl_wall;
o_height = brd_height+2*wall;

dimo = [o_length, o_width, o_height];
o_cornrad = 5;

// screw 1 x:-16.51  y: 3.81
pos_screw1 = [16.5, 21.59, 0];
// screw 2 x:-39.37  y: 3.81
pos_screw2 = [39.37, 21.59, 0];
// screw 3 x:-16.51  y:21.59
pos_screw3 = [16.51, 3.81, 0];

pos_irled = [dim_brd[0]+2*wallv[0]+0.5, 10.16, 5];
dia_irled = 5;
//y_irled = 15.24;
//z_irled = 7.5;

pos_sled = [30.48, 19.05, dim_brd[2]-2*wallv[2]];
dia_sled = 2;
//x_sled = -30.48;
//y_sled = 6.35;

pos_usb = [-3*wallv[0], dim_brd[1]/2, brd_thickness];
//y_usb = brd_width/2;


// include <nutsnbolts/cyl_head_bolt.scad>;


// board();


translate([0,0,wallv[2]+brd_thickness])  // manufact. offset

// bottom half
difference() {
	union() {
	//color("Grey", 0.2)
		case_rounded(dimo=dimo, wall=wallv, ch=7.5, cl=[2,2,1.5], r=o_cornrad, bottom=true, center=false);
	translate(pos_screw1) mountpost(ro = 2, ho = 1.5, ri = 1.5, hi = 1.75, cl_ri=0.2);

	translate(pos_screw2-[0,0,1.5]) cylinder(r=3.75,h=1.5);
	translate(pos_screw3-[0,0,1.5]) cylinder(r=3.75,h=1.5);
	}

	openings();
	translate(pos_screw2-[0,0,1.75])
		union() {
			cylinder(r=1.5,h=15,center=true);
			cylinder(r=2.75,h=2,center=true);
		}
	translate(pos_screw3-[0,0,1.75])
		union() {
			cylinder(r=1.5,h=15,center=true);
			cylinder(r=2.75,h=2,center=true);
		}


//translate([16.51,-50,-20]) cube([200,200,200]);
}


// upper half
 translate([0,-7.5,dimo[2]-wallv[2]-brd_thickness]) rotate ([180,0,0])
		
	difference(){
	union() {
		case_rounded(dimo=dimo, wall=wallv, ch=7.5, cl=[2,2,1.5], r=o_cornrad, bottom=false, center=false);
		for (pos_screw = [pos_screw2, pos_screw3]) {
			translate([0,0,dimo[2]-wallv[2]-cl_wall-brd_thickness]+pos_screw)
				rotate([180,0,0]) screwpost(do=5,di=2.3,h=7);
		}
	}

	openings();
	//translate(pos_screw2) cube(dimo);
}

module openings() {
	// ir-LED hole
	translate(pos_irled) rotate([0, -90, 0]) hole_led(d=dia_irled);
	// status LED hole
	translate(pos_sled) hole_led(d=2, cld=0.5);
	// usbA
	translate(pos_usb) hole_usbAm();
}













module case_rounded(
	dimo, // outer dimensions (vector)
	wall, // wall thicknesses (vector)
	r,    // corner radius
	ch,   // cut height (bottom, top)
	cl=[0.2, 0.2, 1], // board clearance
	bottom=true,
	center=true
 	) {

	translate(center ? [0,0,0] : dimo/2-wall-cl/2-[0,0,cl[2]/2])

	union() {

	difference(){
	union() {
		difference(){
			cube_rounded(dim=dimo,r=r,center=true);
			cube_rounded(dim=dimo-2*wall,r=r-wall[0],center=true);

			//translate([0,0,6]) cube([250,250,10], center=true);
		}

	// bevel
		translate([0,0,-dimo[2]/2+wall[2]+cl[2]/2])
		difference(){
			cube_rounded(dim=[dimo[0], dimo[1], cl[2]], r=r, center=true);
			assign(tmp = [dimo[0]-2*wall[0]-2*cl[0], dimo[1]-2*wall[1]-2*cl[1], cl[2]+0.1])
				cube_rounded(dim=tmp,r=r-wall[0]-cl[0],center=true);
		}
	} // end of union (basebody)

	translate(bottom ? [0,0, ch] : 
			            [0,0, -dimo[2]+ch])
		cube(dimo, center=true);
	}

	if (bottom) {
	// alignment
	difference() {
		for (i = [[-0.75, 1], [-0.25, 1], [0.25, 1], [0.75, 1],
                 [-0.75, -1], [-0.25, -1], [0.25, -1], [0.75, -1],
				  [-1, 0.55], [-1, -0.55],
                 [1, 0.55], [1, -0.55]]) {
			translate([i[0]*(dimo[0]/2-wall[0]),i[1]*(dimo[1]/2-wall[0]-0.1),-dimo[2]/2])
           		cylinder(d=wall[0],h=ch+1.5,center=false);
		}
			difference(){
			cube_rounded(dim=dimo,r=r,center=true);
			cube_rounded(dim=dimo-2*wall,r=r-wall[0],center=true);
		}
	}
	} // end if

	}
}







module mountpost( 
				   ro = 5,       // outer radius
                  ho = 1.5,     // height of post
                  ri = 3,       // radius of inner radius (that goes through mounting hole in pcb)
                  hi = 1.5,     // height of cyl that goes through mounting hole
                  cl_ri=0.2     // clearance for inner radius
                ) {
	translate([0, 0, -ho/2]) cylinder(r=ro, h=ho, center=true);
	translate([0, 0, hi/2]) cylinder(r=ri-cl_ri, h=hi, center=true);
	
}

module screwpost(
	di = 2.3,
	do = 5,
	h = 5,
	) {
	translate([0,0, h/2])
	difference() {
		union() {
			translate([0,0,-h/2+0.5]) cylinder(r1=do*.75, r2=do/2, h=1, center=true);
			cylinder(r=do/2,h=h,center=true); }
		cylinder(r=di/2,h=h+0.1,center=true);
	


	}
}


module board() {
	translate([0, brd_width, 0]) rotate([0, 0, 180]) 
	union() {
		color("DarkGreen") translate([-brd_length, 0, 0]) cube([brd_length, brd_width, 1.5]);
		translate([-24.75, 0, 0.7]) import_stl("../board/irusb.stl");
	}
}

module hole_led(d=5, h=5, cld=0.2) {
	translate([0,0, h/2]) cylinder(r=d/2+cld/2, h=h, center=true);
}

module hole_usbAm(l=15, clw=0.2, clh=0.2) {
	translate([l/2,0,(4.5+clh)/2]) cube([l,12+clw,4.5+clh], center=true);
}





module cube_rounded(
				dim=[1,1,1],  // dimension of "cube"
				r=0.5,          // radius of rounded corner (xy)
				center=false  // is centered?
					) {
	translate(center ? [0,0,0] : [dim[0]/2,dim[1]/2,0])
	hull() for(m=[[0,0,0], [1,0,0], [dim[0]-r*2,dim[1]-r*2,0], [0,1,0]])
		mirror(m) translate([dim[0]/2-r, dim[1]/2-r, 0]) cylinder(h=dim[2],r=r, center=center);
}


module square_rounded(l=60,w=25,h=10,r=5, center=false) {
	translate(center ? [0,0,0] : [l/2,w/2,0])
	hull() for(m=[[0,0,0], [1,0,0], [l-r*2,w-r*2,0], [0,1,0]])
		mirror(m) translate([l/2-r, w/2-r, 0]) cylinder(h=h,r=r, center=center);
}