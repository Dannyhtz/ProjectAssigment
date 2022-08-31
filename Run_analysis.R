#opening libraries
library(dplyr)
library(stringr)
library(tidyr)

#Getting acces to the data
acces<-"./UCI HAR Dataset"
extension=".txt"
list_type=c("train","test")

#Obtaining raw Data
a<-0
for (type in list_type){
    file_x<-paste0("X_",type)
    file_y<-paste0("y_",type)
    file_subject<-paste0("subject_",type)
  
  
    final_path_x<-paste0(acces,"/",type,"/",file_x,extension)
    final_path_y<-paste0(acces,"/",type,"/",file_y,extension)
    final_path_subject<-paste0(acces,"/",type,"/",file_subject,extension)
    #-------x----------
    file_data_x<-file(final_path_x)
    data_x<-readLines(file_data_x)
    close.connection(file_data_x)
    
    col_df_x<-as.numeric(unlist(strsplit(data_x," ")))
    col_df_x<-col_df_x[!is.na(col_df_x)]
    
    #-------y----------
    file_data_y<-file(final_path_y)
    data_y<-readLines(file_data_y)
    close.connection(file_data_y)
    
    col_df_y<-as.numeric(unlist(strsplit(data_y," ")))
    col_df_y<-col_df_y[!is.na(col_df_y)]
    
    #-------subject----------
    file_data_subject<-file(final_path_subject)
    data_subject<-readLines(file_data_subject)
    close.connection(file_data_subject)
    
    col_df_subject<-as.numeric(unlist(strsplit(data_subject," ")))
    col_df_subject<-col_df_subject[!is.na(col_df_subject)]
    if (a==0){
      train_df<-data.frame(col_df_subject,col_df_y,col_df_x)}
    else{
      test_df<-data.frame(col_df_subject,col_df_y,col_df_x)
    }
    a<-a+1
}

#Cleaning Raw Data
names(train_df)<-c("Subject_id","Activity","Observation")
names(test_df)<-c("Subject_id","Activity","Observation")

train_df<-train_df %>%
  as_tibble() %>%
  mutate(train_df,Experiment="Train")

test_df<-test_df %>%
  as_tibble() %>%
  mutate(test_df,Experiment="Test")

#Merging Tidy Data
mergedf<-bind_rows(train_df,test_df)

#Removing all objects but mergedf
rm(list=setdiff(ls(),"mergedf"))

#Opening activity labels
labels<-readLines(file("./UCI HAR Dataset/activity_labels.txt"))
close.connection(file("./UCI HAR Dataset/activity_labels.txt"))

#Renaming Activities
mergedf$Activity<-as.character(mergedf$Activity)
for (index in seq(length(labels))){
  mergedf$Activity<-replace(mergedf$Activity,mergedf$Activity==index,labels[index])
}
#Operating with tidy Data in new DF
df_edited<-mergedf %>% 
  group_by(Experiment,Activity,Subject_id) %>%
  summarize(MD=mean(Observation),SD=sd(Observation))
df_edited

