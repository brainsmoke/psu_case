
use <utils.scad>
use <grid.scad>

use <mw_lrs.scad>
use <powerplug.scad>
use <power_shield.scad>
use <xt.scad>

$fn=16;
e=.001;

depth=40;

xt60_loc = [ [-47,-depth, 15], [-27,-depth, 15], [-7,-depth, 15] ];
plug_loc = [5,-depth, 1.5];

margin = 0.15;

xt60_margin = 0.25;
xt60m_margin = 1;

xt60_thickness = 1.5;
plug_thickness = 2;

case_w_inner = 115+2*margin;
case_h_inner = 30+2*margin;
case_thickness = 3;
case_front_thickness = 1.5;
case_w = case_w_inner + 2*case_thickness;
case_d = depth + 40;
case_h = case_h_inner + 2*case_thickness;

case_dim = [case_w, case_d, case_h];
case_dim_inner = [case_w_inner, case_d, case_h_inner];
case_dim_inside = [(case_w_inner+case_w)/2, case_d, (case_h_inner+case_h)/2];

bump_corner=(case_thickness+margin)*2.5;


front = [0,-1, 0];
bottom_front = [0,-1,-1];

grid_rows = 3;
grid_cols = 11;
grid_pitch = 10;
grid_thickness = .8;
grid_depth=12;
grid_xoff =-2;

screw_thread=3;
screw_hole_r=(screw_thread*.9)/2;
screw_hole_border=2;

mw_lrs_gap_d = 18.5;

preview()
{
	mw_lrs();

	for ( p = xt60_loc )
	translate(p)
	rotate([90,90,0])
	xt60f();

	translate(plug_loc)
	plug();

	translate(plug_loc)
	power_shield();
}

module cutout()
{
	mw_lrs_keepout(margin=margin);

	for ( p = xt60_loc )
	translate(p)
	translate([0,0,0])
	rotate([90,90,0])
	xt60f_cutout(margin=xt60_margin,m_margin=xt60m_margin,e=e);

	translate(plug_loc)
	{
	plug(margin=margin, , extra_depth=-2);
	plug_latches(margin=margin);
	}

	mw_lrs_holes()
	m4_hole(10);

	mw_lrs_vents_keepout(h=10, margin=1);
}

module shell()
{
	difference()
	{
		translate([0, -depth, -case_thickness-margin])
		rounded_block_y(case_dim, bottom_front, r=case_thickness);

		translate([0, -depth+case_front_thickness, -margin])
		chamfer_block([case_w_inner, case_d, case_h_inner], bottom_front, r=case_thickness);
	}
}

module round_corner(w)
{
	difference()
	{
		rotate([90,0,0])
		cylinder(w, r1=w, r2=0);
		union()
		{
			translate([-w-e,-w,-w])
			cube([w,w*2,w*2]);

			translate([-w,-w,-w-e])
			cube([w*2,w*2,w]);
		}
	}
}


module bump_corner(w)
{
	round_corner(w, $fn=4);
}

module front_grid()
{
	translate([0, -depth+e,-case_thickness/2])
	xz_toward_y()
	anchor(case_dim_inside, bottom_front)
	grid(case_dim_inside.x, case_dim_inside.z, case_thickness+grid_depth-e, grid_rows, grid_cols, pitch=grid_pitch, bar_width=grid_thickness, x_off=grid_xoff, y_off=0);
}

module at_panel_screws()
{
	for (x=[ -12, -42 ])
	for (z=[ 5, 25 ])
	translate([x,-depth, z])
	children();
}


module cover()
{
	difference()
	{
		union()
		{
			shell();
	
			intersection()
			{
				union()
				{
					front_grid();
					translate(plug_loc)
					plug(margin=margin+plug_thickness, extra_depth=-2);
	
					for ( p = xt60_loc )
					translate(p)
					rotate([90,90,0])
					xt60f_shell_cutout(margin=  xt60_margin+xt60_thickness,
					                 m_margin=xt60m_margin+xt60_thickness);

					at_panel_screws()
					translate([0,-e, 0])
					xz_toward_y()
					linear_extrude(15.7+e)
					circle(screw_hole_r+screw_hole_border);

				}
				translate([0, -depth+e, case_h_inner/2])
				block(case_dim_inside, front);
			}

			translate([0,-margin,case_h_inner/2-margin])
			for (x=[1, -1])
			for (z=[1, -1])
			scale([x, 1, z])
			translate([-case_w_inner/2, 0,-case_h_inner/2])
			bump_corner(bump_corner);
		}
		union()
		{
			cutout();

			at_panel_screws()
			translate([0,case_thickness+e, 0])
			xz_toward_y()
			linear_extrude(15.7)
			circle(screw_hole_r);
		}
	}
}

#cover();

