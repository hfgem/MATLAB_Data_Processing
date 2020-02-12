# curvature_calculation

Author: Hannah Germaine

Summary: This repository contains a MATLAB program written to determine an approximate curvature, for some curve on a 2D plane, at all points except the end points. It also contains a sample dataset of a curve for analysis.

Detail:

# sample_curv_data.mat

The file contains an example dataset for analysis. The dataset contains the x and y values of a curve in an nx2 array. The first column of the array contains the x-values, and the second column of the array contains the y-values. To visualize this data, use plot(frac_path(:,1),frac_path(:,2))

# curv_calculator.m

This program determines the curvature at each point of a curve using an approximation method. The curve supplied must be in the form of an nx2 matrix where the first column is the x-values of the points on the curve, and the second column is the y-values of the points on the curve.

The curvature, **C**, at a point on a differentiable curve, is defined as the reciprocal of the radius (**R**) of the circle that best approximates the curve at that point, known as the osculating circle.

![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/curvature.png&s=50)

Meaning, if we were to draw a circle next to the curve, and expanded it so that it perfectly matched the contour of the curve about the point in question, the reciprocal of the radius of that circle would give us our curvature.

![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/osculating_circle.png)

(This image was borrowed from the [Wikipedia page on curvature](https://en.wikipedia.org/wiki/Curvature).)
In order to calculate this value, we will approximate the center of the circle by taking two points on our curve, on either side of each point in question, finding the tangent at those points, and determining where orthogonal lines to their tangents intersect. From here, we can approximate the radius of the circle that best describes the curve as the average distance to the point in question and the adjacent points.

Below is a breakdown of the mathematical steps:
* Let **P** be a point on the curve (other than an endpoint) and (x<sub>P</sub>,y<sub>P</sub>) be the indices of this point.
* We will first determine the adjacent points on either side of **P** and call them adj<sub>1</sub> and adj<sub>2</sub>. These points are the midpoints between **P** and the neighboring points of **P** in our dataset (x<sub>P-1</sub>,y<sub>P-1</sub>) and (x<sub>P+1</sub>,y<sub>P+1</sub>). ![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/adjacent_points.png)
* Next, we will find the slope of the line tangent to the adjacent points on the curve. To do so, we can use the neighboring points of **P** as follows: ![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/tan_slope.png)
* We can use the slope of the tangent line to find the slope of an orthogonal line going through the adjacent points as follows: ![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/orth_slope.png)
* Now we can determine the equations of orthogonal lines that pass through each adjacent point using the point-slope form of a linear equation: ![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/orth_eqns.png)
* To determine their intersection, we can set the two lines equal to each other and solve: ![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/solve_intersect.png) Of course, once x is found, we can plug it back into one of our linear equations to find y. This point will be the center of our osculating circle, and we will call it (x<sub>C</sub>,y<sub>C</sub>).
* Now that we have the center of our circle, we will approximate its radius by finding the average distance to our curve. To do so, we will take the distance to adj<sub>1</sub>, adj<sub>2</sub>, and **P**, and then take the average: ![equations](https://github.com/hfgem/MATLAB_Data_Processing/blob/master/curvature_calculation/equations/radius_calc.png)
* Finally, we need to determine the sign of our curvature. If our curve is upward facing, the value is positive, and if our curve is downward facing, the value is negative. Rather than take the second derivative of a function to find this value (as we don't have a function describing our curve), we can simply say y<sub>diff</sub> = y<sub>C</sub> - y<sub>P</sub>, and our curvature is - if y<sub>diff</sub> < 0.
