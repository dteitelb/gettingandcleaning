run_analysis<-function() {
        #download and unzip file if it is not already present
        setwd("~/")
        if(!dir.exists("./temp")) dir.create("./temp")
        setwd("./temp")
        if(!file.exists("temp.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","temp.zip")
                unzip("temp.zip")
        }
        setwd("./UCI HAR Dataset")
        ##start reading in data
        activities<-read.table("activity_labels.txt",stringsAsFactors = F)
        features<-read.table("features.txt",sep=" ",stringsAsFactors = F)
        cols<-grep("mean[^F]|std",features[,2]) ##selects columns
        subjects<-read.table("train/subject_train.txt")
        x<-read.table("train/x_train.txt")[,cols] ##only keeps means and stds
        y<-read.table("train/y_train.txt")
        y<-activites$V2[y[,1]]
        train<-cbind(subjects,y,x) ##joins subjects, activities, and data
        ##repeat steps for test tables
        subjects<-read.table("test/subject_test.txt")
        x<-read.table("test/x_test.txt")[,cols]
        y<-read.table("test/y_test.txt")
        y<-activites$V2[y[,1]]
        test<-cbind(subjects,y,x)
        data<-rbind(train,test) ##merges train and test tables
        coln<-features[cols,2] ##names of the selected columns
        ##make the activity names more readable and descriptive
        coln<-tolower(coln) ##course recommends lowercase names
        coln<-gsub("bodybody","body",coln) #fixes a typo (repeat word)
        coln<-gsub("acc"," accelaration ",coln)
        coln<-gsub("gyro"," angular velocity ",coln)
        coln<-sapply(coln,function(x) ifelse(grepl("mag",x),paste0(x,"-magnitude"),paste(x,"direction")))
        coln<-gsub("mag[^n]","-",coln)
        coln<-sapply(coln,function(x) ifelse(grepl("^t",x),paste(x,"(time)"),paste(x,"(frequency)")))
        coln<-gsub("^[ft]","",coln)
        coln<-gsub("\\(\\)"," ",coln)
        coln<-gsub("[ ]?\\-"," - ",coln)
        colnames(data)<-c("subject","activity",coln) ##apply descriptive names
        data<-group_by(data,activity,subject) ##selects fields to group by 
        summarize_each(data,funs(mean)) ##creates 2nd tidy table with means
}