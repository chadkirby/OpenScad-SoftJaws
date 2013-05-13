jaw_width = 125;
jaw_height = 21;
jaw_depth = 12;
surround_depth = 5;
surround_thickness = 3;
fudge_factor = 0.5;

magnet_diameter = 10;
magnet_depth = 4;
magnet_count = 3;

guide_radius = 2;
guide_angles = [45, 90];
guide_count = 1;

jaw_pattern = 0;
jaw_depth = 6;

mOff = jaw_width/magnet_count;
gOff = jaw_width/len(guide_angles);
jDepth = max(jaw_depth, 
  magnet_depth + 
  (len(guide_angles) > 0 ?  guide_radius : 0) +
  1.5
);

difference() {
  translate([
    surround_thickness + fudge_factor,
    -jaw_height/2-surround_thickness-fudge_factor,
    0])
    difference() {
      cube([
        jaw_width + fudge_factor*2 + surround_thickness*2, 
        jaw_height + fudge_factor*2 + surround_thickness*2, 
        jDepth + surround_depth]);
      translate([surround_thickness, surround_thickness, jDepth]) 
        cube([jaw_width + fudge_factor*2, jaw_height + fudge_factor*2, surround_depth]);
      for (step = [magnet_count-1 : 0]) {
        translate([surround_thickness + fudge_factor + mOff*(step+0.5), jaw_height/2 + surround_thickness, jDepth - magnet_depth])
          #cylinder(r=magnet_diameter/2, h=magnet_depth, center=false);
      }
    }
    for (i = [len(guide_angles)-1:0])
      translate([gOff*(i+0.5),0])
        rotate([0,90,guide_angles[i]])
          #cylinder(r=guide_radius, h=2*jaw_width, center=true, $fn=4);
}