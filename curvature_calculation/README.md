# curvature_calculation

Author: Hannah Germaine

Summary: This repository contains a MATLAB program written to determine an approximate curvature, for some curve on a 2D plane, at all points except the end points. It also contains a sample dataset of a curve for analysis.

Detail:

# sample_curv_data.mat

The file contains an example dataset for analysis. The dataset contains the x and y values of a curve in an nx2 array. The first column of the array contains the x-values, and the second column of the array contains the y-values. To visualize this data, use plot(frac_path(:,1),frac_path(:,2))

# curv_calculator.m

This program determines the curvature at each point of a curve using an approximation method. The curve supplied must be in the form of an nx2 matrix where the first column is the x-values of the points on the curve, and the second column is the y-values of the points on the curve.

The mathematics of the calculation are as follows:
* The curvature, $C$, at a point on a differentiable curve, is defined as the reciprocal of the radius ($R$) of the circle that best approximates the curve at that point, known as the osculating circle.



* Let the set of presented values be ordered by increasing value and labeled alphabetically. Thus, if there were 3 presented spatial frequencies, they would be labeled A, B, C, with A labeling the smallest value, and C the largest. 
* Next let the range of response to the presented values be denoted y<sub>A</sub>, y<sub>B</sub>, y<sub>C</sub>, ···. 
* For a peak to occur, in a 3-value example, it is desired that the range of response to B is significantly greater than the responses to A and C, in other words
P(y<sub>B</sub> >y<sub>A</sub>, y<sub>B</sub> >y<sub>C</sub>) ≥ α where α is a cutoff probability.
* By assuming independence, the test becomes P(y<sub>B</sub> > y<sub>A</sub>)∗P(y<sub>B</sub> >y<sub>C</sub>) ≥ α.
* In assessing end-point values (such as ’A’ and ’C’ in the 3-value example), one can assume circularity and test on one side with the opposite endpoint, and on the other with the neighboring value as follows: P(y<sub>A</sub> >y<sub>C</sub>)∗P(y<sub>A</sub> >y<sub>B</sub>)≥α and P(y<sub>C</sub> >y<sub>B</sub>)∗P(y<sub>C</sub> >y<sub>A</sub>)≥α. 
