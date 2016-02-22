/* Common bits in the RoadrunnerXY SCAD */

module rect_hole_pattern(xdist, ydist, holesize) {
            translate( [ -0.5*xdist, -0.5*ydist, 0] ) circle(d=holesize);
            translate( [  0.5*xdist,  0.5*ydist, 0] ) circle(d=holesize);
            translate( [ -0.5*xdist,  0.5*ydist, 0] ) circle(d=holesize);
            translate( [  0.5*xdist, -0.5*ydist, 0] ) circle(d=holesize);
}