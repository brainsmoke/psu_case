use <cover.scad>

print_orientation()
color("red")
intersection()
{
	translate([3,-40,-3])
	cube([55, 2.4, 40]);
	cover();
}
