# From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

projectData<-read.csv(file="projectData.csv",header=TRUE,check.names=FALSE) 

q=aggregate(. ~ activity+subject, data=projectData, FUN=mean)

names(q)[-1:-2]=paste0("mean_",names(q)[-1:-2])

write.table(q,file="courseProjectTask5.txt",row.names = FALSE)
              

               