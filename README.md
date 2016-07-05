# GJK Gilbert-Johnson-Keerthi Collision detection in MATLAB
Returns whether two convex shapes are are penetrating or not (true/false). Only works for CONVEX shapes. Plenty of comments so it should be reasonable example code to look through.

The algorithm is implemented in GJK.m. MAIN_example.m animates shapes about to collide and uses GJK.m to detect collisions. SampleShapeData.m holes face and vertex data for two sample polyhedra.

## MATLAB before 2014b
Please run MAIN_example_compatible.m instead. The way figure properties are changed has been updated.