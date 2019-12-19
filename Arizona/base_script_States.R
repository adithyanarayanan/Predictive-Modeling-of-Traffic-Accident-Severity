# Creates a USA Dataset and cleans up
# Selectes relevant variable names
# removes NAs
# balances the data

rm(list=ls())


library(ROSE)
library(unbalanced)
library(DataExplorer)
library(plyr)

set.seed(123)

main_data = read.csv("US_Accidents_May19.csv")
df1 = main_data
count(df1$Severity) #checking for balance of data

# x    freq
# 1 0      17
# 2 1     814
# 3 2 1455524
# 4 3  715582
# 5 4   72002



#selecting useful variables
augmented_sample = df1[c(4,18,24:31, 33:44)] 
augmented_sample = augmented_sample[c(1,2,3,5:9, 11:22)] #removing two more columns due to a large number of missing values
colnames(augmented_sample)

#cleaning up factorizations
augmented_sample$Severity = factor(augmented_sample$Severity)
augmented_sample$Wind_Direction = factor(augmented_sample$Wind_Direction)
augmented_sample$Amenity = factor(augmented_sample$Amenity)
augmented_sample$Bump = factor(augmented_sample$Bump)
augmented_sample$Crossing = factor(augmented_sample$Crossing)
augmented_sample$Give_Way = factor(augmented_sample$Give_Way)
augmented_sample$Junction = factor(augmented_sample$Junction)
augmented_sample$No_Exit = factor(augmented_sample$No_Exit)
augmented_sample$Railway = factor(augmented_sample$Railway)
augmented_sample$Roundabout = factor(augmented_sample$Roundabout)
augmented_sample$Station = factor(augmented_sample$Station)
augmented_sample$Stop = factor(augmented_sample$Stop)
augmented_sample$Traffic_Calming = factor(augmented_sample$Traffic_Calming)
augmented_sample$Traffic_Signal = factor(augmented_sample$Traffic_Signal)

str(augmented_sample)







#removing all NA values
usdf = augmented_sample
str(usdf)

#Making a two class problem

##level_0
data_0<-usdf[usdf$Severity==0,]
data_0$Severity<-as.factor(data_0$Severity)
##level_1
data_1<-usdf[usdf$Severity==1,]
data_1$Severity<-as.factor(data_1$Severity)
##level_2
data_2<-usdf[usdf$Severity==2,]
data_2$Severity<-as.factor(data_2$Severity)
##level_3
data_3<-usdf[usdf$Severity==3,]
data_3$Severity<-as.factor(data_3$Severity)
##level_4
data_4<-usdf[usdf$Severity==4,]
data_4$Severity<-as.factor(data_4$Severity)

data_NF<-rbind(data_2,data_1, data_3)
data_F<-rbind(data_4)

data_NF$Sig<-"Not Significant"
data_NF$Sig<-as.factor(data_NF$Sig)

data_F$Sig<-"Significant"
data_F$Sig<-as.factor(data_F$Sig)

UnBalanced_data<-rbind(data_NF,data_F) #USA DataFrame only

# 
# #now balancing data
# count(UnBalanced_data$Sig)
# bdf1<-ovun.sample(Sig~.,data = UnBalanced_data,method = "under")$data
# count(bdf1$Sig)



UnBalanced_data$Severity = NULL
usa = UnBalanced_data
colnames(usa)

usa$State = factor(usa$State)
usa$Wind_Direction = factor(usa$Wind_Direction)
usa$Amenity = factor(usa$Amenity)
usa$Bump = factor(usa$Bump)
usa$Crossing = factor(usa$Crossing)
usa$Give_Way = factor(usa$Give_Way)
usa$Junction = factor(usa$Junction)
usa$No_Exit = factor(usa$No_Exit)
usa$Railway = factor(usa$Railway)
usa$Roundabout = factor(usa$Roundabout)
usa$Station = factor(usa$Station)
usa$Stop = factor(usa$Stop)
usa$Traffic_Calming = factor(usa$Traffic_Calming)
usa$Traffic_Signal = factor(usa$Traffic_Signal)


# usa is the final, cleaned up and balanced data frame
# we rename if to usa for ease
str(usa)

AZ = subset(usa, grepl("Arizona|AZ", usa[,1]))
# Penn = subset(usa, grepl("Pennsylvania|PA", usa[,1]))


## Washington

state_AZ = na.omit(AZ)
str(state_AZ)
state_AZ$State = factor(state_AZ$State)
state_AZ$State = NULL

state_AZ$Wind_Direction = factor(state_AZ$Wind_Direction)
state_AZ$Amenity = factor(state_AZ$Amenity)
state_AZ$Bump = factor(state_AZ$Bump)
state_AZ$Crossing = factor(state_AZ$Crossing)
state_AZ$Give_Way = factor(state_AZ$Give_Way)
state_AZ$Junction = factor(state_AZ$Junction)
state_AZ$No_Exit = factor(state_AZ$No_Exit)
state_AZ$Railway = factor(state_AZ$Railway)
state_AZ$Roundabout = factor(state_AZ$Roundabout)
state_AZ$Station = factor(state_AZ$Station)
state_AZ$Stop = factor(state_AZ$Stop)
state_AZ$Traffic_Calming = factor(state_AZ$Traffic_Calming)
state_AZ$Traffic_Signal = factor(state_AZ$Traffic_Signal)

str(state_AZ)
count(state_AZ$Sig)

balanced_state_AZ <- ovun.sample(Sig~.,data = state_AZ, method = "under")$data

count(balanced_state_AZ$Sig)
str(balanced_state_AZ)

balanced_state_AZ$Wind_Direction = factor(balanced_state_AZ$Wind_Direction)
balanced_state_AZ$Amenity = factor(balanced_state_AZ$Amenity)
balanced_state_AZ$Bump = factor(balanced_state_AZ$Bump)
balanced_state_AZ$Crossing = factor(balanced_state_AZ$Crossing)
balanced_state_AZ$Give_Way = factor(balanced_state_AZ$Give_Way)
balanced_state_AZ$Junction = factor(balanced_state_AZ$Junction)
balanced_state_AZ$No_Exit = factor(balanced_state_AZ$No_Exit)
balanced_state_AZ$Railway = factor(balanced_state_AZ$Railway)
balanced_state_AZ$Roundabout = factor(balanced_state_AZ$Roundabout)
balanced_state_AZ$Station = factor(balanced_state_AZ$Station)
balanced_state_AZ$Stop = factor(balanced_state_AZ$Stop)
balanced_state_AZ$Traffic_Calming = factor(balanced_state_AZ$Traffic_Calming)
balanced_state_AZ$Traffic_Signal = factor(balanced_state_AZ$Traffic_Signal)

str(balanced_state_AZ)
