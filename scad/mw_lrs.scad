e=.001;
$fn=16;

mw_lrs_w=115;
mw_lrs_h=30;
mw_lrs_d=215;


mw_lrs_holes_pitch_d  = 150;
mw_lrs_holes_pitch_w  = 50;
mw_lrs_holes_height_h = 12.5;

mw_lrs_gap_h = 23;
mw_lrs_gap_d = 18.5;

mw_lrs_case_thickness = 1.6;

m4_thread = 4;

mw_lrs_screw_terminal_x=8.5;
mw_lrs_screw_terminal_w=88;
mw_lrs_screw_terminal_d=15;
mw_lrs_screw_terminal_h=15;
mw_lrs_screw_terminal_pitch = 9.5;
mw_lrs_screw_terminal_gap_w = 8;
mw_lrs_screw_terminal_gap_d = 14;
mw_lrs_screw_terminal_gap_z = 7;
mw_lrs_screw_terminal_gap_h = 6;

module mw_lrs_side_holes()
{
	translate( [0, 0, mw_lrs_holes_height_h] )
	for( r = [ 0, 180 ] )
	rotate( [0, r, 0] )
	for( y = [ (mw_lrs_d-mw_lrs_holes_pitch_d)/2, (mw_lrs_d+mw_lrs_holes_pitch_d)/2 ] )
	translate( [-mw_lrs_w/2, y, 0] )
	rotate( [0, 90, 0] )
	children();
}

module mw_lrs_bottom_holes()
{
	for( x = [ -mw_lrs_holes_pitch_w/2, mw_lrs_holes_pitch_w/2 ] )
	for( y = [ (mw_lrs_d-mw_lrs_holes_pitch_d)/2, (mw_lrs_d+mw_lrs_holes_pitch_d)/2 ] )
	translate( [x, y, 0] )
	children();
}

module mw_lrs_holes()
{
	mw_lrs_side_holes() children();
	mw_lrs_bottom_holes() children();
}

module mw_lrs_screw_terminal()
{
	colors = [
		"red", "red", "red",
		"black", "black", "black",
		"green", "blue", "brown",
	];
	b=1;
	translate([mw_lrs_screw_terminal_x, mw_lrs_case_thickness, mw_lrs_h-mw_lrs_gap_h-e])
	{
		difference()
		{
			translate([-mw_lrs_screw_terminal_w/2, 0, 0])
			cube([mw_lrs_screw_terminal_w, mw_lrs_screw_terminal_d, mw_lrs_screw_terminal_h+e]);
			for (i=[0:8])
			translate([(i-4)*9.5-mw_lrs_screw_terminal_gap_w/2, -b, mw_lrs_screw_terminal_gap_z])
			cube([mw_lrs_screw_terminal_gap_w, mw_lrs_screw_terminal_gap_d+b, mw_lrs_screw_terminal_gap_h]);
		}

		for (i=[0:8])
		translate([(i-4)*9.5-mw_lrs_screw_terminal_gap_w/2, -0, mw_lrs_screw_terminal_h])
		color(colors[i])
		cube([mw_lrs_screw_terminal_gap_w,mw_lrs_screw_terminal_gap_d,.1]);

	}
}

module mw_lrs_vents()
{
	b=1;
	hole=4;
	for (y = [36, 44, 52])
	for (i = [-1, 1])
	hull()
	{
		translate([i*(19/2+hole/2), y, mw_lrs_h-mw_lrs_case_thickness-b])
			cylinder(mw_lrs_case_thickness+2*b, r=hole/2);

		translate([i*(19/2+hole/2+33), y, mw_lrs_h-mw_lrs_case_thickness-b])
			cylinder(mw_lrs_case_thickness+2*b, r=hole/2);
	}

	translate([-mw_lrs_w/2+36.7, mw_lrs_d-47.45,mw_lrs_h-mw_lrs_case_thickness-b])
		cylinder(mw_lrs_case_thickness+2*b, r=50/2);
}

module mw_lrs_vents_keepout(h, margin=0)
{
	b=1;
	hole=4;
	hull()
	for (y = [36, 44, 52])
	for (i = [-1, 1])
	{
		translate([i*(19/2+hole/2), y, mw_lrs_h-b])
			cylinder(h+b, r=hole/2+margin);

		translate([i*(19/2+hole/2+33), y, mw_lrs_h-b])
			cylinder(h+b, r=hole/2+margin);
	}

	translate([-mw_lrs_w/2+36.7, mw_lrs_d-47.45,mw_lrs_h-b])
		cylinder(h+b, r=50/2);
}

module mw_lrs()
{
	b=1; 

	union()
	{
		color([.75,.75,.75])
		difference()
		{

			translate([-mw_lrs_w/2,0,0])
			cube([mw_lrs_w, mw_lrs_d, mw_lrs_h]);

			union()
			{
				translate([-mw_lrs_w/2+mw_lrs_case_thickness, -b, mw_lrs_h-mw_lrs_gap_h] )
				cube( [ mw_lrs_w-2*mw_lrs_case_thickness, b+mw_lrs_gap_d, mw_lrs_gap_h+b] );

				translate([-mw_lrs_w/2+mw_lrs_case_thickness, mw_lrs_gap_d-e, mw_lrs_h-mw_lrs_gap_h] )
				cube( [ mw_lrs_w-2*mw_lrs_case_thickness, mw_lrs_d-mw_lrs_gap_d+e-mw_lrs_case_thickness, mw_lrs_gap_h-mw_lrs_case_thickness] );

				mw_lrs_vents();

				mw_lrs_holes()
				{
					translate([0,0,-e])
					cylinder(h=5+e, r=m4_thread/2);
				}
			}
		}
		color([.1, .3, .1])
		translate([-mw_lrs_w/2+mw_lrs_case_thickness, 0, mw_lrs_h-mw_lrs_gap_h-e])
		cube([mw_lrs_w-2*mw_lrs_case_thickness, mw_lrs_d-mw_lrs_case_thickness, e+.1]);
		mw_lrs_screw_terminal();
	}
}

module mw_lrs_keepout(margin=0, e=0)
{
	b=1; 

	w=mw_lrs_w+margin*2;
	d=mw_lrs_d+margin*2;
	h=mw_lrs_h+margin*2;

	translate([-w/2,-margin,-margin])
	cube([w, d, h]);
}

mw_lrs();
%mw_lrs_keepout(margin=.4);

module m4_hole(h, margin=0)
{
	translate([0,0,-h])
	cylinder(h=h+e, r=(m4_thread+margin)/2);
}

%mw_lrs_holes()
m4_hole(10);
