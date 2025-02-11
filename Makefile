
TARGETS=cover.stl cover_hole_test.stl cover_power_test.stl cover_sleeve_test.stl power_shield.stl xttest.stl
DEPS=*.scad

all: $(TARGETS)

%.stl: %.scad $(DEPS)
	openscad -o $@ $<

