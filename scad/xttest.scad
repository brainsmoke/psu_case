
use <utils.scad>
use <xt.scad>
use <cover.scad>

preview()
{
        translate( [-27,-40, 15])
        rotate([90,90,0])
        xt60f();
}

#intersection()
{
cover();
translate([-37,-41,3])
cube([20,50,25]);
}
