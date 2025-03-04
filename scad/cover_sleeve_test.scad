use <cover.scad>

print_orientation()
translate([0,-40,0])
color("red")
intersection()
{
	translate([-60,0,-10])
	cube([120, 1, 50]);
	cover();
}
