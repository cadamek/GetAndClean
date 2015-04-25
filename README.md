# Data analysis
## Important
If You want to run the script, make sure that the package reashape2 is installed on Your computer.
## Original data
Following files were used for the analysis:

* X\_test.txt, X\_training.txt - Preprocessed data for each individuell measurement

* y\_test.txt, y\_training.txt - Activity oerformed, while measurement was done (numbers 1 to 6)

* subject\_test, subject\_training - Indicate the subject (individual), for which the measurement was done (as number)

* activity\_labels.txt - Meaningful names for the activities

* features.txt - Meaningful names for the kind of measurements

## Analysis
Following steps were performed during the analysis:

1. Download the original data (zip-archive)

2. Extract the relavant data (see above) into data frames

3. Append the test and training data

4. Change the varable names of the measures (X) according to features

5. Change the numbers in y to meaningful names according to activity

6. Create the complete tidy data set by appending the columns for subject and activity (y) to the measurements (X)

7. Transform to long form using reshape2 melt function. Change variable names

8. Using reshape2 dcast function calculate the means per subject and activity

9. Again transform to long form

10. Write data file

