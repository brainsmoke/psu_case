use <cover.scad>

color("red")
intersection()
{
	translate([-17.,-40,20])
	cube([10, 30, 10]);
	cover();
}
