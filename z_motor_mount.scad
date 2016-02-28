use <roadrunnerxy_lib.scad>;
$fn=96;
NEMA_MOTOR_SIZE = 17;
NEMA_MOTOR_BOLT = 4; // M4 bolt
NEMA_MOTOR_CLEARANCE = 80; // 30mm diam clearance zone. 

/* A motor mount (2D) */
module nema_motor_mount(motor_bolt_distance, shaft_clearance) {

    border_size = 4*NEMA_MOTOR_BOLT + motor_bolt_distance;

   difference() {
       square(border_size, center=true);
       union() {
           rect_hole_pattern(motor_bolt_distance, motor_bolt_distance, NEMA_MOTOR_BOLT);
           circle(0.5*shaft_clearance, center=true);
        }
    }
}

module mount_8020() {
    /* 8020 mounts are 19.1mm apart from center. */
    difference() {
        square(38.2+10, center=true);
        rect_hole_pattern(38.2, 25, 4);
    }
}

module strut(size, blocksize) {


    llen = sqrt( blocksize*blocksize + blocksize*blocksize);

    union() {
        translate([size, 0])square(blocksize, center=true);
        translate([0, size])square(blocksize, center=true);

        translate([0.5*size,0.5*size])rotate(45,45,0) square([llen,blocksize], center=true);
    }

}


/*
rotate([90,0,0])union() {
translate([5,0,34])rotate([0,90,0]) linear_extrude(height=5) nema_motor_mount(45, NEMA_MOTOR_SIZE, NEMA_MOTOR_CLEARANCE);
linear_extrude(height=5) mount_8020();
}*/

strut(size=10, blocksize=4);