# ProjectAssigment
This Script must be located in the same folder that UCI HAR Dataset
It takes Test and Train values and creates two Dataframes. Both with same structure:
  Subject_id. Column extracted from Subject_Datasets. It is a numeric value that defines the Subject of the test.
  Activity. Column extracted from Y_Datasets. It is the code of the activity.
  Observation. Column extracted from X_Datasets. It is the numeric value of the test.
  Experiment. It is a new column that indicates if it is the training or the testing. 
Then it merges to one Dataset. 
In order to be more readable the Activity code is replace with its label from Activity_labels.txt

Another Dataframe is created in order to operate in this one. 
The new Dataframe is gruped by experiment, activity and subject and it shows the mean and standard desviation from the differents observations. 
