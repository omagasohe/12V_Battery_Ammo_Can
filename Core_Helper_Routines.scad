// v = vector for size of over all cube
// r = radius of corners
// pad = area not meshed
// d = "diameter" of holes
// w = width of grid work

 

module rounded_4s_Cube(v, r){
    y = 1;
    z = 2;
    hull(){
        translate([r,     r,0])cylinder(h =  v[z], r = r,$fn = 36);
        translate([v[0]-r,r,0])cylinder(h =  v[z], r = r,$fn = 36);
        translate([v[0]-r,v[1]-r,0])cylinder(h =  v[z], r = r,$fn = 36);
        translate([r,     v[1]-r,0])cylinder(h =  v[z], r = r,$fn = 36);
    }
    }
