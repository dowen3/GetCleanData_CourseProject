This script uses the dataset from the 

Human Activity Recognition Using Smartphones Dataset Version 1.0
Dataset authors:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

This script takes in the subject (1-30), activity (walking, sitting, etc.) and data values (acceleration and angular velocity data collected by smartphones) into R and organizes it into a single data frame. This integrates data from the test group and train group. Previously, each of these pieces of data were stored in separate files. Each row of data is designated as belonging to either test or train (subjects 1-30 were randomly assigned to each group, 70% & 30%, train & test respectively).

Each piece of data (subject, activity, motion data) is read into R and organized by either the test or train group. The activity is turned from a numeric value to a descriptive R factor. 

A new data frame is created using the subject vector as the first column followed by the activity factor as the second column. The third column is an indicator of whether the subject was in the test or train group. The remaining columns are taken from the full motion data.

A subset from this data frame is extracted (all mean and standard deviation values for the various motion components). This data is then averaged for each subject and activity combination to create a short summary of the total motion data.
