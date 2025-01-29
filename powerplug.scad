
e=0.001;

border_w=51;
border_h=31.2;
border_d=3.5;

w=47;
h=26.8;
d=24.2-border_d;
chamf=4;


flap_a_w=10;
flap_a_x=4;

flap_b_w=7;
flap_b_x=33;

flap_h=1;
flap_latch=.8;

corner=1;

module plug(margin=0, extra_depth=0)
{
	$fn=16;

	d = d+extra_depth;
	border_w = border_w-2*corner;
	border_h = border_h-2*corner;
	w = w-2*corner;
	h = h-2*corner;
	r = corner+margin;

	color([.3,.3,.3])
	translate([corner,0,corner])
	rotate([90,0,0])
	{
		translate([0,(h-border_h)/2,0])
		linear_extrude(border_d+margin)
		hull()
		for(p=[ [0, 0],
		        [0, border_h],
		        [border_w, border_h],
		        [border_w, 0]
		])
		translate(p)
		circle(r);

		translate([(border_w-w)/2,0,-d-extra_depth])
		linear_extrude(d+extra_depth+e)
		hull()
		for (p=[ [0, 0],
		         [0, h],
		         [w-chamf, h],
		         [w, h-chamf],
		         [w, chamf],
		         [w- chamf, 0],
		])
		translate(p)
		circle(r);
	}
}

plug();

%plug(margin=.3);
