use <roadrunnerxy_lib.scad>;
$fn=64;

/*
 *
 * render modes:
 * 0 = none
 * 1 = bolt verification
 * 2 = 8020 verification
 * 3 = pad verification
 * 4 = pad + 8020 extrusion fit verification
 * 5 = bearings
 */

render_mode = 5;


module extrusion() {
translate([0,0,-10]) color("black", 0.5) scale(25.4) dxf_extrude(file="1530.dxf", layer="0", height=2);
}
module pad() {
    // remove a bolt from a small pad.
    difference() {
        dxf_extrude(file="bearing_outline.dxf",layer="0",height=16);
    
    translate([0,4.8,8]) rotate([90,0,0]) color("red") bolt();
    }
}

module bolt() {
    union() {
            cylinder(h=40, r=2, center=false);
            cylinder(h=2, r1=(7.5/2), r2=2,center=false);
            translate([0,0,-4])cylinder(h=4,r=(7.5/2),center=false);
    }
}

module pad_assy_verification() {
    union() {
    // for debugging
        translate([0,-21.2,-10]) extrusion();
        color("purple") translate([-19.1,-5,0]) rotate([0,0,180]) pad();
        color("red") translate([19.1,-5,0]) rotate([0,0,180]) pad();
    }
}

module bearing() {
    rotate_extrude($fn=256) translate([16,0,0]) import(file="round_bearing.dxf",layer="0");
}

if(render_mode == 0) {}
if(render_mode == 1) bolt();
if(render_mode == 2) extrusion();
if(render_mode == 3) pad();
if(render_mode == 4) pad_assy_verification();
if(render_mode == 5) bearing();