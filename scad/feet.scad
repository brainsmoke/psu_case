
use <cover.scad>
use <mw_lrs.scad>

$fn=50;

case_thickness = 3;

feet_front_h = 3.3;
feet_back_h = feet_front_h + case_thickness;
indent_h = 2.5;
min_h=1.;
padd = 3;

feet_d=20;
feet_indent_d = 15.2;

border = 1.2;

pitch = feet_d+padd;

module foot(h, d, indent_h, indent_d, ring_h=0)
{
	b=1;
	difference()
	{
		cylinder(h=h, r=d/2);
		union()
		{
			translate([0,0,h+b])
			rotate([180,0,0])
			cylinder(h=b+indent_h, r=indent_d/2);

			translate([0,0,h])
			m4_hole(h+b, margin=.25);

			difference()
			{
				translate([0,0,h+b])
				rotate([180,0,0])
				cylinder(h=b+h-ring_h, r=indent_d/2-border);

				translate([0,0,-b])
				cylinder(h=2*b+h, r=4/2+border);
			}
		}
	}
}

for (x=[0,pitch])
{
	translate([x, 0, 0])
	foot(feet_front_h, feet_d, indent_h, feet_indent_d, min_h);

	translate([x, pitch, 0])
	foot(feet_back_h, feet_d, indent_h, feet_indent_d, min_h);
}

