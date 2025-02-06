use <cover.scad>

color("red")
intersection()
{
	translate([-60,0,-10])
	cube([120, 1, 50]);
	cover();
}
