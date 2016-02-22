use <roadrunnerxy_lib.scad>;

/* belt holder for X. */

belt_thickness = 1.38; // random guess for GT2
plate_thickness = 3.75; // thickness of baseplate. 
bolt_size = 4.0; // M4 bolt

hole_dist_x = 26;
hole_dist_y = 30.5;

grip_offset_y = 6.15; // distance from center (X) that we need to go
grip_offset_x = 7;



belt_wedge_radius = 1.1;
belt_wedge_offset = belt_thickness+belt_wedge_radius;
belt_post_offset = 4.2;
belt_post_radius = belt_thickness+0.5;
belt_post_clearance = belt_post_radius + belt_thickness;


$fn = 64;

module belt_gripper() {
	// the belt gripper holds the belt ;)
	
	
	
}

module base() {
    /* We're going to make the outer shell, remove the bolt holes, then the indents. */
    difference() {
        /* This is the plate itself */
        linear_extrude(height=plate_thickness)difference() {
            /* Here we define the outer hull */
            hull() { translate([-0.5*hole_dist_x, 0, 0]) circle(d=4.5+bolt_size, center=true);
                     translate([ 0.5*hole_dist_x, 0, 0]) circle(d=4.5+bolt_size, center=true);
                     translate([0,belt_post_offset+2*belt_post_radius, 0]) square([hole_dist_x,2*belt_post_clearance], center=true);
                }
            /* Here we define the holes themselves. */
            union() {
                translate([0.5*hole_dist_x, 0, 0]) circle(d=bolt_size, center=true);
                translate([-0.5*hole_dist_x,0, 0]) circle(d=bolt_size, center=true);
                }
        }
        
        translate([0,0,plate_thickness-(0.5*bolt_size)]) linear_extrude(height=plate_thickness) union() {
            translate([-0.5*hole_dist_x, 0, 0]) circle(d=bolt_size+3, center=true);
            translate([0.5*hole_dist_x, 0,0]) circle(d=bolt_size+3, center=true);
        } 
    }
}

module gt2_grip() {

        translate([-2, 0,0]) linear_extrude(height=5) union() {
                        translate([belt_post_offset,0,0]) circle(belt_post_radius,center=true);

            difference() {
                union() {
                    hull() {
                        translate([0,belt_wedge_offset,0]) circle(belt_thickness,center=true);
                        translate([5,belt_wedge_offset+0.5*belt_thickness,0] ) square(belt_wedge_radius,belt_wedge_radius, center=true);
                }
                hull() {
                    translate([0,-1*belt_wedge_offset,0]) circle(belt_thickness,center=true);
                    translate([5,-1*(belt_wedge_offset+0.5*belt_thickness),0] ) square(belt_wedge_radius,belt_wedge_radius, center=true);
                }
            }
            translate([belt_post_offset, 0,0]) circle(belt_post_clearance, center=true);
        }
    }
        
}

color("blue") translate([-1*grip_offset_x,grip_offset_y,plate_thickness])gt2_grip();
color("gray") translate([grip_offset_x, grip_offset_y, plate_thickness]) rotate([0,0,180]) gt2_grip();
base();