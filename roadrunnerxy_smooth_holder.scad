dims = [32,32]; // distances for X and y
base_thickness = 5.00; // thickness of the baseplate.
bolt_size = 3.00;      // diameter in mm
rod_size = 12.02;      // diameter in mm

function tolerance(x) = 1.618033*x; // golden ratio tolerances


/*** No user servicable parts beyond this point. ***/


pos_rod_z = (0.5* tolerance(rod_size));
thickness_extend_z = base_thickness + 0.5*(tolerance(rod_size));

module hole_patterns(sz) {
            translate( [ -0.5*dims[0], -0.5*dims[1], 0] ) circle(d=sz);
            translate( [  0.5*dims[0],  0.5*dims[1], 0] ) circle(d=sz);
            translate( [ -0.5*dims[0],  0.5*dims[1], 0] ) circle(d=sz);
            translate( [  0.5*dims[0], -0.5*dims[1], 0] ) circle(d=sz);
}

$fn = 1024;
module base() {
    // the base is made up of a set of circles hulled together
    // each is offset by 0.5* the dims.
    difference() {
        // this is the outermost parts of the hole patterns.
        union() { linear_extrude (height=base_thickness) union() {
            hole_patterns(tolerance(bolt_size));
            translate( [ 0, 0.5*dims[1], 0] ) square([dims[1], tolerance(bolt_size)], center=true);
            translate( [ 0, -0.5*dims[1], 0] ) square([dims[1], tolerance(bolt_size)], center=true);
            }
            // a little ramp up the top.
            hull() {
                linear_extrude(height=base_thickness) square( [0.5*dims[0], dims[1] ], center=true);
                linear_extrude(height=thickness_extend_z) square([ 0.2*dims[0], 0.4*dims[1] ], center=true);
            }
            // some flanges around the bolt heads. This makes it look good.
            linear_extrude(height=base_thickness) hole_patterns(1.5*(tolerance(bolt_size)));
        }
        translate([0,0,-0.25*tolerance(base_thickness)])
            linear_extrude (height=tolerance(base_thickness))
                hole_patterns(bolt_size);
        }

    
}


module rod_holster() {
}

difference() {
    union() {
        base();
        translate([-0.25*dims[0],0,pos_rod_z]) rotate([0,90,0])
            linear_extrude(height=0.5*dims[0])
                circle($fn=50, d=tolerance(rod_size));
    }
    translate([-0.5*dims[0],0,pos_rod_z]) rotate([0,90,0])
            linear_extrude(height=dims[0])
                circle($fn=50, d=rod_size);

}