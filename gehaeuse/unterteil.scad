use <roundedcube.scad>

$fn=60;
eps=0.001;

boxw = 134;
boxd = 73;
boxh = 7.5;

boardw = 90.5;
boardd = 70.5;
boardh = 1.5;

module bodenplatte() {
    box_cornerr = 2;

    box_nibd = 8.9;
    box_nib_spaced = 58;
    box_nib_spacew = 121.5;

    translate([0,0,boxh/2])
    difference() {
        roundedcube([boxw, boxd, boxh], center=true, radius=box_cornerr, apply_to="z");

        // befestingungen 
        for(x = [-box_nib_spacew/2, box_nib_spacew/2]) {
            for(y = [-box_nib_spaced/2, box_nib_spaced/2]) {
                translate([x,y,-eps-boxh/2])
                cylinder(d = box_nibd, h=2*eps + boxh);
                
            }
        }
    }
}

module board() {
    spaceh=4.5;
    spacew=5.5;
    spaced=2;
    fullspacew=40;
    
    screwd = 3.3;

    translate([0,0,boardh/2])
        cube([boardw, boardd, boardh], center=true);
    
    translate([0,0,-spaceh/2+eps])
        roundedcube([boardw-2*spacew, boardd - 2*spaced, spaceh], center=true, radius=2, apply_to="z");
    
    translate([(boardw-2*spacew) / 2 - fullspacew, -(boardd - 4*spaced)/2, -boxh - eps])
    roundedcube([fullspacew - spacew, boardd - 4*spaced, boxh+2*eps], radius=2, apply_to="z");
    
    for(x = [-1, 1]) {
        for(y = [-1, 1]) {
            translate([x*(boardw/2 - screwd/2 - 1.8), y*(boardd/2 - screwd/2 - 0.9) , -boxh])
            union() {
                cylinder(d=screwd, h= boxh+2*eps);
                cylinder(d=4.5, h= 4);
            }
        }
    }
}

difference() {
bodenplatte();

translate([0, 0, boxh - boardh + eps])
board();    
}