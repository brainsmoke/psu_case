
depth=40;

xt60_loc = [ [-47,-depth, 15], [-27,-depth, 15], [-7,-depth, 15] ];
plug_loc = [5,-depth, 1.5];

margin = 0.2;

plug_margin=0.2;

xt60_margin = 0.25;
xt60m_margin = 1;

xt60_thickness = 1.5;
plug_thickness = 2;

case_w_inner = 115+2*margin;
case_h_inner = 30+2*margin;
case_thickness = 3;
case_front_thickness = 1.5;
case_w = case_w_inner + 2*case_thickness;
case_d = depth + 40;
case_h = case_h_inner + 2*case_thickness;

case_dim = [case_w, case_d, case_h];
case_dim_inner = [case_w_inner, case_d, case_h_inner];
case_dim_inside = [(case_w_inner+case_w)/2, case_d, (case_h_inner+case_h)/2];

bump_corner=(case_thickness+margin)*2.5;

front = [0,-1, 0];
bottom_front = [0,-1,-1];

grid_rows = 3;
grid_cols = 11;
grid_pitch = 10;
grid_thickness = .8;
grid_depth=12;
grid_xoff =-2;

screw_thread=3;
screw_hole_r=(screw_thread*.9)/2;
screw_hole_border=2;

mw_lrs_gap_d = 18.5;

