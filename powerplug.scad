
e=0.001;

border_w=51;
border_h=31.2;
border_d=3.5;

w=47;
h=26.8;
d=22;
chamf=4;

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

		translate([(border_w-w)/2,0,-d])
		linear_extrude(d+e)
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

module plug_latch(margin=0)
{
	rotate([90,0,0])
	rotate([0,90,0])
	linear_extrude(9)
	{
		polygon([ [0, -1], [0, 1+margin], [9, margin]]);
	}
}

module plug_latches(margin=0)
{
	for (x=[9.5,32])
	for (y_flip=[-1, 1])
	translate([(border_w-w)/2+x,1.8, h/2])
	scale([1,1,y_flip])
	translate([0,0,h/2])
	plug_latch(margin);
}

plug();

plug_latches()

%plug(margin=.3);
