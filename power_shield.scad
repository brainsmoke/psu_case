
use <utils.scad>
use <grid.scad>

use <mw_lrs.scad>
use <powerplug.scad>
use <xt.scad>

$fn=16;
e=.001;


margin=.15;
shield_thickness=1.;
shield_bottom=.6;

border_w=51;
border_h=31.2;
border_d=3.5;

w=47;
h=26.8;
d=22;
chamf=4;


flap_a_w=10;
flap_a_x=4;

flap_b_w=7;
flap_b_x=33;

flap_h=1;
flap_latch=.8;

corner=1;

module plug_keepout(margin=0, depth=39, e=0)
{
	$fn=16;

	d = .1+e;
	border_w = border_w-2*corner;
	border_h = border_h-2*corner;
	w = w-2*corner;
	h = h-2*corner;
	r = corner+margin;
	off = 16.5;

	color([.3,.3,.3])
	translate([corner,depth-.1,corner])
	rotate([90,0,0])
	{
		translate([(border_w-w)/2,0,-d])
		linear_extrude(d+e)
		hull()
		for (p=[ [off, 0],
		         [off, h],
		         [w-chamf, h],
		         [w, h-chamf],
		         [w, chamf],
		         [w- chamf, 0],
		])
		translate(p)
		circle(r);
	}
}

module plug_hull(margin, d, e=0)
{
	hull()
	{
		difference()
		{
		plug(margin=margin, extra_depth=5+shield_bottom);
		translate([-10,-10,-10])
		cube([100, 30, 100]);
		}
		plug_keepout(margin=margin, depth=d, e=0);
	}
	plug_keepout(margin=margin, depth=d, e=e);
	
}

inner_w=.8;

module power_shield()
{
color("red")
	union()
	{
	difference()
	{
		union()
		{
			plug_hull(margin=margin+shield_thickness, d=39);
		}
		union()
		{
		plug_hull(margin=margin, d=38, e=2);
		}
	}

	intersection()
	{
		plug_hull(margin=margin+shield_thickness/2, d=38.5, e=2);
		difference()
		{
			union()
			{
				translate([(border_w-w)/2+8.5-inner_w/2, 22, h/2-4-inner_w/2])
				cube([inner_w, 20, 20]);

				translate([(border_w-w)/2+8.5, 22, h/2-4-inner_w/2])
				cube([9., 17, inner_w]);

				translate([(border_w-w)/2+17.5-inner_w/2, 22, h/2-4-inner_w/2])
				cube([inner_w, 17, 10]);

				translate([(border_w-w)/2+15-inner_w/2, 38.4, h/2-4-inner_w/2])
				cube([2.5, shield_bottom, 10]);

				for (y=[0,h])
				for (x=[0,w-2])
				translate([(border_w-w)/2+x-5/sqrt(2)-inner_w/2, 22, y])
				rotate([0,45,0])
				cube([5,1,5]);

			}
			translate([(border_w-w)/2+6.5-inner_w/2, 21, h/2-6/2-inner_w/2])
			cube([5, 2, 5.5]);
		}
	}
}
}

power_shield();

//preview()
//plug();
