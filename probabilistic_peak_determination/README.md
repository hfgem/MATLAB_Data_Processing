# MATLAB_Data_Processing

Author: Hannah Germaine

Summary: This repository contains a collection of MATLAB programs written to analyze the number of peaks in a cell's response.

Detail:

# generated_cell_data.mat

The file contains an example dataset for analysis. The dataset contains a summary of electrode readings in the following format: row 1 is the presented value, row 2 is the mean response, and row 3 is the standard deviation of response.

# peak_analysis.m

This program analyzes the summarized electrode readings data for number and location of peak response. Below is the generalization:

For each cell, the probabilistic preferred response to a presented value (henceforth called a “peak”) was tested using the following assessment:
* Let the set of presented SFs be ordered by increasing value and labeled alphabetically. Thus, if there were 3 presented spatial frequencies, they would be labeled A, B, C, with A labeling the smallest value, and C the largest. 
* Next let the range of response to the presented SFs be denoted y<sub>A</sub>, y<sub>B</sub>, y<sub>C</sub>, ···. 
* For a peak to occur, in a 3-SF example, it is desired that the range of response values to B to be significantly greater than the responses to A and C, in other words
P(y<sub>B</sub> >y<sub>A</sub>, y<sub>B</sub> >y<sub>C</sub>) ≥ α where α is a cutoff probability.
* By assuming independence, the test becomes P(y<sub>B</sub> > y<sub>A</sub>)∗P(y<sub>B</sub> >y<sub>C</sub>) ≥ α.
* In assessing end-point SFs (such as ’A’ and ’C’ in the 3-SF example), one can assume circularity and test on one side with the opposite endpoint, and on the other with the neighboring SF as follows: P(y<sub>A</sub> >y<sub>C</sub>)∗P(y<sub>A</sub> >y<sub>B</sub>)≥α and P(y<sub>C</sub> >y<sub>B</sub>)∗P(y<sub>C >y<sub>A</sub>)≥α. 
