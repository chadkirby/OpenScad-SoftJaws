jaw_width = 125;
jaw_height = 21;
jaw_depth = 6;
surround_depth = 12;
surround_thickness = 3;
overlap = 1.26;
fudge_factor = 0.5;

cutout_radius = 3; 
cutout_angles = [45,90];

gOff = jaw_width/len(cutout_angles);
jDepth = max(jaw_depth, 
  (len(cutout_angles) > 0 ?  cutout_radius : 0) +
  1.5
);
rotate([90,0,0])
translate([0,jaw_height/2 + surround_thickness,0])
difference() {
  translate([
    surround_thickness + fudge_factor,
    -jaw_height/2-surround_thickness-fudge_factor,
    0])
    difference() {
      cube([
        jaw_width + fudge_factor*2 + surround_thickness*2, 
        jaw_height + fudge_factor*2 + surround_thickness, 
        jDepth + surround_depth + fudge_factor + surround_thickness]);
      translate([surround_thickness, surround_thickness, jDepth]) 
        cube([jaw_width + fudge_factor*2, jaw_height + fudge_factor*2, surround_depth + fudge_factor]);
      translate([surround_thickness + overlap, surround_thickness+overlap+fudge_factor, jDepth + surround_depth + fudge_factor]) 
        cube([jaw_width + fudge_factor*2 - overlap*2, jaw_height + fudge_factor*2 - overlap, surround_thickness]);
    }
    for (i = [len(cutout_angles)-1:0])
      translate([gOff*(i+0.5),0])
        rotate([0,90,cutout_angles[i]])
          cylinder(r=cutout_radius, h=2*jaw_width, center=true, $fn=4);
}