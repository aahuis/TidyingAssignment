This is the code book for the tidy dataset created as part of the "Getting and cleaning data" Assignment.
It describes the variables of the dataset and their possible values.

For a description of the raw data set and its variables please see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and especially features_info.txt

Dataset Name:         tidy_df
Observations:         3160
Variables:            11

"Subject" :           Integer
      A number representing the person who performed the measurement.

"Activity" :          Factor, possible values LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
      Each activity is a description of the type of physical activity performed during the measurement.

"measure" :           Numeric
      Numbers representing the values measured.

"dimension" :         String, possible values "X"   "Y"   "Z"   "ALL"
      "X" indicates that the measurement applies for the x-axis
      "Y" indicates that the measurement applies for the y-axis
      "Z" indicates that the measurement applies for the z-axis
      "ALL" indicates that no particular axis applies
                      
"type_computation" :  String, possible values "MEAN" "STD" 
      "MEAN" if the measurement value has been obtained through a mean computation
      "STD" if the measurement has been obtained through a standard deviation computation
      
"typetime" :          String, possible values "t" "f"
      "t" stands for time-series
      "f" stands for Fourier related measures
      
"type_measure" :      String, possible values "Acc"  "Gyro"
      "Acc" stands for Acceleration related measurement
      "Gyro" stands for Gyrometric related measurement
      
"body_vs_gravity"     String, possible values "B"   "G"
      "B" stands for Bosy-related movement and measurement
      "G" stands for Gravity-related component

"mag":                Boolean 
      TRUE when the value is a Magnitude one
      FALSE when the value is not MAgnitude
      
"jerk":               Boolean
      TRUE when Jerk-signals have been applied
      FALSE when no jerk signals were applied

"freq":               Boolean
      TRUE when Frequency has been separated
      FALSE when no Frequency computation took place

