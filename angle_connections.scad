module sqt_insert(size, rounding)
{
   cube_v = [size[0] - rounding, size[1] - 2*rounding, size[2] - 2*rounding];
   intersection()
   {
      translate([-0.5*rounding, 0, 0])
      {
         minkowski()
         {
             cube(cube_v, center=true);
             sphere(rounding);

         }
      }
      //Slice off one edge to make it flat
      translate([0, 0, 0])
      {
         cube(size, center=true);
      }
   }

}

module sqt_end_stop(size, wall_thickness, insert_rounding=2)
{
    cube([size,size,size], center=true);
    insert_size = size - 2*wall_thickness;
    translate([size - wall_thickness, 0, 0])
    {
       sqt_insert(size=[insert_size, insert_size, insert_size], rounding=insert_rounding);
    }
}

module sqt_connector(size, wall_thickness, ways=2, flat=true, insert_rounding=2)
{
  way_angles = [[0, 0, 0],[0, 0, 90],[0, 0, 180],[0, 0, 270],[0, -90, 0],[0, 90, 0]];

  if (ways == 1)
  {
    echo(flat);
    rotate([0, (flat == false ? -90 : 0), 0])
    {
      sqt_end_stop(size=size, wall_thickness=wall_thickness, insert_rounding=insert_rounding);
    }
  }
  else
  {
    union()
    {
      sqt_connector(size=size, wall_thickness=wall_thickness, ways=ways-1, flat=flat, insert_rounding=insert_rounding);
      rotate(way_angles[ways-1])
      {
        sqt_end_stop(size=size, wall_thickness=wall_thickness, insert_rounding=insert_rounding);
      }
    }
  }
}

// You can use the following statements to display the correct connector
*sqt_connector(size=25, wall_thickness=1.6, ways=1);
*sqt_connector(size=25, wall_thickness=1.6, ways=2);
*sqt_connector(size=25, wall_thickness=1.6, ways=3, flat=true);
sqt_connector(size=25, wall_thickness=1.6, ways=3, flat=false);
*sqt_connector(size=25, wall_thickness=1.6, ways=4);
*sqt_connector(size=25, wall_thickness=1.6, ways=4, flat=false);
*sqt_connector(size=25, wall_thickness=1.6, ways=5);
*sqt_connector(size=25, wall_thickness=1.6, ways=6);
