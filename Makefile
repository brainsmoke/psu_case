
TARGETS=stl/cover.stl stl/cover_hole_test.stl stl/cover_power_test.stl stl/cover_sleeve_test.stl stl/power_shield.stl stl/xttest.stl stl/feet.stl
DEPS=scad/*.scad

all: $(TARGETS)

stl/%.stl: scad/%.scad $(DEPS)
	mkdir -p stl/
	openscad -o $@ $<

