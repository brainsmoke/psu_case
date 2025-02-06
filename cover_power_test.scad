use <cover.scad>

color("red")
intersection()
{
	translate([3,-40,-3])
	cube([55, 1, 40]);
	cover();
}
