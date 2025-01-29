e=.001;
$fn=16;

xt60_w=15.7;
xt60_h=8;
xt60f_d = 15.7;
xt60f_base_d = 8;
xt60_combined_d=24.1;
xt60_pitch=7;
xt60_chamfer=2.5;
xt60f_pin_d=5.7;
xt60m_pin_d=4.7;
xt60_pin_w=4.5;
xt60_hole_w=4.5;
xt60_corner=.5;

module xt_pins(width, height, pitch)
{
	for (p=[-pitch/2, pitch/2])
	translate([p,0,0])
	cylinder(h=height, r=width/2);
}

module xt_base(w, h, d, chamfer, corner, margin=0, e=0)
{
	w = w-2*corner;
	h = h-2*corner;
	r = corner+margin;
	translate([0,0,-e])
    linear_extrude(d+2*e)
	hull()
    for (p=[ [w/2,-h/2],
	         [-w/2+chamfer, -h/2],
	         [-w/2, -h/2+chamfer],
	         [-w/2, h/2-chamfer],
	         [-w/2+chamfer, h/2],
	         [w/2, h/2]
	])
	translate(p)
	circle(r);
}

module xt60_combined_shell_cutout(margin=0, e=0)
{
	b=1; 
	xt_base(xt60_w, xt60_h, xt60_combined_d, xt60_chamfer, xt60_corner, margin, e);
}


module xt60_combined_cutout(margin=0, e=0)
{
	b=1; 
	xt60_combined_shell_cutout(margin, e);

	translate([0, 0, -xt60f_pin_d-margin])
	xt_pins(xt60_pin_w+margin*2, xt60f_pin_d+b+margin, xt60_pitch);

	translate([0, 0, xt60_combined_d-b])
	xt_pins(xt60_pin_w+margin*2, xt60m_pin_d+b+margin, xt60_pitch);
}

module xt60f_cutout(margin=0,e=0)
{
	translate([0,0,-xt60f_d])
	xt60_combined_cutout(margin,e);
}

module xt60f_shell_cutout(margin=0,e=0)
{
	translate([0,0,-xt60f_d])
	xt60_combined_shell_cutout(margin,e);
}

module xt60f()
{
	b=1;
	translate([0,0,-xt60f_d])
	{
		xt_base(xt60_w, xt60_h, xt60f_base_d, xt60_chamfer, xt60_corner, 0, e);

		translate([0,0,b])
		difference()
		{
			xt_base(xt60_w-2*xt60_corner, xt60_h-2*xt60_corner, xt60f_d-b, xt60_chamfer, xt60_corner, 0, e);
			xt_pins(xt60_hole_w, xt60f_d, xt60_pitch);

		}

		difference()
		{
			translate([0, 0, -xt60f_pin_d])
			xt_pins(xt60_pin_w, xt60f_pin_d+b, xt60_pitch);

			translate([0, 0, -xt60f_pin_d-b])
			xt_pins(xt60_pin_w*.8, xt60f_pin_d+b, xt60_pitch);
		}
	}
}

xt60f();
%xt60f_cutout(margin=.4,e=e);

