/*
 *Creates the parts to build a 12V battery in a 30 Caliber ammo can.
 *This design is 60 Cells Maximum in a 3 or 6 high configuration, my Cells are 20mm diameter.
 */

/* [Part to Render]*/
    Render_Top_Cell_Holder = true;
    Render_Bottom_Cell_Holder = true;
    Render_Front = true;
    Render_PCB_Shield = true;
    Render_Spacer_Top = true;
    Render_Spacer_Bottom = true;

/* [Cell Size] */
    //Basic
    Cell_Diameter = 20.70;
    //Basic
    Cell_Lenght = 69.3;

/* [Core] */

    //Distance between two cells
    Cell_Spacing = 2; 
    // The number of cells from latch to hinge
    Core_Columns = 10; 

/* [Strap] */
    //Total thickness of all straps being stacked up.
    Strap_Thickness = 2;
    //Width of the straps, add a small amount for tolerances
    Strap_Width = 8.65;

/* [Pack] */

    // Internal lenght of ammo can from latch to hinge in mm(x dim)
    Pack_Width = 254;
    // Side to Side of can
    Pack_Depth= 86.5;
    //Raise portion in the bottom of the can (Y dim)
    Pack_Indent = 6.35; 
    //Padding
    Pack_Padding = 6.5;
    //Padding Cell Side
    Pack_Padding_Cell_Side = 5;
    //how round shoud corners be. 5mm should be fine, 6.35 is 1/4in if thats your preference.
    Corner_Radius = 6.35;

/* [Wire] */
    
    // Diameter of the biggest wire's insulation. 
    Wire_Diameter = 5;

/* [Fasteners] */
    Heat_Insert_In_Shield = false;
    // this should be the smooth part before the fins. your looking to have the insert just barely get in the hole 
    Heat_Insert_Diameter = 4.2;
    // 
    Heat_Insert_Height = 5;
    Heat_Insert_Thread = 3.3;


    Screw_Head_Diameter = 7;
    Screw_Thread_Length = 20;
    Screw_Head_Height = 2;


/* [Hidden] */
    Strap_Top_Z = (Cell_Lenght/2);
    Strap_Bot_Z = -(Cell_Lenght/2)-(Strap_Thickness);

    //Top to Bottom. This is 2x the number of cells in series. 
    Core_Rows = 6; //Dont change this.
    //Thickness of the Side Covers
    Side_Thickness = (Pack_Depth - (Cell_Lenght+(Strap_Thickness*2)))/2;
    
    //Make sure we use the larger of the pack padding or the indent
    Pack_Padding_Bottom = Pack_Indent < Pack_Padding ? Pack_Padding : Pack_Indent;

    //diagonal for the side of pack on the opening
    Pack_Diagonal_Top_Length = ((sqrt(((Pack_Padding+(Cell_Diameter/2))^2)+((Pack_Padding+(Cell_Diameter/2))^2))-(Cell_Diameter/2))/2)+(Cell_Diameter/2);
    Pack_Diagonal_Top_Angle  = atan((Pack_Padding+(Cell_Diameter/2))/ (Pack_Padding+(Cell_Diameter/2)));;


    Pack_Diagonal_Bottom_Length = ((sqrt(((Pack_Padding_Bottom+(Cell_Diameter/2))^2)+((Pack_Padding+(Cell_Diameter/2))^2))-(Cell_Diameter/2))/2)+(Cell_Diameter/2);
    Pack_Diag =  ((sqrt(((Pack_Padding_Bottom+(Cell_Diameter/2))^2)+((Pack_Padding+(Cell_Diameter/2))^2)) -(Cell_Diameter/2))/2)+(Cell_Diameter/2);
    Pack_Diagonal_Bottom_Angle =  atan( (Pack_Padding+(Cell_Diameter/2))/(Pack_Padding_Bottom+(Cell_Diameter/2)));


    Screw_Pocket_Z = ((Side_Thickness - Screw_Head_Height) > (Screw_Thread_Length - 3))? Screw_Thread_Length - 3:Side_Thickness - Screw_Head_Height;



include <Core_Helper_Routines.scad>


difference(){
    union()
    {  
        if(Render_Top_Cell_Holder) 
            translate([-(Cell_Diameter/2)-Pack_Padding,-(Cell_Diameter/2)-Pack_Padding,Strap_Top_Z-Pack_Padding_Cell_Side])
            rounded_4s_Cube([((Cell_Diameter+Cell_Spacing)*Core_Columns)-Cell_Spacing+Pack_Padding+Pack_Padding, ((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Pack_Padding_Cell_Side+Strap_Thickness],Corner_Radius);

        if(Render_Bottom_Cell_Holder)
            translate([-(Cell_Diameter/2)-Pack_Padding,-(Cell_Diameter/2)-Pack_Padding,Strap_Bot_Z])
            rounded_4s_Cube([((Cell_Diameter+Cell_Spacing)*Core_Columns)-Cell_Spacing+Pack_Padding+Pack_Padding, ((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Pack_Padding_Cell_Side+Strap_Thickness],Corner_Radius);
       
        if(Render_Spacer_Top)
            translate([((Cell_Diameter+Cell_Spacing)*(Core_Columns-1))-(Cell_Diameter/2)-Pack_Padding,-(Cell_Diameter/2)-Pack_Padding,Strap_Top_Z+Strap_Thickness])
            difference() {
                rounded_4s_Cube([(Cell_Diameter)+(Pack_Padding*2), ((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Side_Thickness],Corner_Radius);
                translate([(Cell_Diameter)+(Pack_Padding*2)-Corner_Radius+0.01,0,Side_Thickness-Corner_Radius+0.01]) 
                    rotate([-90,-90,0]) 
                        difference() 
                        {
                            cube([Corner_Radius,Corner_Radius,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding]);
                            translate([0,0,-0.01]) 
                            cylinder(h=((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding+0.02, r=Corner_Radius);
                        }
            }
        if(Render_Spacer_Bottom)
            translate([((Cell_Diameter+Cell_Spacing)*(Core_Columns-1))-(Cell_Diameter/2)-Pack_Padding,-(Cell_Diameter/2)-Pack_Padding,Strap_Bot_Z-Side_Thickness])
             difference() {
                rounded_4s_Cube([(Cell_Diameter)+(Pack_Padding*2), ((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Side_Thickness],Corner_Radius);
                translate([(Cell_Diameter)+(Pack_Padding*2)-Corner_Radius+0.01,0,Corner_Radius-0.01]) 
                    rotate([-90,0,0]) 
                        difference() 
                        {
                            cube([Corner_Radius,Corner_Radius,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding]);
                            translate([0,0,-0.01]) 
                            cylinder(h=((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding+0.02, r=Corner_Radius);
                        }
            }
        if(Render_PCB_Shield){   
            color("pink")
            translate([-(Cell_Diameter/2)-Pack_Padding,-(Cell_Diameter/2)-Pack_Padding,0])
            {       
                translate([0,0,-Cell_Lenght/2+Pack_Padding_Cell_Side])
                    difference()
                    {
                        rounded_4s_Cube([Pack_Padding*2,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Cell_Lenght-(Pack_Padding_Cell_Side*2)],Corner_Radius);
                        translate([Pack_Padding,0,-0.01])cube([Pack_Padding+0.02,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Cell_Lenght-(Pack_Padding_Cell_Side*2)+0.02]);
                    }
                   
                translate([Pack_Padding,0,-Cell_Lenght/2+Pack_Padding_Cell_Side])
                    difference() {
                    cube([Cell_Diameter/2,Cell_Diameter/2+Pack_Padding,Cell_Lenght-(Pack_Padding_Cell_Side*2)]);
                    translate([Cell_Diameter/2,Cell_Diameter/2+Pack_Padding,-0.01]) cylinder(h = Cell_Lenght-(Pack_Padding_Cell_Side*2) + 0.02, d=Cell_Diameter+Cell_Spacing);
                    }
                translate([Pack_Padding,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding-(Cell_Diameter/2),-Cell_Lenght/2+Pack_Padding_Cell_Side])
                   difference() {
                    cube([Cell_Diameter/2,Cell_Diameter/2+Pack_Padding,Cell_Lenght-(Pack_Padding_Cell_Side*2)]);
                    translate([Cell_Diameter/2,0,-0.01]) cylinder(h = Cell_Lenght-(Pack_Padding_Cell_Side*2) + 0.02, d=Cell_Diameter+Cell_Spacing);
                    }

            }


        }
        if(Render_Front){
             Cell_Holder_Lenght = ((Cell_Diameter+Cell_Spacing)*Core_Columns)-Cell_Spacing+Pack_Padding+Pack_Padding;
            Front_Diff = Pack_Width - Cell_Holder_Lenght;
            difference() 
            {
                translate([-(Cell_Diameter/2)-Pack_Padding-Front_Diff,-(Cell_Diameter/2)-Pack_Padding,0]){
                    translate([0,0,-Cell_Lenght/2-Strap_Thickness])
                    difference()
                    {
                        rounded_4s_Cube([Pack_Padding*2,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Cell_Lenght+(Strap_Thickness*2)],Corner_Radius);
                        translate([Pack_Padding,0,0])cube([Pack_Padding+0.01,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Cell_Lenght+(Strap_Thickness*2)]);
                    }
                    translate([0,0,Strap_Top_Z+Strap_Thickness])rounded_4s_Cube([(Cell_Diameter+Pack_Padding)*2,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Side_Thickness],Corner_Radius);
                    translate([0,0,Strap_Bot_Z-Side_Thickness]) rounded_4s_Cube([(Cell_Diameter+Pack_Padding)*2,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding,Side_Thickness],Corner_Radius);
                }
                //round top and bottom
                for(i = [[180,Strap_Top_Z+Side_Thickness+Strap_Thickness-Corner_Radius+0.01],
                         [90,Strap_Bot_Z-Side_Thickness+Corner_Radius-0.01]])
                    translate([-(Cell_Diameter/2)-Pack_Padding-Front_Diff+Corner_Radius-.01,-(Cell_Diameter/2)-Pack_Padding,i[1]]) 
                        rotate([-90,i[0],0]) 
                            difference() 
                            {
                                cube([Corner_Radius,Corner_Radius,((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding]);
                                translate([0,0,-0.01]) 
                                cylinder(h=((Cell_Diameter+Cell_Spacing)*Core_Rows)-Cell_Spacing+Pack_Padding+Pack_Padding+0.02, r=Corner_Radius);
                            }
            }        
        }
    }

    /*
     * Core Pack Routines
     * the #'s create red silhouette
     * 
     */
    #union(){
        //Cells
        for( y = [0:Core_Rows-1],  x = [0:Core_Columns-1])
                translate(v = [x*(Cell_Diameter+Cell_Spacing),y*(Cell_Diameter+Cell_Spacing),0]) 
                    /*cube([Strap_Width,Strap_Width,Cell_Lenght],center= true);*/
                    cylinder(h=Cell_Lenght, d1=Cell_Diameter, d2=Cell_Diameter, center=true,$fn = 36);

        //Parallel Straps
        for( z = [Strap_Top_Z,Strap_Bot_Z], y = [0:Core_Rows-1])
            translate([0,y*(Cell_Diameter+Cell_Spacing)]) 
                color("red")translate([-Strap_Width/2,-Strap_Width/2,z])
                cube([((Cell_Diameter+Cell_Spacing)*(Core_Columns-1))+Strap_Width,Strap_Width,Strap_Thickness]);


        //Serial Straps
        for( z = [Strap_Top_Z,Strap_Bot_Z],  y = [0:(Core_Rows/2)-1], x = [0:Core_Columns-1])
                        color("orange") 
                            translate(v = [(x*(Cell_Diameter+Cell_Spacing))-(Strap_Width/2), (y*(Cell_Diameter+Cell_Spacing)*2)+(Strap_Width/2), z]) 
                            cube([Strap_Width, Cell_Diameter+Cell_Spacing-Strap_Width, Strap_Thickness]);
        //Serial Ties
        for( y = [0:(Core_Rows/2)-2],  x = [0:Core_Columns-1])
            color("green") 
            translate(v = [(x*(Cell_Diameter+Cell_Spacing))-(Strap_Width/2), (y*(Cell_Diameter+Cell_Spacing)*2)+(Cell_Diameter+Cell_Spacing+(Strap_Width/2)), (y%2==0)?Strap_Top_Z:Strap_Bot_Z]) 
            cube([Strap_Width, Cell_Diameter+Cell_Spacing-Strap_Width, Strap_Thickness]);
       
        //Wire Reliefs Funky transforms to make this work
        midpoint = (ceil(Core_Columns /2)*(Cell_Diameter+Cell_Spacing))-Cell_Diameter;
        midwire =  (ceil(Core_Columns /2)*(Cell_Diameter+Cell_Spacing))+(Cell_Diameter)+Pack_Padding;
        for(y = [0:1],z=[0,1])
        {
            translate([midpoint/2,(y*((Core_Rows-1)*(Cell_Diameter+Cell_Spacing))),0])rotate([180*z,0,0])translate([0,0,Cell_Lenght/2+Strap_Thickness+Wire_Diameter/4-.01]){
                 cube([midwire, Wire_Diameter, Wire_Diameter/2],center=true);
                 translate([0,0,Wire_Diameter/4]) rotate([0,90,0]) cylinder(h = midwire, d = Wire_Diameter, center=true);
            }
            
        }
        // Heat insert holes
        for(xy = [[-(Pack_Diagonal_Top_Length*cos(Pack_Diagonal_Top_Angle)), -(Pack_Diagonal_Top_Length*sin(Pack_Diagonal_Top_Angle))],
        [ -(Pack_Diagonal_Top_Length*cos(Pack_Diagonal_Top_Angle)), (Pack_Diagonal_Top_Length*sin(Pack_Diagonal_Top_Angle)+((Cell_Diameter+Cell_Spacing)*(Core_Columns-1))-Cell_Spacing)],
        [ (Pack_Diagonal_Top_Length*cos(Pack_Diagonal_Top_Angle))+((Cell_Diameter+Cell_Spacing)*(Core_Rows-1))-Cell_Spacing, (Pack_Diagonal_Top_Length*sin(Pack_Diagonal_Top_Angle)+((Cell_Diameter+Cell_Spacing)*(Core_Columns-1))-Cell_Spacing)],
        [ (Pack_Diagonal_Top_Length*cos(Pack_Diagonal_Top_Angle))+((Cell_Diameter+Cell_Spacing)*(Core_Rows-1))-Cell_Spacing,-(Pack_Diagonal_Top_Length*sin(Pack_Diagonal_Top_Angle))],
        ] , z=[0,1])
            translate([xy[1],xy[0],0]) rotate(a=[180*z,0,0]) translate([0,0,(Cell_Lenght/2+Strap_Thickness)-Heat_Insert_Height]) {
                cylinder(h=Heat_Insert_Height, d = Heat_Insert_Diameter,$fn = 36);
                translate([0,0,Heat_Insert_Height-Screw_Thread_Length+Screw_Pocket_Z])cylinder(h=Screw_Thread_Length,d=Heat_Insert_Thread*1.1,$fn = 36);
                translate([0,0,Screw_Pocket_Z+Heat_Insert_Height])cylinder(h=Side_Thickness-Screw_Pocket_Z+.01,d=Screw_Head_Diameter*1.1,$fn=36);
                if(Heat_Insert_In_Shield)
                    translate([0,0,-Strap_Thickness-Pack_Padding_Cell_Side]) cylinder(h=Heat_Insert_Height, d = Heat_Insert_Diameter,$fn = 36);
                }
        for(xy = [[0,(-Cell_Diameter/2)-Pack_Padding+Heat_Insert_Height],
                  [(Cell_Diameter+Cell_Spacing)*(Core_Columns-1),(-Cell_Diameter/2)-Pack_Padding+Heat_Insert_Height],
                 ], z = [((Cell_Lenght/2+Strap_Thickness+Side_Thickness/2)),-Cell_Lenght/2-Strap_Thickness-Side_Thickness/2])        
            translate([xy.x,xy.y,z])  rotate(a=[90,0,0]) {
                cylinder(h=Heat_Insert_Height, d = Heat_Insert_Diameter,$fn = 36);
                translate([0,0,Heat_Insert_Height-Screw_Thread_Length+Screw_Pocket_Z])cylinder(h=Screw_Thread_Length,d=Heat_Insert_Thread*1.1,$fn = 36);
                translate([0,0,Screw_Pocket_Z+Heat_Insert_Height])cylinder(h=Side_Thickness-Screw_Pocket_Z+.01,d=Screw_Head_Diameter*1.1,$fn=36);
                 }

        
        
    }
}