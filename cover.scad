
use <utils.scad>
use <grid.scad>

use <mw_lrs.scad>
use <powerplug.scad>
use <xt.scad>

$fn=16;
e=.001;

depth=40;

xt60_loc = [ [-47,-depth, 15], [-27,-depth, 15], [-7,-depth, 15] ];
plug_loc = [5,-depth, 0];

margin = 0;

case_w_inner = 115+2*margin;
case_h_inner = 30+2*margin;
case_thickness = 2;
case_w = case_w_inner + 2*case_thickness;
case_d = depth + 40;
case_h = case_h_inner + 2*case_thickness;

case_dim = [case_w, case_d, case_h];
case_dim_inner = [case_w_inner, case_d, case_h_inner];
case_dim_inside = [(case_w_inner+case_w)/2, case_d, (case_h_inner+case_h)/2];

bottom_front = [0,-1,-1];

grid_rows = 3;
grid_cols = 12;
grid_pitch = 10;
grid_thickness = .8;
grid_depth=12;
grid_xoff =3;

screw_thread=3;
screw_hole_r=(screw_thread*.9)/2;
screw_hole_border=2;

preview()
{
	mw_lrs();

	for ( p = xt60_loc )
	translate(p)
	rotate([90,90,0])
	xt60f();

	translate(plug_loc)
	plug();
}

module cutout(margin=0)
{
	mw_lrs_keepout(margin=margin);

	for ( p = xt60_loc )
	translate(p)
	translate([0,case_thickness,0])
	rotate([90,90,0])
	xt60f_cutout(margin=margin);

	translate(plug_loc)
	plug(margin=margin);

	mw_lrs_holes() m4_hole(10);

	mw_lrs_vents_keepout(h=10, margin=1);
}

module shell()
{
	difference()
	{
		translate([0, -depth, -case_thickness])
		rounded_block_y(case_dim, bottom_front, r=case_thickness);

		translate([0, -depth+case_thickness, 0])
		chamfer_block([case_w_inner, case_d, case_h_inner], bottom_front, r=case_thickness);
	}
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
					plug(margin=margin+case_thickness);
	
					for ( p = xt60_loc )
					translate(p)
					rotate([90,90,0])
					xt60f_shell_cutout(margin=margin+case_thickness);

					at_panel_screws()
					translate([0,-e, 0])
					xz_toward_y()
					linear_extrude(15.7+e)
					circle(screw_hole_r+screw_hole_border);

				}
				translate([0, -depth+e, -e])
				block(case_dim_inside, bottom_front);
			}
		}
		union()
		{
			cutout(margin);

			at_panel_screws()
			translate([0,case_thickness+e, 0])
			xz_toward_y()
			linear_extrude(15.7)
			circle(screw_hole_r);
		}
	}
}

#cover();
