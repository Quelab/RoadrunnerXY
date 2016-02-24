/* Common bits in the RoadrunnerXY SCAD */

module rect_hole_pattern(xdist, ydist, holesize) {
            translate( [ -0.5*xdist, -0.5*ydist, 0] ) circle(d=holesize);
            translate( [  0.5*xdist,  0.5*ydist, 0] ) circle(d=holesize);
            translate( [ -0.5*xdist,  0.5*ydist, 0] ) circle(d=holesize);
            translate( [  0.5*xdist, -0.5*ydist, 0] ) circle(d=holesize);
}

module dxf_extrude(file, layer="0", height, center=false) {
    linear_extrude(height=height, center=center) import(file=file,layer=layer);
}