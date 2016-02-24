use <roadrunnerxy_lib.scad>;
$fn=64;

pad_only = false;


module extrusion() {
translate([0,0,-10]) color("black", 0.5) scale(25.4) dxf_extrude(file="1530.dxf", layer="0", height=2);
}
module pad() {
    // remove a bolt from a small pad.
    difference() {
        dxf_extrude(file="bearing_outline.dxf",layer="0",height=16);
    
    translate([0,2.5,8]) rotate([90,0,0]) color("red") bolt();
    }
}

module bolt() {
    union() {
            cylinder(h=40, r=2, center=false);
            cylinder(h=2, r1=(7.5/2), r2=2,center=false);
            translate([0,0,-4])cylinder(h=4,r=(7.5/2),center=false);
    }
    }



if(pad_only == true) { pad(); }
else {
    union() {
    // for debugging
        translate([0,-19,-10]) extrusion();
        color("purple") translate([-19.3,-5,0]) rotate([0,0,180]) pad();
        color("red") translate([18.7,-5,0]) rotate([0,0,180]) pad();
    }
}
