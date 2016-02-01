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

module sqt_90_angle(size, wall_thickness, insert_rounding=2)
{
    sqt_end_stop(size=size, wall_thickness=wall_thickness);
    insert_size = size - 2*wall_thickness;
    translate([0, size - wall_thickness, 0])
    {
       rotate([0, 0, 90])
       {
          sqt_insert(size=[insert_size, insert_size, insert_size], rounding=insert_rounding);
       }
    }

}

sqt_90_angle(size=25, wall_thickness=1.6);
